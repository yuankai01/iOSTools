//
//  MyTabHeaderView.m
//  FarbenOffice
//
//  Created by Gao on 2019/12/19.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "MyTabHeaderView.h"

@implementation MyTabHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.nameLab.font = [UIFont boldSystemFontOfSize:18];
    self.numLab.layer.cornerRadius = CGRectGetWidth(self.numLab.frame) / 2;
    self.numLab.clipsToBounds = YES;
}

@end
