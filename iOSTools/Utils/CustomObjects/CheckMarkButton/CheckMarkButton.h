//
//  CheckMarkButton.h
//  NewOneCard
//
//  Created by Apple on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

// 打钩的button。
#import <UIKit/UIKit.h>

typedef enum {
    CheckMarkLabelLeft,  // label 在button 左侧
    CheckMarkLabelRight //  label 在button 右侧
} CheckMarkLabelLocation;

@interface CheckMarkButton : UIView {
    UIButton *_button;
    UILabel *_textLabel;  // button右边放的说明性的label
    BOOL _isSelected; // 是否勾选,默认NO
    
    UIImage *_unselectImage;
    UIImage *_selectImage;
    
    CheckMarkLabelLocation _textLabelLocation;
}
@property (nonatomic,retain) UILabel *textLabel;
@property (nonatomic,retain) UIButton *button;

// 是否打钩读取isSelected属性。
@property (nonatomic,assign) BOOL isSelected;

// frame 为button的frame，不包括label
- (id)initWithFrame:(CGRect) frame unselectImage:(UIImage *) unselectImage selectImage:(UIImage *) selectImage textLabelLocation:(CheckMarkLabelLocation)location labelWidth:(float)labelWidth text:(NSString *)text;

// 更改 button的状态。
- (void)changeButtonStatus:(BOOL)isSelected;

@end
