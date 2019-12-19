//
//  PopBlackBgView.h
//  CETCHospital
//
//  Created by gao on 16/11/10.
//  Copyright © 2016年 Aaron Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopBlackBgView : UIView
{
    UIView *popBgView;      //白色弹出背景
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,copy) void (^touchView) (void);

- (void)show;
- (void)hidden;

@end
