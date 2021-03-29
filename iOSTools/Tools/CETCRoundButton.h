//
//  CETCRoundButton.h
//  CETCPartyBuilding
//
//  Created by gao on 17/2/27.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CETCRoundButton : UIButton

@property (nonatomic,assign) CGFloat cornerRadius;  //边框弧度
@property (nonatomic,strong) UIColor *borderColor;  //边框颜色
@property (nonatomic,strong) UIColor *fillColor;    //填充色

@end
