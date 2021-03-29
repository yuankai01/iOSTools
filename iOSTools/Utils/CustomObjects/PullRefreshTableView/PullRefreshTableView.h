//
//  PullRefreshTableView.h
//  Buffet
//
//  Created by MagicPoint on 13-7-15.
//  Copyright (c) 2013年 magicpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshView.h"

/*
 如何使用该类:新建tableView继承于该类PullRefreshTableView,根据需要,设置布尔属性isRefresh(判断是否需要下拉刷新功能),如果设为NO,则不执行下拉刷新功能,如果设为YES,给出每页请求数据的大小pageSize;2.实现代理PullRefreshTableViewDelegate方法pullRefreshOrLoadMore,在该方法中回调请求数据方法;3.最后在获取数据(数据赋值给currentPageDataArray)的地方 调取方法 -(void)mainUpdateTableView.
 注意:请求参数:pageSize 和 currentPage 要加上
*/

@protocol PullRefreshTableViewDelegate;

@interface PullRefreshTableView : UITableView
{
    PullRefreshView * headerView;  //  下拉刷新视图
    PullRefreshView * footerView;  //  上拖加载视图
}
//必备属性
@property (nonatomic,retain) NSMutableArray *pullRefreshListDataArray;
@property (nonatomic,retain) NSMutableArray *currentPageDataArray;
@property (nonatomic,assign) NSInteger firstPage;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger pageSize;//每页请求多少数据
@property (nonatomic,assign) id <PullRefreshTableViewDelegate> pullRefreshTableViewDelegate;
@property (nonatomic,assign) BOOL isRefresh;

//临时属性
@property (nonatomic,assign) NSInteger segmentIndex;
@property (nonatomic,assign) NSInteger cellRow;

#pragma mark - 上拖下拉执行操作方法
/**
 *  当表视图拖动时的执行方法
 *  使用方法：设置表视图的delegate，实现- (void)scrollViewDidScroll:(UIScrollView *)scrollView方法，在垓方法中直接调用本方法
 **/
- (void)tableViewDidDragging;

/**
 *  当表视图结束拖动时的执行方法
 *  使用方法：设置表视图的delegate，实现- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate方法，在垓方法中直接调用本方法
 **/
- (int)tableViewDidEndDragging;

/**
 *  刷新表视图数据
 *  dataIsAllLoaded 标识数据是否已全部加载（即“上拖加载更多”是否可用）
 **/
- (void)reloadData:(BOOL)dataIsAllLoaded;

//控制器中获取数据成功后调用此方法
-(void)mainUpdateTableView;
-(void)reSetFootViewFrame;

@end

@protocol PullRefreshTableViewDelegate <NSObject>

//下拉刷新 //上拖加载
-(void)pullRefreshOrLoadMore;


@end
