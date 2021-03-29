//
//  SystemInfo.m
//  BaiduMap2
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "SystemInfo.h"

@implementation SystemInfo

#pragma mark - 单例
static SystemInfo *sharedSystemInfo = nil;
+(SystemInfo *)sharedSystemInfo
{
    @synchronized(self)
    {
        if (sharedSystemInfo == nil) {
            sharedSystemInfo = [[SystemInfo alloc] init];
        }
        return sharedSystemInfo;
    }
    
}

-(id)init
{
    self = [super init];
    if (self) {

    }
    
    return self;
}

#pragma mark - //当前设备类型 如:ipone / ipad
-(NSString *)getDeviceType
{
    NSString *deviceStr = [[UIDevice currentDevice] model];
    NSLog(@"当前设备:%@",deviceStr);
    return deviceStr;
    
    CGSize sizeToRequest;
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location == 0) // 说明是ipad设备
        sizeToRequest = CGSizeMake(748, 110);
    else
        sizeToRequest = CGSizeMake(320, 48);
}

#pragma mark - //获得当前设备类型的不同型号 如:ipone4s / iphone5
- (NSString *)getDeviceTypeModel
{
    NSString *modelStr = [self hardwareDescription];
    NSLog(@"当前设备类型的型号:%@",modelStr);
    
    return modelStr;
}

- (NSString*)hardwareDescription
{
    NSString *hardware = [self hardwareString];
    NSLog(@"设备型号:%@",hardware);
    if ([hardware isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (CDMA)";
    if ([hardware isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    
    if ([hardware isEqualToString:@"iPod1,1"]) return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"]) return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"]) return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"]) return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"]) return @"iPod Touch (5 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([hardware isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if ([hardware isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([hardware isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([hardware isEqualToString:@"iPad2,6"]) return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([hardware isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    
    if ([hardware isEqualToString:@"i386"]) return @"Simulator";
    
    //    if ([hardware isEqualToString:@"x86_64"]) return @"Simulator";
    
    // Simulator thanks Jordan Breeding
    if ([hardware hasSuffix:@"86"] || [hardware isEqual:@"x86_64"])
    {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        //当前设备系统型号,是创建工程项目时选择的 是iphone还是ipad,不是用ipad模拟器跑iphone程序,或者用iphone模拟器跑ipad程序.
        return smallerScreen ? @"UIDeviceSimulatoriPhone" : @"UIDeviceSimulatoriPad";
    }
    
    return nil;
}

- (NSString*)hardwareString
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0); //在头文件中要加入#include<sys/sysctl.h>
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    
    return deviceModel;
}

#pragma mark - //系统版本 如:ios4.2 / ios 5.1 /  ios 6
-(NSString *)getSystemVisions
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSLog(@"当前IOS版本:%.1f",version);
    
    return [NSString stringWithFormat:@"%f",version];
    
    if (version >= 5.0)
    {
        //定义全局变量标记ios版本
    }
}

#pragma mark - // 获取系统window
- (UIWindow *)systemWindow {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}

#pragma mark - getSystemFont 包括新添加的字体
-(void)getSystemFont
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    
    for(indFamily=0;indFamily<[familyNames count];++indFamily)
    {
        NSLog(@"Family name: %@ ", [familyNames objectAtIndex:indFamily]);
        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        
        for(indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"  Font name: %@",[fontNames objectAtIndex:indFont]);
        }
    }
    
    NSLog(@" familyNames Count == : %d",familyNames.count);
}

#pragma mark - 监听键盘事件
-(void)notificationKeyboard
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height; //相对于屏幕总高度的位置 (x = 0,y = 352 / 或 264,width = 320,height = 216)
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;  //相对于屏幕总高度的位置 (x = 0,y = 568 / 或 480,width = 320,height = 216)
}

#pragma mark - 获取屏幕的点击位置.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    //    UITouch *touch = [touches anyObject];
    //
    //    CGPoint touchPoint = [touch locationInView:self.view];
    //
    //    NSLog(@"%f==%f",touchPoint.x,touchPoint.y);
    //    int stringFloat = (int)(touchPoint.x);
    //    int stringFloat1 = (int)(touchPoint.y);
    //    NSLog(@"%i  %i",stringFloat,stringFloat1);
    //touchPoint.x ，touchPoint.y 就是触点的坐标。
}

@end
