//
//  UIAlertView+CustomAlert.h
//  NewOneCard
//
//  Created by magicmac on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (CustomAlert)

// 删除以前弹出的alert
- (void)showAndDeleteBeforeAlert;

// 如果当前已经弹出的有alert，则不会弹出。
- (void)showOnlyWithoutBeforeAlert;

#pragma mark - // alertView,不添加方法，只有一个按钮；
+ (void)showAlertViewWithTitle:(NSString *) title
                       message:(NSString *) message
             cancelButtonTitle:(NSString *)buttonTitle;

@end


typedef void(^AlertViewButtonPressedBlock)(UIAlertView *alertView,int clickedButtonIndex);

@interface CustomAlertView : UIAlertView <UIAlertViewDelegate>
{
    AlertViewButtonPressedBlock _buttonPressedBlock;
}

@property(nonatomic,assign)AlertViewButtonPressedBlock buttonPressedBlock;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitles:(NSString *)sureButtonTitles buttpnPressedBlock:(AlertViewButtonPressedBlock )alertViewButtonPressed;

@end