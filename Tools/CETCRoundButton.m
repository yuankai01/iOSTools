//
//  CETCRoundButton.m
//  CETCPartyBuilding
//
//  Created by gao on 17/2/27.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import "CETCRoundButton.h"

@implementation CETCRoundButton

//代码初始化调用
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.layer.cornerRadius = self.height / 2;
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = kColorGreen1.CGColor;
        [self initSet];
    }
    
    return self;
}

//加载xib文件调用
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initSet];
}

//初始化设置
- (void)initSet
{
    [self setTitleColor:CETC_MAIN_COLOR forState:UIControlStateNormal];
    [self setTitleColor:CETC_MAIN_COLOR forState:UIControlStateSelected];
    self.cornerRadius = CGRectGetHeight(self.frame) / 2;
    self.borderColor = CETC_MAIN_COLOR;
    self.fillColor =  [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
    [path addClip];
    [self.borderColor setStroke];
    [path stroke];
    [self.fillColor setFill];
    [path fill];
}

@end
