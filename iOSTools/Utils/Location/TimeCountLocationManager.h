//
//  TimeCountLocationManager.h
//  CustomUpdateLocaiontTest
//
//  Created by Apple on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//  本类是一个CLLocationManager的二次封装。主要实现计时定位功能。
//  例如在需要定位时，判断距上次定位成功的时间大于kTimeCount才重新定位。否则继续用上次定位的坐标。
//  
//  加入了解析位置的方法。

/*
 
 将以下代码复制到***-Prefix.pch文件中。发布时可屏蔽输出NSLog函数。
 去掉 #define DLog(...) 后面的星号，改为注释的样式。
 
 #ifdef DEBUG
 #    define DLog(...) NSLog(__VA_ARGS__)
 #else
 #    define DLog(...) 
 #endif
 #define ALog(...) NSLog(__VA_ARGS__)
*/

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"
#import <MapKit/MapKit.h>

#define kTimeCount 0.1*60  //  定位之间的计时间隔。单位（s）若是分钟，则写 min * 60sec;
#define kTimeKey @"lastTime"   // 保存定位成功时的时间key
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]

#define kKeyLocalCityName @"cityName"

//#define kKeyLocalCityId @"cityId"

// 解析位置方法分类，拥有delegate的返回值。
typedef enum reverseType {
    mkReverseType = 0,
    clGeocoderType = 1,
    googleReverseType = 2
}ReverseType;


@protocol TimeCountLocationDelegate <NSObject>
@optional
- (void)TCUpdateLocationManager:(CLLocationManager *)manager
            didUpdateToLocation:(CLLocation *)newLocation
                   fromLocation:(CLLocation *)oldLocation ;
- (void)TCUpdateLocationManager:(CLLocationManager *)manager
               didFailWithError:(NSError *)error;

/* 解析成功，
 geocoder:如果是MKReverseGeocoder,则geocoder返回geocoder;
若是CLGeocoder,则返回clGeocoder;若是googleReverse,则返回nil;
 
 type,解析方法标识。
 
 placemark,解析成功后的地理位置信息。
 
 如果是MKReverseGeocoder 或者 CLGeocoder,则placeMark为：
 placemark.addressDictionary;
 
 如果是 googleReverse,则placeMark为：NSDictionary,
 NSDictionary的内容为：
 NSString *cityName = [self cityNameFromGoogleReverseAddress:address];
 NSString *address = [self googleReverseGeocoderWithData:result];
 NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:address,@"address",
 cityName,@"cityName" ,nil];
 
*/
- (void)TCReverseGeocoder:(id)geocoder 
              reverseType:(ReverseType)type 
         didFindPlacemark:(NSDictionary *)placemark;
- (void)TCReverseGeocoder:(id)geocoder 
              reverseType:(ReverseType)type 
         didFailWithError:(NSError *)error;

@end

@interface TimeCountLocationManager : NSObject<CLLocationManagerDelegate,MKReverseGeocoderDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    MKReverseGeocoder *reverseGeocoder;  
    //
    // MKReverseGeocoder is now deprecated.
    // Use CLGeocoder in CoreLocation instead.
    CLGeocoder *clGeocoder;
    
    // delegate
    id<TimeCountLocationDelegate>delegate;
    
    ReverseType _reverseType;
    
    NSMutableData *_googleReverseResult;
    
    NSString *_cityCodeType; // 为市 or 英文city
}
@property (nonatomic,assign) id<TimeCountLocationDelegate>delegate;
@property (nonatomic,copy) NSMutableData *googleReverseResult;


// 单一实例
+ (TimeCountLocationManager *)sharedTimeCountLocationManager;

// Start the location manager.返回bool值，标示是否进行了定位，如果没有过时间差，不进行定位，返回NO。反之返回YES。
// 如果为NO，则自己取过去定位的坐标，位置等信息。
- (BOOL)startToUpdateLocation ;


// 当前定位时的时间，附带存储坐标
- (void)saveUpdateLocationTimeWithLatitude:(double)latitude longitude:(double)longitude;

// 把系统的解析的字典，换成address的string形式，以便显示。
- (NSString *)addressFromReverseGeocoderPlacemark:(NSDictionary *)placeDic;

// 开始解析位置，封装ios5和ios5以下不同的解析方法
- (void)startToReverseGeocoderWithCoordinate:(CLLocation *)location;

// ios5一下的解析方法
-(void)reverseGeocoderWithCoordinate:(CLLocation *)location;

// ios5以上的解析位置方法。
- (void)locationAddressWithLocation:(CLLocation *)locationGps;

/* google的解析方法。在系统解析方法失败后调用。
 */
- (void)googleReverseGeocoderWithCoordinate:(CLLocationCoordinate2D)coordinate;

/* google的解析方法。将返回的data数据解析成address街道信息。
 */
- (NSDictionary *)googleReverseGeocoderWithData:(NSData *)result;

@end
