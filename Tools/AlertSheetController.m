//
//  AlertSheetController.m
//  CETCHospital
//
//  Created by gao on 16/4/26.
//  Copyright © 2016年 Aaron Yu. All rights reserved.
//

#import "AlertSheetController.h"
@interface AlertSheetController ()

@end

@implementation AlertSheetController

#pragma mark - AlertView
+ (void)showOKAlertMessage:(NSString *)message
          viewController:(UIViewController *)controller
             selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock
{
    [AlertSheetController showAlertTitle:nil message:message buttonTitles:@[@"确定"] isCancelButton:NO viewController:controller selectBlock:selectBlock];
}

+ (void)showOKAlertTitle:(NSString *)title
                 message:(NSString *)message
          viewController:(UIViewController *)controller
             selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock
{
    [AlertSheetController showAlertTitle:title message:message buttonTitles:@[@"确定"] isCancelButton:NO viewController:controller selectBlock:nil];
}


+ (void)showAlertMessage:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
        viewController:(UIViewController *)controller
           selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock
{
    [AlertSheetController showAlertTitle:nil message:message buttonTitles:buttonTitles viewController:controller selectBlock:selectBlock];
}

+ (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
        viewController:(UIViewController *)controller
           selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock
{
    [AlertSheetController showAlertTitle:title message:message buttonTitles:buttonTitles isCancelButton:YES viewController:controller selectBlock:selectBlock];
}

+ (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
        isCancelButton:(BOOL)isCancel
        viewController:(UIViewController *)controller
           selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:message attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:JK33TextColor}];
    [alertCtrl setValue:messageStr forKey:@"attributedMessage"];
    
    //背景色
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10) {
    //        UIView *firstSubview = alertCtrl.view.subviews.firstObject;
    //        UIView *alertContentView = firstSubview.subviews.firstObject;
    //
    //        for (UIView *subSubView in alertContentView.subviews) { //This is main catch
    ////            subSubView.backgroundColor = RGBACOLOR(0, 0, 0, 0.6); //Here you change background
    //        }
    //    }else{
    //        UIView *firstSubview = alertCtrl.view.subviews.lastObject;
    //        UIView *alertContentView = firstSubview.subviews.lastObject;
    //        alertContentView.layer.cornerRadius = 6;
    //        alertContentView.backgroundColor = [UIColor darkGrayColor];
    //    }
    
    for (int i = 0; i < [buttonTitles count]; i++) {
        NSString *title = buttonTitles[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     if (selectBlock) {
                                         selectBlock(i,title);
                                     }
                                     
                                     [alertCtrl dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
        //        [action setValue: [UIColor blueColor] forKey:@"titleTextColor"];
        [alertCtrl addAction:action];
    }
    
    //action
    if (isCancel) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertCtrl addAction:cancel];
    }
    
    [controller presentViewController:alertCtrl animated:YES completion:nil];
    
//    if (message.length == 0) {
//        message = @"";
//    }
//
//    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:message attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0],NSForegroundColorAttributeName:CETC_BLACK_COLOR}];
//    [alertCtrl setValue:messageStr forKey:@"attributedMessage"];
//
//    if (viewController == nil) {
//        [[CETCAlertView alertWindow] makeKeyAndVisible];
//        [[CETCAlertView alertWindow].rootViewController presentViewController:alertCtrl animated:YES completion:nil];
//    }else{
//        [viewController presentViewController:alertCtrl animated:YES completion:nil];
//    }
}

//
//+ (UIWindow *)showAlertWindow{
//
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [window setBackgroundColor:[UIColor clearColor]];
//    UIViewController*rootViewController = [[UIViewController alloc] init];
//    [[rootViewController view] setBackgroundColor:[UIColor clearColor]];
//    // set window level
//    [window setWindowLevel:UIWindowLevelAlert + 1];
//    [window setRootViewController:rootViewController];
//
//    return window;
//}
//

#pragma mark - ActionSheet ************
//没有标题
+ (void)showActionSheetButtonTitles:(NSArray *)buttonTitles
              withController:(UIViewController *)viewController
                 selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock
{
    [AlertSheetController showActionSheetTitle:nil buttonTitles:buttonTitles withController:viewController selectBlock:selectBlock];
}

//自定义按钮 ActionSheet
+ (void)showActionSheetTitle:(NSString *)title
                buttonTitles:(NSArray *)buttonTitles
              withController:(UIViewController *)viewController
                 selectBlock:(void(^)(NSInteger selectIndex,NSString *title))selectBlock
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    //更改title大小
    if (title.length > 0) {
        NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc] initWithString:title];
        [attributeTitle addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(0, attributeTitle.length)];
        [alertCtrl setValue:attributeTitle forKey:@"attributedTitle"];
    }

    for (int i = 0; i < [buttonTitles count]; i++) {
        NSString *title = buttonTitles[i];

        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     if (selectBlock) {
                                         selectBlock(i,title);
                                     }

                                     [alertCtrl dismissViewControllerAnimated:YES completion:nil];
                                 }];

        [action setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alertCtrl addAction:action];
    }

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];

    [alertCtrl addAction:cancel];

//    if (viewController == nil) {
//        [[CETCAlertView alertWindow] makeKeyAndVisible];
//        [[CETCAlertView alertWindow].rootViewController presentViewController:alertCtrl animated:YES completion:nil];
//    }else{
//    }
    [viewController presentViewController:alertCtrl animated:YES completion:nil];
}

@end
