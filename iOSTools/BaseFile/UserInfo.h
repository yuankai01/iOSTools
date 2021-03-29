//
//  UserInfo.h
//  BaiduMap2
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
/*
 添加第三方类：#import "SFHFKeychainUtils.h" 
 
 */

#import <Foundation/Foundation.h>
#import "SFHFKeychainUtils.h"
#import <CoreLocation/CoreLocation.h>
#import "SBJsonParser.h"
#import "base64.h"

@interface UserInfo : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locManager;
}

@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userPwd;
@property (nonatomic,strong) NSString *userMobile;
@property (nonatomic,strong) NSString *userID;
@property (nonatomic,assign) NSInteger userLoginName;//用户登录名
@property (nonatomic,assign) NSInteger userSex; // 用户性别。(0:女;1:男;2:-;)
@property (nonatomic,assign) NSInteger userEmail;
@property (nonatomic,assign) CLLocationCoordinate2D userCoordinate2D;

@property (nonatomic,assign) BOOL isAutoLogin;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign) BOOL msgAlertOn;

//用户经纬度
@property (nonatomic,copy) NSString *UserLat;
@property (nonatomic,copy) NSString *UserLong;

+(UserInfo *)sharedUserInfo;

-(void)saveUserName:(NSString *)userName withUserPwd:(NSString *)userPwd withIsAutoLogin:(BOOL)isLogin;
-(void)deletePasswordForUserName:(NSString *)userName;
- (NSString *) getPasswordForUsername: (NSString *) username error: (NSError **) error;
#pragma mark - // 读取用户名，密码   FromSFHFKey
- (NSDictionary *)readUserLoginInfoFromSFHFKey;

#pragma mark - 获取用户百度坐标经纬度 
-(void)getUserLocation;

@end
