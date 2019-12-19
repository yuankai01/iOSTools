//
//  VerticallyAlignedLabel.m
//  CpicPeriodicaliPad
//
//  Created by MagicPoint on 13-7-17.
//  Copyright (c) 2013年 magicpoint. All rights reserved.
//

#import "VerticallyAlignedLabel.h"

@implementation VerticallyAlignedLabel
@synthesize verticalAlignment = _verticalAlignment;

- (id)initWithFrame:(CGRect)frame verticalAlignmentType:(VerticalAlignmentType) alignmentType
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.verticalAlignment = alignmentType;
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignmentType)verticalAlignment {
    
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}
-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
