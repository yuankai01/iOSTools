//
//  UserInfo.m
//  BaiduMap2
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "UserInfo.h"
// 自动登录，存储的用户名，密码
#define kKeyLoginInfo @"loginInfo"
#define kKeyUserName @"userName"
#define kKeyPassword @"userPassword"
#define kKeyIsAutoLogin @"isAutoLogin"
// 用户信息
#define kUserInfoFileName @"userInfo.plist"
#define kUserInfo  @"userInfo"
#define kUserInfo_Name  @"userName"
#define kUserInfo_Pwd  @"userPassword"
#define kUserInfo_IsAutoLogin @"isAutoLogin"
#define kSFHFKeyUserInfoService  @"userInfoService"

@implementation UserInfo

#pragma mark - 单例
static UserInfo *sharedUserInfo = nil;

+(UserInfo *)sharedUserInfo
{
    @synchronized(self)
    {
        if (sharedUserInfo == nil) {
            sharedUserInfo = [[UserInfo alloc] init];
        }
        return sharedUserInfo;
    }
}

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - 获取用户经纬度
-(void)getUserLocation
{
    //获取用户经纬度
    locManager = [[CLLocationManager alloc] init];
    locManager.delegate = self;
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    locManager.distanceFilter = 1000.0f;
    [locManager startUpdatingLocation];
    
}

#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //输出结果:delegate==:31.210631,121.561678  转换坐标
    CLLocationCoordinate2D locCordinate2D = [self shiftCoordinateFromGPSToBaidu:newLocation.coordinate];
    DLog(@"456delegate==logoin:%f,%f",locCordinate2D.latitude,locCordinate2D.longitude);
    self.userCoordinate2D = locCordinate2D;
    
    [locManager stopUpdatingLocation];
    
    //定位成功后,调数据接口
}

//要添加base64第三方类 和 SBJsonParser,注意:不能放在.mm类中
-(CLLocationCoordinate2D)shiftCoordinateFromGPSToBaidu:(CLLocationCoordinate2D)gpsCoordinate
{
    DLog(@"GPSLocation== %.4f,== %.4f",gpsCoordinate.latitude,gpsCoordinate.longitude);
    NSString *urlString =[[NSString stringWithFormat:@"http://api.map.baidu.com/ag/coord/convert?from=0&to=4&x=%f&y=%f", gpsCoordinate.longitude, gpsCoordinate.latitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//如果转换GPS到百度则from=0
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    DLog(@"result:::: %@",result);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary* memblist=[parser objectWithString:result error:nil];
    NSString* X=[memblist objectForKey:@"x"];
    NSString* Y=[memblist objectForKey:@"y"];
    NSString *stringValue = X;
    Byte inputData[[stringValue lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    [[stringValue dataUsingEncoding:NSUTF8StringEncoding] getBytes:inputData];
    size_t inputDataSize = (size_t)[stringValue length];
    size_t outputDataSize = EstimateBas64DecodedDataSize(inputDataSize);
    Byte outputData[outputDataSize];//prepare a Byte[] for the decoded data
    Base64DecodeData(inputData, inputDataSize, outputData, &outputDataSize);
    NSData *theData = [[NSData alloc] initWithBytes:outputData length:outputDataSize];
    NSString *resultX = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    
    CLLocationCoordinate2D newCoordinate;
    newCoordinate.longitude=[resultX doubleValue];
    
    stringValue = Y;
    Byte inputData1[[stringValue lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    [[stringValue dataUsingEncoding:NSUTF8StringEncoding] getBytes:inputData1];
    inputDataSize = (size_t)[stringValue length];
    outputDataSize = EstimateBas64DecodedDataSize(inputDataSize);
    Byte outputData1[outputDataSize];
    Base64DecodeData(inputData1, inputDataSize, outputData1, &outputDataSize);
    theData = [[NSData alloc] initWithBytes:outputData1 length:outputDataSize];
    resultX = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    newCoordinate.latitude=[resultX doubleValue];
    DLog(@"BaiduCoordinate 同步==:%.4f,%.4f",newCoordinate.latitude,newCoordinate.longitude);
    
    return newCoordinate;
}

#pragma mark - //将文件写入沙盒目录中.
-(NSDictionary *)saveUserConfigsWithObject:(id)object key:(NSString *)key
{
    NSString *strFilePath = [self writeFileToDocmentPaths:kUserInfoFileName];
    NSMutableDictionary *configDic = [NSMutableDictionary dictionaryWithContentsOfFile:strFilePath];
    if (configDic == nil) {
        configDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    [configDic setObject:object forKey:key];
    
    [configDic writeToFile:strFilePath atomically:YES];
    
    return configDic;
}

-(NSString *)writeFileToDocmentPaths:(NSString *)fileNamePlist
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSLog(@"path = %@",path);
    NSString *filename=[path stringByAppendingPathComponent:fileNamePlist];
    
    return filename;
}

//读取文件内容 FromDocuments
- (NSDictionary *)readConfigsFromDocuments {
    NSMutableDictionary *configDic=[NSMutableDictionary dictionaryWithContentsOfFile:[self writeFileToDocmentPaths:kUserInfoFileName]];
    if (configDic==nil) {
        configDic=[NSMutableDictionary dictionaryWithCapacity:0];
    }
    
//    DLog(@"dataManager - configDic =  %@",configDic);
    return configDic;
}

#pragma mark -//保存用户名和密码到沙盒目录和 安全机制中
-(void)saveUserName:(NSString *)userName withUserPwd:(NSString *)userPwd withIsAutoLogin:(BOOL)isAutoLogin
{
//    DLog(@"userName == %@== %@== %d",userName,userPwd,isAutoLogin);
    //存取用户名到沙盒目录中.
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userName,kUserInfo_Name,[NSNumber numberWithBool:isAutoLogin],kUserInfo_IsAutoLogin, nil];
    [self saveUserConfigsWithObject:dic key:kUserInfo];
    
    //save to keychain
    [SFHFKeychainUtils storeUsername:userName andPassword:userPwd forServiceName:kSFHFKeyUserInfoService updateExisting:YES error:nil];
}

#pragma mark - // 读取用户名，密码   FromSFHFKey
- (NSDictionary *)readUserLoginInfoFromSFHFKey {
    NSDictionary *dic = [self readConfigsFromDocuments];
    NSMutableDictionary *loginInfo = [dic objectForKey:kUserInfo];
    if (loginInfo) {
        // 存储的用户名
        NSString *userName = [loginInfo objectForKey:kUserInfo_Name];
        NSString *password = [SFHFKeychainUtils getPasswordForUsername:userName
                                                        andServiceName:kSFHFKeyUserInfoService error:nil];
        if (password) {
            [loginInfo setObject:password forKey:kUserInfo_Pwd];
        }
        
    }
    //    DLog(@"readUserInfo == %@",loginInfo);
    return loginInfo;
}

- (NSString *) getPasswordForUsername: (NSString *) username error: (NSError **) error
{
    // 先判断，是否已经登陆过
    NSDictionary *userInfo = [self readUserLoginInfoFromSFHFKey];
    if ([username isEqualToString:[userInfo objectForKey:kUserInfo_Name]]) {
        // 用户名存在,读取密码，放入字典，返回
        NSString *password = [SFHFKeychainUtils getPasswordForUsername:username
                                                        andServiceName:kSFHFKeyUserInfoService
                                                                 error:error];
        return password;
    }else {
        return nil;
    }
}

#pragma mark - // 删除用户名，密码
- (void)deletePasswordForUserName:(NSString *)userName {
    
    // 删除密码
    [SFHFKeychainUtils deleteItemForUsername:userName
                              andServiceName:kSFHFKeyUserInfoService
                                       error:nil];
    
    // 将 config.plist 文件中的数据 置空；
    NSDictionary *loginInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"",kUserInfo_Name,[NSNumber numberWithBool:NO],kUserInfo_IsAutoLogin, nil];
    NSDictionary *dic = [self saveUserConfigsWithObject:loginInfo key:kUserInfo];
//    DLog(@"delete LoginInfo = %@",dic);
}

@end
