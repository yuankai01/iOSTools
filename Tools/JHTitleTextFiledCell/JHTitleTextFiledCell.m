//
//  JHTitleTextFiledCell.m
//  JHD_iOS
//
//  Created by Gao on 2019/1/13.
//  Copyright © 2019 JHD. All rights reserved.
//

#import "JHTitleTextFiledCell.h"

@interface JHTitleTextFiledCell () <UITextFieldDelegate>

@end

@implementation JHTitleTextFiledCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLab.textColor =  JK33TextColor;
    self.contentTF.textColor =  JK66TextColor;
    self.contentTF.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.maxLength > 0) {
        if (range.location > self.maxLength - 1) {
            return NO;
        }
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.tfDidEnd) {
        self.tfDidEnd(textField.text);
    }
}

@end
