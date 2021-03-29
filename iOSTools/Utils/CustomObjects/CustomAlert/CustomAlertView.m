//
//  CustomAlertView.m
//  Colourful
//
//  Created by MagicPoint on 13-10-23.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self configureView:frame];
    }
    return self;
}

-(void)configureView:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 23)];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"请输入激活码后激活";
    label.font = defineCustomFontSize(18);
    self.titleLab = label;
    [self addSubview:self.titleLab];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + 5, frame.size.width - 30 * 2, 25)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.textColor = RGB(200, 100, 120);
    textField.font = defineCustomFontSize(18);
    self.textField = textField;
    [self addSubview:self.textField];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, self.textField.frame.origin.y + self.textField.frame.size.height + 5, (frame.size.width - 10 * 2 - 5 ) / 2, 30);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = defineCustomFontSize(18);
    self.cancelBtn = cancelBtn;
    [self addSubview:self.cancelBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(self.cancelBtn.frame.origin.x + self.cancelBtn.frame.size.width + 5, self.cancelBtn.frame.origin.y, self.cancelBtn.frame.size.width, 30);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = defineCustomFontSize(18);
    self.sureBtn = sureBtn;
    [self addSubview:self.sureBtn];
}

@end
