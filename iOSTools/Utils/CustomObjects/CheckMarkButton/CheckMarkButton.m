//
//  CheckMarkButton.m
//  NewOneCard
//
//  Created by Apple on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CheckMarkButton.h"

@implementation CheckMarkButton

@synthesize textLabel = _textLabel;
@synthesize button = _button;
@synthesize isSelected = _isSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
         
    }
    return self;
}

- (id)initWithFrame:(CGRect) frame unselectImage:(UIImage *) unselectImage selectImage:(UIImage *) selectImage textLabelLocation:(CheckMarkLabelLocation)location labelWidth:(float)labelWidth text:(NSString *)text {
    self = [super initWithFrame:frame];
    if (self) {
        _isSelected = NO;
        
        //CGRect rect = frame;
        frame.origin.x = 0.0f;
        frame.origin.y = 0.0f;
        
        // image
        _unselectImage = [unselectImage retain];
        _selectImage = [selectImage retain];
        
        // text label location
        _textLabelLocation = location;
        
        // button
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.backgroundColor = self.backgroundColor;
        butt.frame = frame;
        butt.clipsToBounds = NO;
        [butt addTarget:self
                 action:@selector(buttonPressed:)
       forControlEvents:UIControlEventTouchUpInside];
        self.button = butt;
        [self changeButtonStatus:_isSelected];
        [self addSubview:self.button];
        
        // label
        CGRect labelFrame = CGRectZero;
        UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
        
//        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:12.0f]                                                                        					 constrainedToSize:CGSizeMake(labelWidth, frame.size.height)                                                                           						 lineBreakMode:UILineBreakModeWordWrap];
       
        
        if (_textLabelLocation == CheckMarkLabelLeft) {
            // label 在左侧
            
            
            labelFrame = CGRectMake(frame.origin.x-labelWidth-10, frame.origin.y, labelWidth, frame.size.height);
            
            label.textAlignment = UITextAlignmentRight;
        }else {
            // label 在 右侧
            labelFrame = CGRectMake(frame.origin.x+frame.size.width+5, frame.origin.y, labelWidth, frame.size.height);
            
            label.textAlignment = UITextAlignmentLeft;
        }
        label.frame = labelFrame;
        label.text = text;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:20];
        label.backgroundColor = [UIColor clearColor];
        self.textLabel = label;
        [self.button addSubview:self.textLabel];
        [label release];

    }
    return self;
}

- (void)dealloc {
    if (_textLabel) {
        [_textLabel release];
        _textLabel = nil;
    }
    if (_button) {
        [_button release];
        _button = nil;
    }
    if (_selectImage) {
        [_selectImage release];
        _selectImage = nil;
    }
    if (_unselectImage) {
        [_unselectImage release];
        _unselectImage = nil;
    }
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    [self changeButtonStatus:_isSelected];
}

- (void)buttonPressed:(UIButton *)sender {
    _isSelected = !_isSelected;
    [self changeButtonStatus:_isSelected];
}

- (void)changeButtonStatus:(BOOL)isSelected {
    if (isSelected) {
        [self.button setImage:_selectImage
              forState:UIControlStateNormal];
        [self.button setBackgroundColor:[UIColor clearColor]];
        
    } else {
        [self.button setImage:_unselectImage
                     forState:UIControlStateNormal];
        [self.button setBackgroundColor:[UIColor clearColor]];
    }
}

@end
