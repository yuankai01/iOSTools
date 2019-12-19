//
//  BaseViewController.h
//  BaiduMap2
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//



#import <UIKit/UIKit.h>
#include<sys/sysctl.h>

@interface BaseViewController : UIViewController

#pragma mark - 系统信息 *****************
//系统信息*******************************


#pragma mark - 网络信息 *****************
//网络信息*******************************

#pragma mark - 用户信息 *****************
//用户信息*******************************

//******************************
#pragma mark - 导航栏添加切换按钮
- (void)addNavigationSwitchButton;
-(void)addNavigationRightButtonImage:(UIImage *)image withTitle:(NSString *)title andEdgeInSets:(UIEdgeInsets)inset;
#pragma mark - 重写方法
// 添加navLeft按钮
- (void)addNavigationLeftButton;
- (void)navigationLeftButtonPressed;
-(void)navigationRightButtonPress;
#pragma mark - push / pop Ctrl
-(void) pushNavigationController:(UIViewController *)controller;
- (void)popViewController:(UIViewController *)controller;

@end
