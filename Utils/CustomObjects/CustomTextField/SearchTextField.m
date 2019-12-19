//
//  SearchTextField.m
//  Colourful
//
//  Created by MagicPoint on 13-9-24.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import "SearchTextField.h"
#define XSpacing 13

@implementation SearchTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//占位符字体颜色和大小
- (void)drawPlaceholderInRect:(CGRect)rect
{
    UIColor *color = defineTextColor_tableViewCell_placeHolder;
    
    [color setFill];
    
    [[self placeholder] drawInRect:rect withFont:defineCustomFontSize(13)];
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x + XSpacing, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    
    return inset;
    
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    CGRect inset = CGRectMake(bounds.origin.x + XSpacing, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

//该返回值与rightView的位置和大小有关
-(CGRect)rightViewRectForBounds:(CGRect)bounds
{
    UIImage *image = defineImage(kImageName_NavButton_rightSearch_clear);
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;

    return CGRectMake(bounds.size.width - width - 5, (bounds.size.height - height) / 2, width,height);
}

@end
