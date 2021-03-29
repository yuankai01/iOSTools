//
//  ViewControllerManager.m
//  SwitchingViewController
//
//  Created by Aegaeon on 13-8-23.
//  Copyright (c) 2013年 Aegaeon. All rights reserved.
//

#import "ViewControllerManager.h"

@interface ViewControllerManager ()

@end

@implementation ViewControllerManager


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
  [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)pushViewController:(UIViewController *)toViewController animated:(BOOL)animated
{
  UIViewController* fromViewController = [self.childViewControllers lastObject];
  
  [self addChildViewController:toViewController];
  [toViewController didMoveToParentViewController:self];
  
  CGFloat width = self.view.frame.size.width;
  CGFloat height = self.view.frame.size.height;
  
  toViewController.view.frame = CGRectMake(width, 0, width, height);

  [self transitionFromViewController:fromViewController
                     toViewController:toViewController
                             duration:0.4
                              options:UIViewAnimationOptionTransitionNone
                           animations:^(void) {
                             fromViewController.view.frame = CGRectMake(0 - width, 0, width, height);
                             toViewController.view.frame = CGRectMake(0, 0, width, height);
                           } 
                           completion:nil
   ];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
  if (self.childViewControllers.count == 1) {
    return nil;
  }
  
  UIViewController* fromViewController = [self.childViewControllers lastObject];
  UIViewController* toViewController = [self.childViewControllers objectAtIndex:self.childViewControllers.count - 2];
  
  CGFloat width = self.view.frame.size.width;
  CGFloat height = self.view.frame.size.height;
  
  toViewController.view.frame = CGRectMake(-width, 0, width, height);
  
  [self transitionFromViewController:fromViewController
                    toViewController:toViewController
                            duration:0.4
                             options:UIViewAnimationOptionTransitionNone
                          animations:^(void) {
                            fromViewController.view.frame = CGRectMake(width, 0, width, height);
                            toViewController.view.frame = CGRectMake(0, 0, width, height);
                          }
                          completion:^(BOOL finished) {
                            [fromViewController removeFromParentViewController];
                          }
   ];
  
  return  fromViewController;
}

@end

//************************************************
@implementation MyNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)wantsFullScreenLayout{
    
    return NO;
    
}

@end
