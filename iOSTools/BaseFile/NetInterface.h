//
//  NetInterface.h
//  Colourful
//
//  Created by MagicPoint on 13-9-26.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
/*
 添加第三方类：ASIHTTP / MD5 / MBProgressHUD /SBJSON
 添加对应的库：ASIHttpRequest,需要添加的5个库文件:CFNetwork.framework,SystemConfiguration.framework, MobileCoreServices.framework,libxml2.2.dylib和libz.1.2.3.dylib这几个类库.最后在build seting 中的 Header search paths 中添加 /usr/include/libxml2。
*/

#import <Foundation/Foundation.h>
#import"Reachability.h" //添加SystemConfiguration.framework
#import "ASIFormDataRequest.h"
#import "SBJsonWriter.h"
#import "SBJsonParser.h"
//#import "SBJson.h"

#import "MD5.h"
#import "MBProgressHUD.h"

@interface NetInterface : NSObject<MBProgressHUDDelegate>
{
    // 缓冲动画
    MBProgressHUD *_mbHud;
    int _mbHudCount; // 如果 mgHud 存在，调用的次数，相当于 retainCount
    BOOL _isShowMBHud;  // 是否显示动画，默认显示,如果改为
}

//单例
+(NetInterface *)sharedNetInterface;

//********************************************************
#pragma mark - 检测可用的网络环境 当前是否连入3G或wifi。 连接状态实时通知
- (BOOL)isNetWorkUseable;

#pragma mark - // 添加状态栏网络图标
- (void)showStatusBarNetworkActivity;
- (void)hideStatusBarNetworkActivity;

#pragma mark - // 显示 网络动画
- (void)showHudProgress;
- (void)hideHudProgress;

#pragma mark - 获取应用程序名称和版本号
-(CGFloat)getAppVersionFromLocation; //获取当前app版本
-(CGFloat)getAppVersionFromWebServer:(NSString *)strUrl;//从服务器获取最新app版本

#pragma mark -// 网络请求
- (ASIFormDataRequest *)requestInterfaceID:(NSString *)requestID andRequestDictionary:(NSDictionary *)requestDic;

//解析从服务器返回的JSON数据 添加第三方库文件SBJSON  添加头文件 #import "SBJsonParser.h"
- (NSDictionary *)parserJsonDataToDictionary:(ASIFormDataRequest *)response;

#pragma mark - 以NSDictionary的格式保存和读取数据
-(void)saveDataInDirectory:(NSString *)directory withData:(NSDictionary *)dic withRequestID:(NSString *)requestID;
//读取数据并返回NSDictionary
-(NSDictionary *)readDataFromDirectory:(NSString *)directory withRequestID:(NSString *)requestID;

@end
