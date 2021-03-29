//
//  MyVC.m
//  FarbenOffice
//
//  Created by Gao on 2019/12/18.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "MyVC.h"
#import "MyTabCellT.h"
#import "MyTabHeaderView.h"

#define kMyMainCell     @"kMyMainCell"

@interface MyVC ()

@property (strong, nonatomic) MyTabHeaderView *headerView;

@end

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showItems = @[@"待办",@"待阅",@"关注",@"日程",@"会议"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyTabCellT class]) bundle:nil] forCellReuseIdentifier:kMyMainCell];
    
    [self.tableView layoutIfNeeded];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.showItems.count;
    }else if (section == 1)
    {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTabCellT *cell = [tableView dequeueReusableCellWithIdentifier:kMyMainCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        cell.titleLab.text = self.showItems[indexPath.row];
    }else cell.titleLab.text = @"设置";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        [G_App switchRootMainVC:NO];
    }
}

#pragma mark - scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < 0) {
        CGFloat totalOffset = CGRectGetHeight(self.tableView.tableHeaderView.frame) + ABS(yOffset);
        CGFloat f = totalOffset / CGRectGetHeight(self.tableView.tableHeaderView.frame);

        [self.headerView.bgImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH * (1 - f) / 2);
            make.top.mas_equalTo(yOffset);
            make.width.mas_equalTo(SCREEN_WIDTH * f);
            make.height.mas_equalTo(totalOffset);
        }];
    }
}

#pragma mark - 懒加载 *****************
- (MyTabHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MyTabHeaderView class]) owner:self options:nil].firstObject;;
    }
    
    return _headerView;
}

@end
