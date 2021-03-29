//
//  ViewControllerManager.h
//  SwitchingViewController
//
//  Created by Aegaeon on 13-8-23.
//  Copyright (c) 2013年 Aegaeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerManager : UIViewController

- (void)pushViewController:(UIViewController *)toViewController animated:(BOOL)animated;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;

@end

//************************************************
@interface MyNavigationController : UINavigationController

@end
