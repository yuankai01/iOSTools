//
//  AlertSheetController.h
//  CETCHospital
//
//  Created by gao on 16/4/26.
//  Copyright © 2016年 Aaron Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AlertSheetType)
{
    AlertSheetType_Sheet        = 0,
    AlertSheetType_Alert        = 1,
};

@interface AlertSheetController : UIViewController

@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *buttonTitleColor;

#pragma mark - AlertView ************
/**
 有“确定”按钮的AlertView
 @param message 内容
 */
+ (void)showOKAlertMessage:(NSString *)message
            viewController:(UIViewController *)controller
               selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock;
/**
 有“确定”按钮的AlertView
 @param title 标题
 @param message 内容
 */
+ (void)showOKAlertTitle:(NSString *)title
                 message:(NSString *)message
          viewController:(UIViewController *)controller
             selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock;
/**
 @param message 内容
 @param buttonTitles 按钮标题
 @param controller 显示的控制器，可为nil
 */
+ (void)showAlertMessage:(NSString *)message
            buttonTitles:(NSArray *)buttonTitles
          viewController:(UIViewController *)controller
             selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock;
/**
 @param title 标题
 @param message 内容
 @param buttonTitles 按钮标题
 @param controller 显示的控制器，可为nil
 */
+ (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
        viewController:(UIViewController *)controller
           selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock;

#pragma mark - ActionSheet ************
//没有标题
+ (void)showActionSheetButtonTitles:(NSArray *)buttonTitles
                     withController:(UIViewController *)viewController
                        selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock;

//带标题
+ (void)showActionSheetTitle:(NSString *)title
                buttonTitles:(NSArray *)buttonTitles
              withController:(UIViewController *)viewController
                 selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock;


//#pragma mark - HUD
///**
// 无按钮的AlertView（HUD），默认停留时间为1秒
//
// @param text 内容
// */
//+ (void)showMessage:(NSString *)text;
//
///**
// 无按钮的AlertView（HUD）
//
// @param text 内容
// @param delay 停留时间
// */
//+ (void)showMessage:(NSString *)text
//         afterDelay:(NSTimeInterval)delay;

@end
