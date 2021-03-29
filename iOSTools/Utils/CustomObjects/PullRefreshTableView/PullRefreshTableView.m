//
//  PullRefreshTableView.m
//  Buffet
//
//  Created by MagicPoint on 13-7-15.
//  Copyright (c) 2013年 magicpoint. All rights reserved.
//

#import "PullRefreshTableView.h"

@implementation PullRefreshTableView
@synthesize pullRefreshListDataArray = _pullRefreshListDataArray,segmentIndex = _segmentIndex,cellRow = _cellRow;
@synthesize pullRefreshTableViewDelegate = _pullRefreshTableViewDelegate,currentPageDataArray = _currentPageDataArray,isRefresh = _isRefresh;
@synthesize firstPage = _firstPage,currentPage = _currentPage,pageSize = _pageSize;

-(void)dealloc
{
    [headerView release];
    [footerView release];
    
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        headerView = [[PullRefreshView alloc] initWithFrame:CGRectMake(0, -45, frame.size.width, 44) viewType:k_VIEW_TYPE_HEADER];
        footerView = [[PullRefreshView alloc] initWithFrame:CGRectMake(0, self.frame.size.height + 60, frame.size.width, 44) viewType:k_VIEW_TYPE_FOOTER];
//        headerView.backgroundColor = [UIColor greenColor];
//        footerView.backgroundColor = [UIColor redColor];
        
        [self addSubview:headerView];
        [self addSubview:footerView];
        
        self.currentPage = 1;
        self.pageSize=10;
        
        self.isRefresh = NO;
    }
    return self;
}

-(void)setPullRefreshListDataArray:(NSMutableArray *)pullRefreshListDataArray
{
    if (_pullRefreshListDataArray != pullRefreshListDataArray) {
        [_pullRefreshListDataArray release];
        [pullRefreshListDataArray retain];
        _pullRefreshListDataArray = pullRefreshListDataArray;
        [self reloadData];
        [self reSetFootViewFrame];
    }
}

-(void)setCurrentPageDataArray:(NSMutableArray *)currentPageDataArray
{
    if (_currentPageDataArray != currentPageDataArray) {
        [_currentPageDataArray release];
        [currentPageDataArray retain];
        _currentPageDataArray = currentPageDataArray;
        
        if (self.currentPage == 1) {
            self.pullRefreshListDataArray = nil;// 清空之前数据
            self.pullRefreshListDataArray = currentPageDataArray;
        }else
        {
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.pullRefreshListDataArray];
            for (int i = 0; i < self.currentPageDataArray.count; i++) {
                [tempArray addObject:[self.currentPageDataArray objectAtIndex:i]];
            }
            self.pullRefreshListDataArray = tempArray;
            [tempArray release];
        }
    }
}

#pragma mark - // 下拉刷新 /  上拖加载 ***************

- (void)tableViewDidDragging{
    CGFloat offsetY = self.contentOffset.y;
    //  判断是否正在加载
    if (headerView.currentState == k_PULL_STATE_LOAD ||
        footerView.currentState == k_PULL_STATE_LOAD) {
        return;
    }
    //  改变“下拉可以刷新”视图的文字提示
    if (offsetY < -k_STATE_VIEW_HEIGHT - 10) {
        [headerView changeState:k_PULL_STATE_DOWN];
    } else {
        [headerView changeState:k_PULL_STATE_NORMAL];
    }
    //  判断数据是否已全部加载
    if (footerView.currentState == k_PULL_STATE_END) {
        return;
    }
    //  计算表内容大小与窗体大小的实际差距
    CGFloat differenceY = self.contentSize.height > self.frame.size.height ? (self.contentSize.height - self.frame.size.height) : 0;
    //  改变“上拖加载更多”视图的文字提示
    if (offsetY > differenceY + k_STATE_VIEW_HEIGHT + 10) {
        [footerView changeState:k_PULL_STATE_UP];
    } else {
        [footerView changeState:k_PULL_STATE_NORMAL];
    }
}

- (NSInteger)tableViewDidEndDragging{
    CGFloat offsetY = self.contentOffset.y;
    //  判断是否正在加载数据
    if (headerView.currentState == k_PULL_STATE_LOAD ||
        footerView.currentState == k_PULL_STATE_LOAD) {
        return k_RETURN_DO_NOTHING;
    }
    //  改变“下拉可以刷新”视图的文字及箭头提示
    if (offsetY < -k_STATE_VIEW_HEIGHT - 10) {
        [headerView changeState:k_PULL_STATE_LOAD];
        self.contentInset = UIEdgeInsetsMake(k_STATE_VIEW_HEIGHT + 13, 0, 0, 0);
        return k_RETURN_REFRESH;
    }
    //  改变“上拉加载更多”视图的文字及箭头提示
    CGFloat differenceY = self.contentSize.height > self.frame.size.height ? (self.contentSize.height - self.frame.size.height) : 0;
    if (footerView.currentState != k_PULL_STATE_END &&
        offsetY > differenceY + k_STATE_VIEW_HEIGHT + 10) {
        [footerView changeState:k_PULL_STATE_LOAD];
        self.contentInset = UIEdgeInsetsMake(0, 0, k_STATE_VIEW_HEIGHT + 20, 0);
        return k_RETURN_LOADMORE;
    }
    return k_RETURN_DO_NOTHING;
}

- (void)reloadData:(BOOL)dataIsAllLoaded{
    [self reSetFootViewFrame];
//    [self reloadData];
    self.contentInset = UIEdgeInsetsZero;
    [headerView changeState:k_PULL_STATE_NORMAL];
    //  如果数据已全部加载，则禁用“上拖加载”
    if (dataIsAllLoaded) {
        [footerView changeState:k_PULL_STATE_END];
    } else {
        [footerView changeState:k_PULL_STATE_NORMAL];
    }
    //  更新时间提示文本
    [headerView updateTimeLabel];
    [footerView updateTimeLabel];
}

-(void)reSetFootViewFrame
{
    [footerView setFrame:CGRectMake(0, self.contentSize.height + 10,320, 44)]; // 重要
}

#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerat
{
    if (self.isRefresh) {
        NSInteger returnKey = [self tableViewDidEndDragging];
        
        //  returnKey用来判断执行的拖动是下拉还是上拖，如果数据正在加载，则返回DO_NOTHING
        if (returnKey != k_RETURN_DO_NOTHING) {
            NSString * key = [NSString stringWithFormat:@"%d", returnKey];
            [NSThread detachNewThreadSelector:@selector(updateThread:) toTarget:self withObject:key];
        }
    }
}

#pragma mark -//  上拖 / 下拉 刷新
- (void)updateThread:(NSString *)returnKey{
    //刷新过程中禁止其他操作
    [headerView noHandleView];
    
    DLog(@"returnKey == %@",returnKey);
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    sleep(2);
    switch ([returnKey intValue]) {
        case k_RETURN_REFRESH:
            self.currentPage = 1;
//            if ([self.pullRefreshTableViewDelegate respondsToSelector:@selector(pullRefresh)]) {
//                
//                [self.pullRefreshTableViewDelegate pullRefresh];
//            }
            break;
            
        case k_RETURN_LOADMORE:
            self.currentPage ++;
//            if ([self.pullRefreshTableViewDelegate respondsToSelector:@selector(loadMore)]) {
//                
//                [self.pullRefreshTableViewDelegate loadMore];
//            }
            break;
            
        default:
            break;
    }
    if ([self.pullRefreshTableViewDelegate respondsToSelector:@selector(pullRefreshOrLoadMore)]) {
        [self.pullRefreshTableViewDelegate pullRefreshOrLoadMore];
    }
    [pool release];
}

-(void)mainUpdateTableView
{
    [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
}

- (void)updateTableView{
    //刷新完后解除禁止其他操作
    [headerView removeNoHandleView];
    
    if ([self.currentPageDataArray count] == self.pageSize) {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [self reloadData:NO]; //加载更多
    } else {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [self reloadData:YES]; //加载完毕
    }
}

@end
