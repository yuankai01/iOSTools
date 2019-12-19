//
//  MyTabCellT.m
//  FarbenOffice
//
//  Created by Gao on 2019/12/19.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "MyTabCellT.h"

@implementation MyTabCellT

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.backgroundColor = [UIColor clearColor];
//    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.titleLab.textColor = kColor_Black;
    self.msgNumLab.layer.cornerRadius = CGRectGetHeight(self.msgNumLab.frame) / 2;
    self.msgNumLab.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
