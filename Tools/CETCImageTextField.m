//
//  CETCImageTextField.m
//  CETCGrouth
//
//  Created by Aaron Yu on 15/8/31.
//  Copyright (c) 2015年 Aaron. All rights reserved.
//

#import "CETCImageTextField.h"

@interface CETCImageTextField ()
@property(nonatomic, strong)UIImageView *imageView;

@property(nonatomic, strong)NSString *image;
@property(nonatomic, strong)NSString *highlighteImage;

@end

@implementation CETCImageTextField

- (id)initWithFrame:(CGRect) frame iconName:(NSString *)imageName highlighteImage:(NSString *)hImageName withLine:(BOOL)withLine
{
    self = [super initWithFrame:frame];
    
    if (!self)
    {
        return nil;
    }
    
    CGRect imageViewFrame = [self iconImageViewRect];
    
    self.image = imageName;
    self.highlighteImage = hImageName;
    
    UIImage *icon = [UIImage imageNamed:self.image];
    _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [_imageView setImage:icon];
    [_imageView setContentMode:UIViewContentModeCenter];
    self.leftView = _imageView;
    self.leftViewMode = UITextFieldViewModeAlways;

    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    if (withLine)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 0.5)];
        lineView.backgroundColor = CETC_GRAY_COLOR;
        [self addSubview:lineView];
    }
    
    self.textColor = CETC_BLACK_COLOR;
    self.font = FONT_WITH_SIZE(15.0);
    self.tintColor = CETC_GRAY_COLOR;

    return self;
}

- (void)setCustomPlaceHolder:(NSString *)customPlaceHolder
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:customPlaceHolder attributes:@{NSForegroundColorAttributeName: CETC_GRAY_COLOR,NSFontAttributeName:FONT_WITH_SIZE(15.0)}];
}

- (BOOL)becomeFirstResponder
{
    self.imageView.image = [UIImage imageNamed:self.highlighteImage];
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.imageView.image = [UIImage imageNamed:self.image];
    
    return [super resignFirstResponder];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + 40,bounds.origin.y + 10,bounds.size.width - 45, bounds.size.height - 20);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect leftViewRect = [super leftViewRectForBounds:bounds];
    leftViewRect.origin.x += 15;
    
    return leftViewRect;
}

- (CGRect)iconImageViewRect
{
    UIEdgeInsets edge = [self edgeInsets];
    return CGRectMake(5, 5, edge.left, self.frame.size.height);
}

- (UIEdgeInsets)edgeInsets
{
    return UIEdgeInsetsMake(13, 13, 13, 13);
}

@end
