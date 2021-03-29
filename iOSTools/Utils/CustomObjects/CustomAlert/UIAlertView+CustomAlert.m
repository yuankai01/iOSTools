//
//  UIAlertView+CustomAlert.m
//  NewOneCard
//
//  Created by magicmac on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+CustomAlert.h"

@implementation UIAlertView (CustomAlert)
// 删除以前弹出的alert
- (void)showAndDeleteBeforeAlert {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[UIAlertView class]]) {
            UIAlertView *alertView = (UIAlertView *)view;
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    [self show];
}

// 如果当前已经弹出的有alert，则不会弹出。
- (void)showOnlyWithoutBeforeAlert {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[UIAlertView class]]) {
            return;
        }
    }

    [self show];
}

#pragma mark - // alertView,不添加方法，只有一个按钮；
+ (void)showAlertViewWithTitle:(NSString *) title
                       message:(NSString *) message
             cancelButtonTitle:(NSString *)buttonTitle{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:buttonTitle
                                              otherButtonTitles:nil];
    [alertView showAndDeleteBeforeAlert];
    [alertView release];
}

@end


@implementation CustomAlertView

@synthesize buttonPressedBlock = _buttonPressedBlock;

- (void)dealloc
{
    [super dealloc];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitles:(NSString *)sureButtonTitles buttpnPressedBlock:(AlertViewButtonPressedBlock )alertViewButtonPressed {
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:cancelButtonTitle
              otherButtonTitles:sureButtonTitles,nil];
    if (self) {
        self.buttonPressedBlock = nil;
        self.buttonPressedBlock = alertViewButtonPressed;
    }
    return self;
}
// alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if (alertView &&  self.buttonPressedBlock != nil) {
        self.buttonPressedBlock(alertView,buttonIndex);
    }
}


@end

