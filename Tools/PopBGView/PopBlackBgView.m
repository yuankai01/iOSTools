//
//  PopBlackBgView.m
//  CETCHospital
//
//  Created by gao on 16/11/10.
//  Copyright © 2016年 Aaron Yu. All rights reserved.
//

#import "PopBlackBgView.h"

@interface PopBlackBgView ()
{
    UIView *blackView;
}

@end

@implementation PopBlackBgView

//加载Xib文件时调取
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initView];
}

//直接初始化时调取
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self initView];
    }
    
    return self;
}

- (void)initView
{
    self.window = [UIApplication sharedApplication].keyWindow;
    self.frame = self.window.bounds;
    
    blackView = [[UIView alloc] initWithFrame:self.window.bounds];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.35;
    [self addSubview:blackView];
    [self sendSubviewToBack:blackView];
    
    popBgView = [[UIView alloc] init];
    popBgView.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        if (![touch.view isEqual:blackView]) {
            return;
        }
    }
    
    if (self.touchView) {
        self.touchView();
    }else
    [self hidden];
}

- (void)show
{
    [self.window addSubview:self];
}

- (void)hidden
{
    [self removeFromSuperview];
}

@end
