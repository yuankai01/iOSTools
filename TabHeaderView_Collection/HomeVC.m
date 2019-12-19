//
//  HomeVC.m
//  FarbenOffice
//
//  Created by Gao on 2019/12/18.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "HomeVC.h"
#import "HomeSectionHeaderView.h"
#import "HomeItemCell.h"

#define kHeaderHeight   260
#define kHomeCollectionItem       @"kHomeCollectionItem"
#define kHomeSectionHeaderItem       @"kHomeSectionHeaderItem"

@interface HomeVC () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *homeCollectionView;
@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) NSMutableArray *workArray;    //工作日常
@property (strong, nonatomic) NSMutableArray *formsArray;   //报表统计

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.homeCollectionView addSubview:self.headerView];
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

#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.workArray.count;
    }else
    return self.formsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeCollectionItem forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.titleLab.text = self.workArray[indexPath.item];
    }else
    {
        cell.titleLab.text = self.formsArray[indexPath.item];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HomeSectionHeaderView *secHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHomeSectionHeaderItem forIndexPath:indexPath];
        
        secHeaderView.titleLab.text = (@[@"日常工作",@"报表统计"])[indexPath.section];
        
        return secHeaderView;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 懒加载 *****************
- (UICollectionView *)homeCollectionView
{
    if (!_homeCollectionView) {
        
        CGFloat padding = 15;
        CGFloat itemWidth = (SCREEN_WIDTH - padding * 5) / 4;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40);
        
        _homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_homeCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeItemCell class]) bundle:nil] forCellWithReuseIdentifier:kHomeCollectionItem];
        [_homeCollectionView registerClass:[HomeSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHomeSectionHeaderItem];
        
        _homeCollectionView.dataSource = self;
        _homeCollectionView.delegate = self;
        _homeCollectionView.backgroundColor = [UIColor clearColor];
        _homeCollectionView.backgroundView = nil;
        _homeCollectionView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
        _homeCollectionView.contentOffset = CGPointZero;
        [self.view addSubview:_homeCollectionView];
        
        [_homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        if (@available(iOS 11.0, *)) {
            _homeCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _homeCollectionView;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -kHeaderHeight, SCREEN_WIDTH, kHeaderHeight)];
        _headerView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _headerView;
}

- (NSMutableArray *)workArray
{
    if (!_workArray) {
        _workArray = [[NSMutableArray alloc] initWithCapacity:8];
        [_workArray addObjectsFromArray:@[@"客户交付",@"项目交付",@"需求管理",@"人员管理",@"面试管理",@"客户拜访"]];
    }
    
    return _workArray;
}

- (NSMutableArray *)formsArray
{
    if (!_formsArray) {
        _formsArray = [[NSMutableArray alloc] initWithCapacity:8];
        [_formsArray addObjectsFromArray:@[@"资源交付",@"需求统计",@"在职统计",@"简历库",@"添加"]];
    }
    
    return _formsArray;
}

@end
