//
//  SystemInfo.h
//  BaiduMap2
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
/*
 添加头文件：#include<sys/sysctl.h> 、
 
 */

#import <Foundation/Foundation.h>
#include<sys/sysctl.h>

@interface SystemInfo : NSObject

+ (SystemInfo*)sharedSystemInfo;

#pragma mark - // 获取设备类型 如:ipone / ipad
-(NSString *)getDeviceType;

#pragma mark - // 获取设备型号 如:ipone4s / iphone5
-(NSString *)getDeviceTypeModel;

#pragma mark - // 获取系统版本 如:ios4.2 / ios 5.1 /  ios 6
-(NSString *)getSystemVisions;

#pragma mark - // 获取系统window
- (UIWindow *)systemWindow ;

#pragma mark - getSystemFont 包括新添加的字体
-(void)getSystemFont;

#pragma mark - 监听键盘事件
-(void)notificationKeyboard;

@end
