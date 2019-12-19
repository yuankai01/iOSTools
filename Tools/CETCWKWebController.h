//
//  CETCWKWebController.h
//  CETCPartyBuilding
//
//  Created by gao on 17/3/28.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import "JHBaseViewController.h"

@interface CETCWKWebController : JHBaseViewController

@property(nonatomic, strong)NSString *url;
@property(nonatomic, strong)NSString *strTitle;

@property(nonatomic, strong)UIActivityIndicatorView *indicatorView;

- (void)loadWebRequest;
- (void)back;

@end
