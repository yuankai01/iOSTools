//
//  BaseViewController.m
//  BaiduMap2
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BaseViewController.h"

//**********
#pragma mark -//在IOS4.3系统中添加自定义的导航栏 自动调用
@implementation UINavigationBar (UINavigationBarCategory)

- (void)drawRect:(CGRect)rect {
    UIImage *img = [UIImage imageNamed:kImageName_NavBackground];
    [img drawInRect:rect];
}

@end
//**********

@interface BaseViewController ()

@end

@implementation BaseViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 系统信息
//**************************************
//********************************
#pragma mark - // 添加导航栏切换按钮
//- (void)addNavigationSwitchButton {
//    if (!_navButton) {
//        _navButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _navButton.frame = CGRectMake(110, 0, 168, 44);
//        _navButton.center = CGPointMake(160, 22);
//        //        _navButton.backgroundColor = [UIColor redColor];
//        //        _navButton.alpha = 0.3;
//        _navButton.titleLabel.font = defineCustomFontSize(20);
//        UIImage *normalImage = [UIImage imageNamed:kImageName_NavButton_centerTriangle];
//        if (kSystemVersion < 5.0) {
//            normalImage = [normalImage stretchableImageWithLeftCapWidth:5.0 topCapHeight:15.0];
//        }else {
//            normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5.0, 0, 15.0)];
//        }
//        
//        [_navButton setBackgroundImage:normalImage
//                              forState:UIControlStateNormal];
//        [self.navigationController.navigationBar addSubview:_navButton];
//    }
//    
//}
//
//#pragma mark - navgationBar
//-(void)setNavgationBarBg
//{
//    if (self.navigationController) {
//        
//        UIImage *navBgIm = defineImage(@"nav_background.png");
//        CGSize size = self.navigationController.navigationBar.bounds.size;
//        navBgIm = [self scaleToSize:navBgIm size:size];
//        
//        if (kSystemVersion >=  5.0) {
//            UIImage *imageBg = defineImage(kImageName_NavBackground);
//            [self.navigationController.navigationBar setBackgroundImage:imageBg forBarMetrics:UIBarMetricsDefault];
//            //设置导航栏字体
//            NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
//            [titleBarAttributes setValue:[UIFont fontWithName:kText_Font size:20] forKey:UITextAttributeFont];
//            [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
//            [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:3 forBarMetrics:UIBarMetricsDefault];
//        }
//        
//        [self addNavigationLeftButton];
//        
//    }
//}
//
////调整图片大小
//- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
//    UIGraphicsBeginImageContext(size);
//    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return scaledImage;
//}
//
//// 添加navLeft按钮
//- (void)addNavigationLeftButton {
//    
//    // add navigation left item
//    UIImage *leftImg = [UIImage imageNamed:kImageName_NavBackButton];
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = CGRectMake(0, 0, leftImg.size.width,leftImg.size.height);
//    leftButton.backgroundColor = [UIColor clearColor];
//    [leftButton setBackgroundImage:leftImg
//                          forState:UIControlStateNormal];
//    [leftButton setBackgroundImage:[UIImage imageNamed:kImageName_NavBackButton_Down]
//                          forState:UIControlStateHighlighted];
//    //    [leftButton setTitle:kText_Back
//    //                forState:UIControlStateNormal];
//    //    leftButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
//    //    leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0);
//    
//    [leftButton addTarget:self
//                   action:@selector(navigationLeftButtonPressed)
//         forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]
//                             initWithCustomView:leftButton];
//    //item.tintColor = self.navigationBarColor;
//    //    if (self.tabBarController) {
//    //        self.tabBarController.navigationItem.leftBarButtonItem = item;
//    //    }else {
//    //    }
//    
//    self.navigationItem.leftBarButtonItem = item;
//}
//
//- (void)navigationLeftButtonPressed {
//    
//    [self popViewController:nil];
//}
//
//-(void)navigationRightButtonPress
//{
//    
//}
//
//-(void)addNavigationRightButtonImage:(UIImage *)image withTitle:(NSString *)title andEdgeInSets:(UIEdgeInsets)inset
//{
//    //获取图像的宽度
//    CGFloat imageWidth = CGImageGetWidth(image.CGImage);
//    
//    //获取title的宽度
//    UIFont *font = defineCustomFontSize(18);
//    CGSize size = [title sizeWithFont:font];
//    CGFloat titleWidth = size.width;
//    
//    //button的最小宽度
//    CGFloat buttonWidth = imageWidth + titleWidth;
//    UIImage *rightBtnImg = defineImage(kImageName_NavButton_rightCommon);
//    rightBtnImg = [self stretchableImage:rightBtnImg withLeftCapWidth:rightBtnImg.size.width / 2 topCapHeight:0];
//    UIImage *rightBtnImgDown = [self stretchableImage:defineImage(kImageName_NavButton_rightCommon_down) withLeftCapWidth:rightBtnImg.size.width / 2 topCapHeight:0];
//    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, buttonWidth + 2, rightBtnImg.size.height);
//    [rightBtn setBackgroundImage:rightBtnImg forState:UIControlStateNormal];
//    [rightBtn setBackgroundImage:rightBtnImgDown forState:UIControlStateHighlighted];
//    rightBtn.titleLabel.font = font;
//    [rightBtn addTarget:self action:@selector(navigationRightButtonPress) forControlEvents:UIControlEventTouchUpInside];
//    
//    //给button添加图像和title
//    [rightBtn setImage:image forState:UIControlStateNormal];
//    [rightBtn setTitle:title forState:UIControlStateNormal];
//    
//    //    //调整图像和title的位置
//    //    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth, 0, 0)];
//    //    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth, 0, 0)];
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
//}
//
//#pragma mark - pushViewCtroller
//-(void) pushNavigationController:(UIViewController *)controller {
//    
//    //    UIView* fromView = self.view.window;
//    //    UIView* toView = controller.view;
//    //
//    //    fromView.backgroundColor = [UIColor whiteColor];
//    //    toView.backgroundColor = [UIColor whiteColor];
//    //
//    //    CGRect initFrameOfToView = toView.frame;
//    //    initFrameOfToView.origin = CGPointMake(self.view.bounds.size.width, 0);
//    //    toView.frame = initFrameOfToView;
//    //    [fromView addSubview:toView];
//    //
//    //    [UIView animateWithDuration:0.45 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//    //        CGRect newFrameOfFromeView = fromView.frame;
//    //        newFrameOfFromeView.origin = CGPointMake(-fromView.bounds.size.width, 0);
//    //        fromView.frame = newFrameOfFromeView;
//    //    } completion:^(BOOL finished) {
//    //        [toView removeFromSuperview];
//    //        CGRect newFrameOfFromeView = fromView.frame;
//    //        newFrameOfFromeView.origin = CGPointMake(0, 0);
//    //        fromView.frame = newFrameOfFromeView;
//    ////        [self presentViewController:controller animated:NO completion:nil];
//    //        [self presentModalViewController:controller animated:NO]; //如果去掉不能跳转到第二个页面
//    //    }];
//    
//    [self presentModalViewController:controller animated:YES];
//    
//}
//
//#pragma mark - popViewCtroller
//- (void)popViewController:(UIViewController *)controller {
//    //    UIView* fromView = self.view.window;
//    //    UIView* toView = ((UIViewController*)self.delegate).view;
//    //
//    //    fromView.backgroundColor = [UIColor whiteColor];
//    //
//    //    NSString *device = [self getDeviceTypeModel];
//    //    if ([device isEqualToString:@"iphone5"] || IS_IPHONE5) {
//    //        toView.backgroundColor = [UIColor colorWithPatternImage:defineImage(kImageName_Home_background_h568)];
//    //    }else
//    //        toView.backgroundColor = [UIColor colorWithPatternImage:defineImage(kImageName_Home_background)];
//    //
//    //    CGRect initFrameOfToView = toView.frame;
//    //    initFrameOfToView.origin = CGPointMake(-self.view.bounds.size.width, 20);
//    //    toView.frame = initFrameOfToView;
//    //    [fromView addSubview:toView];
//    //    [UIView animateWithDuration:0.45 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//    //
//    //        CGRect newFrameOfFromeView = fromView.frame;
//    //        newFrameOfFromeView.origin = CGPointMake(fromView.bounds.size.width, 0);
//    //        fromView.frame = newFrameOfFromeView;
//    //
//    //    } completion:^(BOOL finished) {
//    ////    CGRect newFrameOfFromeView = fromView.frame;
//    ////    newFrameOfFromeView.origin = CGPointMake(0, 0);
//    ////    fromView.frame = newFrameOfFromeView;
//    //////    [self dismissViewControllerAnimated:NO completion:nil];
//    ////    [self dismissModalViewControllerAnimated:NO];
//    //        
//    //        //单用下面后两句方法也行
//    //        //      toView.frame = toView.bounds;
//    //        fromView.frame = fromView.bounds;
//    //        [self dismissModalViewControllerAnimated:NO];
//    //    }];
//    
//    [self dismissModalViewControllerAnimated:YES];
//}

@end
