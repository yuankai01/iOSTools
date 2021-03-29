//
//  RichTextView.m
//  JHD_iOS
//
//  Created by Gao on 2019/2/13.
//  Copyright © 2019 JHD. All rights reserved.
//

#import "RichTextView.h"

@interface RichTextView () <UITextViewDelegate>

@end

@implementation RichTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =  [UIColor clearColor];
        self.editable = NO;
        self.scrollEnabled = NO;
        self.textAlignment = NSTextAlignmentLeft;
        self.delegate = self;
        
    }
    return self;
}

- (void)setText:(NSString *)text
{
    self.attributedText = [self getContentLabelAttributedText:text];
}

//----------------------------------
- (NSAttributedString *)getContentLabelAttributedText:(NSString *)text
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:JK33TextColor}];

//    [attrStr addAttributes:@{NSUnderlineStyleAttributeName : @1,NSUnderlineColorAttributeName : JK66TextColor} range:NSMakeRange(text.length - 4, 4)];
    
    [attrStr addAttribute:NSLinkAttributeName value:@"link://" range:NSMakeRange(text.length-4, 4)];
    
    return attrStr;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    if ([[URL scheme] isEqualToString:@"link"]) {
        //采购合同
        if (self.link) {
            self.link();
        }
        
        return NO;
    }
    
    return YES;
}


@end
