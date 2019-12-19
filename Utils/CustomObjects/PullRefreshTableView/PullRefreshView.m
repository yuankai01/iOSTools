//
//  PullRefreshView.m
//  Buffet
//
//  Created by MagicPoint on 13-7-11.
//  Copyright (c) 2013年 magicpoint. All rights reserved.
//

#import "PullRefreshView.h"

//上拖 / 下拉 刷新箭头
#define kImageName_Pull_arrow_down                      @"arrow_down.png"
#define kImageName_Pull_arrow_up                        @"arrow_up.png"

#pragma mark - // 下拉 / 上拖 视图 **********************
/**
 *
 * StateView 顶部和底部状态视图
 *
 *
*/
@implementation PullRefreshView

@synthesize indicatorView;
@synthesize arrowView;
@synthesize stateLabel;
@synthesize timeLabel;
@synthesize viewType;
@synthesize currentState;
@synthesize handleView;

- (id)initWithFrame:(CGRect)frame viewType:(int)type{
    CGFloat width = frame.size.width;
    
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, width, k_STATE_VIEW_HEIGHT)];
    
    if (self) {
        //  设置当前视图类型
        viewType = type == k_VIEW_TYPE_HEADER ? k_VIEW_TYPE_HEADER : k_VIEW_TYPE_FOOTER;
        self.backgroundColor = [UIColor clearColor];
        
        //  初始化加载指示器（菊花圈）
        indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((k_STATE_VIEW_INDICATE_WIDTH - 20) / 2, (k_STATE_VIEW_HEIGHT - 20) / 2, 20, 20)];
        //        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        indicatorView.hidesWhenStopped = YES;
        //        indicatorView.backgroundColor = [UIColor whiteColor];
        [self addSubview:indicatorView];
        
        //  初始化箭头视图
        arrowView = [[UIImageView alloc] initWithFrame:CGRectMake((k_STATE_VIEW_INDICATE_WIDTH - 32) / 2, (k_STATE_VIEW_HEIGHT - 32) / 2, 32, 32)];
        NSString * imageNamed = type == k_VIEW_TYPE_HEADER ? kImageName_Pull_arrow_down : kImageName_Pull_arrow_up;
        arrowView.image = [UIImage imageNamed:imageNamed];
        [self addSubview:arrowView];
        
        //  初始化状态提示文本
        stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
        stateLabel.font = [UIFont systemFontOfSize:16.0f];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = UITextAlignmentCenter;
        stateLabel.text = type == k_VIEW_TYPE_HEADER ? kText_Pull_Downrefresh : kText_Pull_UpMore;
        stateLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:stateLabel];
        
        //  初始化更新时间提示文本
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, width, k_STATE_VIEW_HEIGHT - 20)];
        timeLabel.font = [UIFont systemFontOfSize:12.0f];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textAlignment = UITextAlignmentCenter;
        timeLabel.text = nil;
        timeLabel.textColor = [UIColor whiteColor];
        [self addSubview:timeLabel];
    }
    return self;
}

- (void)changeState:(int)state{
    [indicatorView stopAnimating];
    arrowView.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    switch (state) {
        case k_PULL_STATE_NORMAL:
            currentState = k_PULL_STATE_NORMAL;
            stateLabel.text = viewType == k_VIEW_TYPE_HEADER ? kText_Pull_Downrefresh : kText_Pull_UpMore;
            //  旋转箭头
            arrowView.layer.transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            break;
        case k_PULL_STATE_DOWN:
            currentState = k_PULL_STATE_DOWN;
            stateLabel.text = kText_Pull_ReleaseRefresh;
            arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            break;
            
        case k_PULL_STATE_UP:
            currentState = k_PULL_STATE_UP;
            stateLabel.text = kText_Pull_ReleaseLoad;
            arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            break;
            
        case k_PULL_STATE_LOAD:
            currentState = k_PULL_STATE_LOAD;
            stateLabel.text = viewType == k_VIEW_TYPE_HEADER ? kText_Pull_Refreshing : kText_Pull_Loading;
            [indicatorView startAnimating];
            arrowView.hidden = YES;
            break;
            
        case k_PULL_STATE_END:
            currentState = k_PULL_STATE_END;
            //            stateLabel.text = viewType == k_VIEW_TYPE_HEADER ? stateLabel.text : kText_Pull_Loaded;
            stateLabel.text = viewType == k_VIEW_TYPE_HEADER ? stateLabel.text : kText_Pull_Loaded;
            arrowView.hidden = YES;
            break;
            
        default:
            currentState = k_PULL_STATE_NORMAL;
            stateLabel.text = viewType == k_VIEW_TYPE_HEADER ? kText_Pull_Downrefresh : kText_Pull_UpMore;
            arrowView.layer.transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            break;
    }
    [UIView commitAnimations];
}

- (void)updateTimeLabel{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    timeLabel.text = [NSString stringWithFormat:@"%@ %@",kText_Pull_RefreshTime, [formatter stringFromDate:date]];
    [formatter release];
}

- (void)dealloc{
    [indicatorView release];
    [arrowView release];
    [stateLabel release];
    [timeLabel release];
    [handleView release];
    
    [super dealloc];
}

#pragma mark - handle View
-(void)noHandleView
{
    //刷新过程中禁止其他操作
    UIView *clearView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    clearView.backgroundColor = [UIColor clearColor];
    self.handleView = clearView;
    [clearView release];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.handleView];
}

-(void)removeNoHandleView
{
    //刷新完后解除禁止其他操作
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window removeFromSuperview];
    self.handleView.hidden = YES;
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
