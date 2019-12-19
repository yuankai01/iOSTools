//
//  HomeSectionHeaderView.m
//  FarbenOffice
//
//  Created by Gao on 2019/12/19.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "HomeSectionHeaderView.h"

@implementation HomeSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.titleLab];
    [self addSubview:self.moreBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(40);
        make.right.mas_equalTo(-20);
    }];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.font = [UIFont boldSystemFontOfSize:18];
    }
    
    return _titleLab;
}

- (AlignButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [AlignButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"icon_rArrow_gray"] forState:UIControlStateNormal];
        
        [_moreBtn setTitleColor:kColor_Black forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _moreBtn.alignType = AlignType_Left;
    }
    
    return _moreBtn;
}

@end
