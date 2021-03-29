//
//  MaskView.m
//  JHD_iOS
//
//  Created by Gao on 2019/2/28.
//  Copyright © 2019 JHD. All rights reserved.
//

#import "MaskView.h"

#define kAppWindow  [UIApplication sharedApplication].keyWindow

#define kTag_MaskView        99666
#define kTag_ContentView     99665

@interface MaskView ()

@end

@implementation MaskView

+ (MaskView *)showView:(UIView *)view
{
    [self hidden];
    
    MaskView *maskView = [[MaskView alloc] init];
    maskView.tag = kTag_MaskView;
    view.tag = kTag_ContentView;
    
    [kAppWindow addSubview:maskView];
    [kAppWindow addSubview:view];
    
    return maskView;
}

+ (void)hidden
{
    UIView *maskView = [kAppWindow viewWithTag:kTag_MaskView];
    [maskView removeFromSuperview];
    
    UIView *contentView = [kAppWindow viewWithTag:kTag_ContentView];
    [contentView removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        if (![touch.view isKindOfClass:[MaskView class]]) {
            return;
        }
    }
    
    [MaskView hidden];
    
    if (self.touchView) {
        self.touchView();
    }
}

#pragma mark - init **********
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSet];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSet];
    }
    return self;
}

//加载Xib文件时调取
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initSet];
}

- (void)initSet
{
    self.frame = kAppWindow.bounds;
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.35;
}

@end
