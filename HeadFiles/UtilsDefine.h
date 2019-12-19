//
//  UtilsDefine.h
//  CpicPeriodicaliPad
//
//  Created by magicmac on 12-9-3.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#ifndef CpicPeriodicaliPad_UtilsDefine_h
#define CpicPeriodicaliPad_UtilsDefine_h


//// 屏蔽输出
//
//#ifdef DEBUG
//#   define ILog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
//#   define DLog(...) NSLog(__VA_ARGS__)
//#   define ELog(err) if(err) ILog(@"%@", err)}
//#else
//#   define ILog(...)
//#   define DLog(...) /* */
//#   define ELog(err)
//#endif
//
//// ALog always displays output regardless of the DEBUG setting
//#define ALog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);};

// 安全release
#define RELEASE_SAFELY(__POINTER) if(__POINTER){ [__POINTER release]; __POINTER = nil; }
#define DLog(...) NSLog(__VA_ARGS__)

//
//// resource path
//#define kResourcePath(__Name,__Type) {[[NSBundle mainBundle] pathForResource:__Name ofType:__Type]}

//颜色
#define RGB(r,g,b)  [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b /255.0 alpha:1]
#define RGBA(r,g,b,a)  [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b /255.0 alpha:a]

//RGB color macro,如：self.window.backgroundColor = UIColorFromRGB(0x067AB5);
#define UIColorFrom0xRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFrom0xRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

//图像
#define defineImage(image)  [UIImage imageNamed:image]
//字体
#define defineCustomFontSize(asize) [UIFont fontWithName:@"--unknown-1--" size:asize]
#define defineSystemFontSize(size)  [UIFont systemFontOfSize:size]

//字体大小
#define defineFont_tableViewTitle defineCustomFontSize(20)
#define defineFont_smallCellBtn defineCustomFontSize(15)
#define defineFont_commonBtn defineCustomFontSize(18)
#define defineFont_phoneCaptchaCode defineCustomFontSize(12)
/*
 tableViewTitle 20
 button 18
 cell 15
 协议 转赠按钮 15
 短信验证码 button 12
 
 */
//字体颜色
#define defineTextColor_content   RGB(124, 129, 139)
#define defineTextColor_title   RGB(246,136,4)
#define defineTextColor_smallTitle   RGB(172,146,110)
#define defineTextColor_tabBar   RGB(168,168,168)
#define defineTextColor_tabBarDown   RGB(255,168,0)
#define defineTextColor_state  RGB(241,44,6)

#define defineTextColor_tableViewCell  RGB(54, 56, 60)
#define defineTextColor_tableViewCellSelected  RGB(246,136,4)
#define defineTextColor_tableViewCellUnSelected  RGB(85,85,85)
#define defineTextColor_tableViewCell_placeHolder  RGB(189,182,177)

// 获取系统版本，e.g.  4.0 5.0
#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
// 获取设备名称,如:ipone,ipad.
#define kDeviceName  [[UIDevice currentDevice] model]

//使用于模拟器和真机
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)


#define MyAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
// 判断string是否为空 nil 或者 @""；
#define IsNilString(__String) (__String==nil || [__String isEqualToString:@""])

#pragma mark - 屏幕大小
//(常用)屏幕的总高度和宽度.包括状态栏和导航栏，在整个生命周期中保持不变
#define mainScreenBounds [[UIScreen mainScreen] bounds]
#define mainScreenWidth [UIScreen mainScreen].bounds.size.width
#define mainScreenHeight [UIScreen mainScreen].bounds.size.height

#define mainScreenBoundsHeightWithoutKeyboard mainScreenHeight - 216

// 应用的高度，不包含状态栏,但包含导航栏
#define kScreenFrame [UIScreen mainScreen].applicationFrame
#define kAppHeight kScreenFrame.size.height
#define kAppHeightWithoutNav kAppHeight-44.0 //不包含导航栏的高度

//当前视图宽高,在viewDidLoad方法中不包含状态栏,但包含导航栏和tabBar,在viewWillAppear方法中状态栏 导航栏 tabBar都不包括
#define CurrentViewWidth  self.bounds.size.width
#define CurrentViewHeight  self.bounds.size.height

//IOS7系统中，由于状态栏高度为0，导航栏为20 + 44 = 64，所以在viewDidLoad方法中，高度等于屏幕高度，但是在viewWillAppear方法中，高度任然要减去导航栏的高度，但是不包括tabBar的高度了.. 所以，综上所述，还是用 [[UIScreen mainScreen] bounds] 定义视图frame 比较方便。tabBar 高度49.
#define CurrentCtrlViewWidth  self.view.bounds.size.width
#define CurrentCtrlViewHeight  self.view.bounds.size.height 

//*************
// 自动适应 arc 和 非arc
// strong/weak  对应  retain/assign
//#ifndef Y_STRONG
//#if __has_feature(objc_arc)
//#define Y_STRONG strong
//#else
//#define Y_STRONG retain
//#endif
//#endif
//
//#ifndef Y_WEAK
//#if __has_feature(objc_arc_weak)
//#define Y_WEAK weak
//#elif __has_feature(objc_arc)
//#define Y_WEAK unsafe_unretained
//#else
//#define Y_WEAK assign
//#endif
//#endif
//
//// autorelease/release/retain 。copy 不用定义，arc和非arc一样。
//#if __has_feature(objc_arc)
//#define Y_AUTORELEASE(exp) exp
//#define Y_RELEASE(exp) exp
//#define Y_RETAIN(exp) exp
//#else
//#define Y_AUTORELEASE(exp) [exp autorelease]
//#define Y_RELEASE(exp) RELEASE_SAFELY(exp)
//#define Y_RETAIN(exp) [exp retain]
//#endif
//
//
//// resource path
//#define kResourcePath(__Name,__Type) {[[NSBundle mainBundle] pathForResource:__Name ofType:__Type]}


#endif
