//
//  MyTabHeaderView.h
//  FarbenOffice
//
//  Created by Gao on 2019/12/19.
//  Copyright © 2019 Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTabHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *telLab;
@property (weak, nonatomic) IBOutlet UILabel *OfficeLab;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;

@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;

@end

NS_ASSUME_NONNULL_END
