//
//  CustomSegmentControl.m
//  Buffet
//
//  Created by apple on 12-11-14.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import "CustomSegmentControl.h"


@implementation CustomSegmentButton
@synthesize normalImageName = _normalImageName,highLightImageName = _highLightImageName;
- (void)dealloc
{
    RELEASE_SAFELY(_normalImageName);
    RELEASE_SAFELY(_highLightImageName);
    [super dealloc];
}
@end



@implementation CustomSegmentControl

@synthesize delegate = _delegate;

@synthesize itemsArray = _itemsArray;
@synthesize selectIndex = _selectIndex;
- (void)dealloc
{
    RELEASE_SAFELY(_itemsArray);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame Items:(NSArray*)itemsArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.itemsArray = itemsArray;
        
        [self initSubViewsWithItems:itemsArray];
        
        _selectIndex = NSNotFound;
        self.selectIndex = 0;
    }
    return self;
}


-(void)initSubViewsWithItems:(NSArray*)items
{
    NSInteger numberOfSegment = [items count];
    CGFloat titleTotalWidth = 0;
    __block CGFloat spacing = 0;
    
    for (CustomSegmentButton *button in items) {
        CGSize size = [button.titleLabel.text sizeWithFont:button.titleLabel.font];
        titleTotalWidth += size.width;
    }
    
    spacing = (self.bounds.size.width - titleTotalWidth) / numberOfSegment;
    
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CustomSegmentButton * button = (CustomSegmentButton*)obj;
        
        CGSize size = [button.titleLabel.text sizeWithFont:button.titleLabel.font];
        CGFloat width = size.width + spacing;
        
        if (idx > 0) {
            //取前一个button
            CustomSegmentButton *freBtn = [items objectAtIndex:idx - 1];
            button.frame = CGRectMake(freBtn.frame.origin.x + freBtn.frame.size.width, 0, width, self.bounds.size.height);
        }else button.frame = CGRectMake(0, 0, width, self.bounds.size.height);
//        button.frame = CGRectMake(idx*(self.bounds.size.width/numberOfSegment), 0, self.bounds.size.width/numberOfSegment, self.bounds.size.height);
        button.tag = idx;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }];
    
}

-(void)buttonPressed:(UIButton*)sender
{
    [self setSelectIndex:sender.tag];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    
    if (_selectIndex == selectIndex) {
        return;
    }
    else
    {
        _selectIndex = selectIndex;
        
        [self changeStateWithIndex:_selectIndex];
        
        if ([self.delegate respondsToSelector:@selector(segmentControl:selectedSegmentIndex:)]) {
            [self.delegate segmentControl:self selectedSegmentIndex:_selectIndex];
        }
    }
}

- (void)changeStateWithIndex:(NSInteger )index {
    
    [self.itemsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CustomSegmentButton * button = (CustomSegmentButton*)obj;
        
        if (button.tag == index) {
            [button setBackgroundImage:[UIImage imageNamed:button.highLightImageName] forState:UIControlStateNormal];
            [button setTitleColor:RGB(255, 108, 0) forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:button.normalImageName] forState:UIControlStateNormal];
            [button setTitleColor:RGB(138, 139, 140) forState:UIControlStateNormal];
        }
    }];
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
