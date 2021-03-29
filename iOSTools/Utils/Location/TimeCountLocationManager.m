//
//  TimeCountLocationManager.m
//  CustomUpdateLocaiontTest
//
//  Created by Apple on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


/*
 
 三林世博创意园‎
 上海市浦东新区
 灵岩南路295号
 latitude:31.15673;longitude:121.49631;
 */

#import "TimeCountLocationManager.h"
#import "SBJson.h"
#import "AppLanguage.h"

@implementation TimeCountLocationManager
@synthesize delegate;
@synthesize googleReverseResult = _googleReverseResult;

static TimeCountLocationManager *sharedTimeCountLocationManager = nil;
+ (TimeCountLocationManager *)sharedTimeCountLocationManager {
    @synchronized(self){ // 防止多线程同时访问
        if (sharedTimeCountLocationManager == nil) {
            sharedTimeCountLocationManager = [[TimeCountLocationManager alloc] init];
        }
        return sharedTimeCountLocationManager;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        CurrentLanguage language = [AppLanguage getCurrentLanguage];
        switch (language) {
            case SimpleChinese:
                _cityCodeType = @"市";
                break;
            case English:
                _cityCodeType = @"City";
                break;
            default:
                _cityCodeType = @"";
                break;
        }
    }
    return self;
}

- (void)dealloc {
    if (locationManager) {
        [locationManager stopUpdatingLocation];
        [locationManager release];
    }
    if (reverseGeocoder) {
        [reverseGeocoder cancel];
        [reverseGeocoder release];
    }
    if (clGeocoder) {
        [clGeocoder cancelGeocode];
        [clGeocoder release];
    }
    if (currentLocation) {
        [currentLocation release];
        currentLocation = nil;
    }
    if (_googleReverseResult) {
        [_googleReverseResult release];
        _googleReverseResult = nil;
    }
    sharedTimeCountLocationManager = nil;
    [super dealloc];
}

#pragma mark - // 计时
- (NSString *)currentTime {
    NSDate *dt = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];  
    // df.timeStyle = kCFDateFormatterMediumStyle;  
    [df setDateFormat:@"YYYYMMddHHmmss"]; 
    NSString *dtStr = [df stringFromDate:dt];
    [df release];
    // DLog(@" currentTime == %@ ",dtStr);
    if (dtStr) {
        return dtStr;
    }else {
        return @"0";
    }
}
- (NSString *)lastTime {
    NSString *lastTime = [USERDEFAULTS objectForKey:kTimeKey];
    // DLog(@" lastTime == %@ ",lastTime);
    if (lastTime) {
        return lastTime;
    }else {
        return @"0";
    }
}
//  定位的时间差
- (long long)timeDifferenceBetweenLastTime {
    long long lastTime = [[self lastTime] longLongValue];
    long long currentTime = [[self currentTime] longLongValue];
    
    long long difference = currentTime - lastTime;
    return difference;
}
#pragma mark -
#pragma mark Location manager

/**
 Return a location manager -- create one if necessary.
 */
- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
		return locationManager;
	}
	
	locationManager = [[CLLocationManager alloc] init];
	[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	[locationManager setDelegate:self];
	
	return locationManager;
}

// Start the location manager.
- (BOOL)startToUpdateLocation {
    // 先判断是否开启定位服务。
    BOOL serviceEnabled = [CLLocationManager locationServicesEnabled];
    // 是否经过了时间差，开始定位，若没有经过时间差，则不进行定位，delegate方法不会执行。
    BOOL isUpdate = NO;
    if (serviceEnabled == YES) {
        long long timeCount = [self timeDifferenceBetweenLastTime];
        DLog(@" timeDiffenence == %lli ",timeCount);
        
        if (timeCount > kTimeCount) {
            [[self locationManager] startUpdatingLocation];
            isUpdate = YES;
            DLog(@"\n\n\n 定位 \n\n\n ");
        }
    }else {
        //  没有开启定位服务
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"定位失败" 
                                                       message:@"请开启“设置 -> 定位服务”中的相关选项" 
                                                      delegate:nil 
                                             cancelButtonTitle:@"确定" 
                                             otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
    return isUpdate;
}
// 当前定位时的时间，附带存储坐标
- (void)saveUpdateLocationTimeWithLatitude:(double)latitude longitude:(double)longitude {
    NSString *currentTime = [self currentTime];
    [USERDEFAULTS setObject:currentTime forKey:kTimeKey];
    NSString *lat = [NSString stringWithFormat:@"%f",latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",longitude];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         lat,@"latitude",lon,@"longitude", nil];
    [USERDEFAULTS setObject:dic forKey:@"lastLocation"];
    [USERDEFAULTS synchronize];
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    // stop update location
    [manager stopUpdatingLocation];
    // [[self locationManager] stopUpdatingLocation];
    
    if (currentLocation) {
        [currentLocation release];
        currentLocation = nil;
    }
    currentLocation = [newLocation copy];
    
//    currentLocation = [[CLLocation alloc] initWithLatitude:36.670071186450585 
//                                                 longitude:116.99718475341797];
    
    DLog(@" \n manager == %@ \n currentLocation = %@ \n oldLocation == %@ ",manager,currentLocation,oldLocation);
    DLog(@"\n\n\n 定位success \n\n\n ");
    
    // 存储坐标，时间
    [self saveUpdateLocationTimeWithLatitude:currentLocation.coordinate.latitude 
                                   longitude:currentLocation.coordinate.longitude];
    
    // delegate method
    if ([delegate respondsToSelector:@selector(TCUpdateLocationManager:didUpdateToLocation:fromLocation:)]) {
        [delegate TCUpdateLocationManager:manager 
                      didUpdateToLocation:currentLocation 
                             fromLocation:oldLocation];
    }
    
    //  解析地理位置
    [self startToReverseGeocoderWithCoordinate:currentLocation];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    DLog(@" 定位失败 ");
    // delegate method
    if ([delegate respondsToSelector:@selector(TCUpdateLocationManager:didFailWithError:)]) {
        [delegate TCUpdateLocationManager:manager 
                         didFailWithError:error];
    }
    
}

#pragma mark - // 开始解析位置
- (void)startToReverseGeocoderWithCoordinate:(CLLocation *)location {
//     [self googleReverseGeocoderWithCoordinate:currentLocation.coordinate];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [self locationAddressWithLocation:location];
    }else {
        [self reverseGeocoderWithCoordinate:location];
    }
}

#pragma mark - reverseGeocoder IOS 5.0 以下使用此方法。
/**
 Return a reverseGeocoder -- create one if necessary.
 */

- (MKReverseGeocoder *)reverseGeocoder:(CLLocation *)location{
    if (reverseGeocoder != nil) {
        return reverseGeocoder;
    }
    reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:location.coordinate];
    reverseGeocoder.delegate = self;
    return reverseGeocoder;
}

-(void)reverseGeocoderWithCoordinate:(CLLocation *)location{
    [[self reverseGeocoder:location] start];
    
    DLog(@" \n 开始解析位置  ");
    
    //解析并获取当前坐标对应得地址信息
}

#pragma mark MKReverseGeocoderDelegate methods

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    [geocoder cancel];
    DLog(@"-----解析位置失败---faild \n  reverseGeocoder didFailWithError: %@", error);
//    if ([delegate respondsToSelector:@selector(TCReverseGeocoder:reverseType:didFailWithError:)]) {
//        [delegate TCReverseGeocoder:geocoder reverseType:mkReverseType didFailWithError:error];
//    }
    
    
    [self googleReverseGeocoderWithCoordinate:currentLocation.coordinate];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    [geocoder cancel];
    
    NSDictionary *addressDic =[NSDictionary dictionaryWithDictionary: placemark.addressDictionary];
    DLog(@"%@",addressDic);
    NSString *cityName = [addressDic objectForKey:@"City"];
    NSRange range = [cityName rangeOfString:_cityCodeType];
    if (range.length > 0) {
         cityName = [cityName substringToIndex:range.location];
    }
   
    DLog(@"%@",cityName);
    
    // 系统的方法。
    NSString *address = [NSString stringWithFormat:@"%@%@附近",
                        [[addressDic objectForKey:@"FormattedAddressLines"]objectAtIndex:1],
                        [[addressDic objectForKey:@"FormattedAddressLines"]objectAtIndex:2]];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         cityName,kKeyLocalCityName,
                         address,@"address", nil];
    
    //  解析位置成功
    // delegate method
    if ([delegate respondsToSelector:@selector(TCReverseGeocoder:reverseType:didFindPlacemark:)]) {
        [delegate TCReverseGeocoder:nil 
                        reverseType:mkReverseType 
                   didFindPlacemark:dic];
    }
    
}

#pragma mark -//  IOS 5.0 及以上版本使用此方法
/**
 Return a clGeocoder -- create one if necessary.
 */
- (CLGeocoder *)clGeocoder {
    if (clGeocoder != nil) {
        return clGeocoder;
    }
    clGeocoder = [[CLGeocoder alloc] init];
    return clGeocoder;
}


- (void)locationAddressWithLocation:(CLLocation *)locationGps
{
    
    DLog(@" locationGps = %@ ",locationGps);
    [[self clGeocoder] reverseGeocodeLocation:locationGps 
                            completionHandler:^(NSArray *placemarks, NSError *error) 
     {
         DLog(@"error %@ placemarks count %d",error.localizedDescription,placemarks.count);
         if (error.localizedDescription) {
             // failed,use google reverse geocoder
//             if ([delegate respondsToSelector:@selector(TCReverseGeocoder:reverseType:didFailWithError:)]) {
//                 [delegate TCReverseGeocoder:nil reverseType:clGeocoderType didFailWithError:error];
//             }
             
             [self googleReverseGeocoderWithCoordinate:locationGps.coordinate];
         }else {
             //  success
             for (CLPlacemark *placeMark in placemarks) 
             {
//                 DLog(@"地址：%@",placeMark.addressDictionary);
//                 DLog(@"地址：locality == %@",placeMark.locality);
//                 DLog(@"地址：thoroughfare == %@",placeMark.thoroughfare);
//                 DLog(@"地址：subLocality == %@",placeMark.subLocality);
//                 DLog(@"地址：name == %@",placeMark.name);
                 //self.locationLabel.text = placeMark.thoroughfare;
                 
                 //  解析位置成功
                 
                 // 系统的方法。
                 NSString *address= [NSString stringWithFormat:@"%@",
                                     [[placeMark.addressDictionary objectForKey:@"FormattedAddressLines"]
                                      objectAtIndex:0]];
                 NSString *cityName = [placeMark.addressDictionary objectForKey:@"City"];
                 if (cityName && cityName.length != 0) {
                     NSRange range = [cityName rangeOfString:_cityCodeType];
                     if (range.length > 0) {
                         cityName = [cityName substringToIndex:range.location];
                     }
                     
                     //cityName = [cityName substringWithRange:NSMakeRange(0, 2)];
                     DLog( @"\n cityName == %@  ",cityName);
                 }
                 NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                      cityName,kKeyLocalCityName,
                                      address,@"address", nil];
                 // delegate method
                 if ([delegate respondsToSelector:@selector(TCReverseGeocoder:reverseType:didFindPlacemark:)]) {
                     [delegate TCReverseGeocoder:clGeocoder 
                                 reverseType:clGeocoderType 
                            didFindPlacemark:dic];
                 }
                 
             }
         }
     }];
}

#pragma mark - // 把系统的解析的字典，换成address的string形式，以便显示。
- (NSString *)addressFromReverseGeocoderPlacemark:(NSDictionary *)placeDic {
    NSString *address = nil;
    if (_reverseType == clGeocoderType) {
//        DLog(@" \n placeDic == %@",placeDic);
//        DLog(@" \n [placeDic objectForKey:@FormattedAddressLines] == %@",[[placeDic objectForKey:@"FormattedAddressLines"] objectAtIndex:0]);
        DLog(@" \n [placeDic objectForKey:Name] == %@",[placeDic objectForKey:@"Name"]);
        address= [NSString stringWithFormat:@"%@",
                             [[placeDic objectForKey:@"FormattedAddressLines"]objectAtIndex:0]];
        
    }else if (_reverseType == mkReverseType) {
        address = [NSString stringWithFormat:@"%@ %@ 附近",
                   [[placeDic objectForKey:@"FormattedAddressLines"]objectAtIndex:1],
                   [[placeDic objectForKey:@"FormattedAddressLines"]objectAtIndex:2]];
    }
    return address;
}

#pragma mark -//  google解析位置方法，在系统的解析方法失败后调用。
/*  方法一：dispatch
- (void)googleReverseGeocoderWithCoordinate:(CLLocationCoordinate2D)coordinate {
    DLog(@"google Reverse Geocoder");
    BOOL isReverseSuccess;
    isReverseSuccess = NO;
    // Show network activity Indicator (no need really as its very quick)
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // Use Google Service
    // OK the code is verbose to illustrate step by step process
    
    // Form the string to make the call, passing in lat long  &accuracy=4 &region=cn&language=zh-CN
    // http://maps.google.com/maps/geo?q=%lf,%lf&output=csv&sensor=false  为google api 第二版，现在已停用，改用第三版
    // http://maps.googleapis.com/maps/api/geocode/output?parameters
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%lf,%lf&sensor=false&region=cn&language=en", coordinate.latitude,coordinate.longitude];
    
    NSString *encodeUrl = [NSString stringWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DLog(@" google geocode == %@ ",encodeUrl);
    // Turn it into a URL
    NSURL *urlFromURLString = [NSURL URLWithString:encodeUrl];
    
    // Use UTF8 encoding
    //    NSStringEncoding encodingType = NSUTF8StringEncoding;
    
    //  更改为 异步 请求方法  
    //__block NSData *result = nil;
    // NSData *result = nil;
    //获取数据,获得一组后,刷新UI.
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:urlFromURLString 
                                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                          timeoutInterval:10];
    // 
   //__block  NSError *error;
    NSError *error;
//    NSURLResponse *response;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSError *errorTemp;
        NSURLResponse *response;
        NSData *resultTemp = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&errorTemp];
        dispatch_async(dispatch_get_main_queue(),^{
           // 回到主线程
            //error = errorTemp;
            self.googleReverseResult = resultTemp;
        });
    }
    );
    if (!_googleReverseResult || _googleReverseResult.bytes==0) {
        DLog(@"result      %@",_googleReverseResult);
        //return;
        isReverseSuccess = NO;
    }
    else {
        // json解析
        NSDictionary *reverseResult = [self googleReverseGeocoderWithData:self.googleReverseResult];
        if (reverseResult) {
            isReverseSuccess = YES;
            if ([delegate respondsToSelector:@selector(TCReverseGeocoder:reverseType:didFindPlacemark:)]) {
                
                [delegate TCReverseGeocoder:nil 
                                reverseType:googleReverseType 
                           didFindPlacemark:reverseResult];
                
            }

        }else {
            isReverseSuccess = NO;
        }
    }
    // 解析失败。
    if (isReverseSuccess == NO) {
        if ([delegate respondsToSelector:@selector(TCReverseGeocoder:reverseType:didFailWithError:)]) {
            [delegate TCReverseGeocoder:nil 
                        reverseType:googleReverseType 
                   didFailWithError:error]; 
        }
        
    }
    // Hide network activity indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
*/


- (NSDictionary *)googleReverseGeocoderWithData:(NSData *)result {
    // json解析
    NSString *reverseGeoString = [[[NSString alloc] initWithBytes:[result bytes] 
                                                           length:[result length] 
                                                         encoding:NSUTF8StringEncoding] autorelease];
    SBJsonParser *json = [[[SBJsonParser alloc] init] autorelease];
    NSError *error;
    NSDictionary *items = [json objectWithString:reverseGeoString error:&error]; 
    DLog(@" \n google result == %@  ",items);
    
    NSMutableDictionary *reverseResult = [NSMutableDictionary dictionaryWithCapacity:4];
    // 从json解析的数据中分离出需要的样式
    NSString *status = [items objectForKey:@"status"];
    if (status && [status isEqualToString:@"OK"]) {
        // 返回结果正确
        NSArray *array = [items objectForKey:@"results"];
        // 街道的字典信息。
        NSDictionary *item1 = [array objectAtIndex:0];
        // 位置
        NSString *address = [item1 objectForKey:@"formatted_address"];
        [reverseResult setObject:address forKey:@"address"];
        
        // 获取城市名
        NSString *name = nil;
        NSArray *address_components = [item1 objectForKey:@"address_components"];
        for (NSDictionary *dic in address_components) {
            NSArray *types = [dic objectForKey:@"types"];
            if ([[types objectAtIndex:0] isEqualToString:@"locality"]) {
                name = [dic objectForKey:@"long_name"];
                break;
            }
        }
        if (name) {
            if ([name hasSuffix:_cityCodeType]) {
                name = [name substringToIndex:name.length-_cityCodeType.length];
            }
        
        [reverseResult setObject:name forKey:@"cityName"];
        }
        
    }else {
        // 返回的结果错误
        DLog(@"\n 返回的结果错误 == %@ ",status);
    }
    
    return reverseResult;
}


// 方法二：NSURLConection
- (void)googleReverseGeocoderWithCoordinate:(CLLocationCoordinate2D)coordinate {
    DLog(@"google Reverse Geocoder");
    BOOL isReverseSuccess;
    isReverseSuccess = NO;
    // Show network activity Indicator (no need really as its very quick)
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // Use Google Service
    // OK the code is verbose to illustrate step by step process
    
    // Form the string to make the call, passing in lat long  &accuracy=4 &region=cn&language=zh-CN
    // http://maps.google.com/maps/geo?q=%lf,%lf&output=csv&sensor=false  为google api 第二版，现在已停用，改用第三版
    // http://maps.googleapis.com/maps/api/geocode/output?parameters
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%lf,%lf&sensor=false&region=cn&language=zh-CN", coordinate.latitude,coordinate.longitude];
    
    NSString *encodeUrl = [NSString stringWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DLog(@" google geocode == %@ ",encodeUrl);
    // Turn it into a URL
    NSURL *urlFromURLString = [NSURL URLWithString:encodeUrl];
    
    // Use UTF8 encoding
    //    NSStringEncoding encodingType = NSUTF8StringEncoding;
    
    //  更改为 异步 请求方法  
    //__block NSData *result = nil;
    // NSData *result = nil;
    //获取数据,获得一组后,刷新UI.
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:urlFromURLString 
                                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                          timeoutInterval:10];
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    if(theConnection) {
		
	}
	else {
		DLog(@"theConnection is NULL");
	}
}

- (void )connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	_googleReverseResult = [[NSMutableData alloc] init];
	[_googleReverseResult setLength:0];
}

- (void )connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_googleReverseResult appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Hide network activity indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    isReverseSuccess = NO;
    if ([delegate respondsToSelector:@selector(TCReverseGeocoder:reverseType:didFailWithError:)]) {
        [delegate TCReverseGeocoder:nil 
                        reverseType:googleReverseType 
                   didFailWithError:error]; 
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // json解析
    NSDictionary *reverseResult = [self googleReverseGeocoderWithData:_googleReverseResult];
    [_googleReverseResult release];
    _googleReverseResult = nil;
    if (reverseResult) {
//        isReverseSuccess = YES;
        if ([delegate respondsToSelector:@selector(TCReverseGeocoder:reverseType:didFindPlacemark:)]) {
            
            [delegate TCReverseGeocoder:nil 
                            reverseType:googleReverseType 
                       didFindPlacemark:reverseResult];
            
        }
        
    }
    // Hide network activity indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
@end
