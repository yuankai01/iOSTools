//
//  ImageTextField.m
//  FarbenOffice
//
//  Created by Gao on 2019/12/19.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "ImageTextField.h"

@interface ImageTextField ()
{
    UIView *lineView;
}

@property(nonatomic, strong)UIImageView *imageView;

@end

@implementation ImageTextField

//xib
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSet];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.image = [UIImage imageNamed:self.icon];
    lineView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1);
}

//xib、frame共有初始化方法
- (void)initSet
{
    lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor =  [UIColor grayColor];
    [self addSubview:lineView];
    
    self.leftViewMode = UITextFieldViewModeAlways;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//    [_imageView setImage:[UIImage imageNamed:self.icon]];
    [_imageView setContentMode:UIViewContentModeCenter];
    self.leftView = _imageView;
    
//    UIButton *defaultClearButton = [UIButton appearanceWhenContainedInInstancesOfClasses:@[[UITextField class]]];
//    [defaultClearButton setImage:[UIImage imageNamed:@"icon_delete_gray"] forState:UIControlStateNormal];
}

//frame
- (id)initLineWithFrame:(CGRect)frame iconName:(NSString *)imageName
{
   return [self initWithFrame:frame iconName:imageName highlightIcon:nil withLine:YES];
}

- (id)initWithFrame:(CGRect) frame iconName:(NSString *)imageName highlightIcon:(NSString *)hImageName withLine:(BOOL)withLine
{
    self = [super initWithFrame:frame];
    
    if (!self)
    {
        return nil;
    }
    
    CGRect imageViewFrame = [self iconImageViewRect];
    
    self.icon = imageName;
    self.highlightIcon = hImageName;
    
    UIImage *icon = [UIImage imageNamed:self.icon];
    _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [_imageView setImage:icon];
    [_imageView setContentMode:UIViewContentModeCenter];
    self.leftView = _imageView;
    
    self.leftViewMode = UITextFieldViewModeAlways;
    UIButton *defaultClearButton = [UIButton appearanceWhenContainedInInstancesOfClasses:@[[UITextField class]]];
    [defaultClearButton setImage:[UIImage imageNamed:@"icon_delete_gray"] forState:UIControlStateNormal];
    
    if (withLine)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        lineView.backgroundColor =  [UIColor grayColor];
        
        [self addSubview:lineView];
    }
    
    return self;
}

- (BOOL)becomeFirstResponder
{
    if (self.highlightIcon) {
        self.imageView.image = [UIImage imageNamed:self.highlightIcon];
    }
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.imageView.image = [UIImage imageNamed:self.icon];
    
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
