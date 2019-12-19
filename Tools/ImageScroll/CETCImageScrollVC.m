//
//  CETCImageScrollVC.m
//  CETCPatientCommunity
//
//  Created by xuyang on 2017/5/25.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import "CETCImageScrollVC.h"
#import "CETCImageScrollCell.h"

@interface CETCImageScrollVC ()

@property (strong, nonatomic)UILabel *lblNumber;

@end

@implementation CETCImageScrollVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CETCImageScrollCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.pagingEnabled = YES;
    self.lblNumber.text = [NSString stringWithFormat:@"%ld/%lu",self.selectIndex+1,self.images.count];

    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
}

- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CETCImageScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *imageUrl = self.images[indexPath.row];
    [cell setImageUrl:imageUrl];
    cell.imageTouchBlock = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.lblNumber.text = [NSString stringWithFormat:@"%ld/%lu",indexPath.row+1,self.images.count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (id)init
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为水平流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
    }
    return self;
}


- (UILabel *)lblNumber
{
    if (!_lblNumber) {
        
        CGRect rect = [UIScreen mainScreen].bounds;
        
        _lblNumber = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(rect)-50, CGRectGetWidth(rect), 20)];
        _lblNumber.textAlignment = NSTextAlignmentCenter;
        _lblNumber.textColor = [UIColor whiteColor];
        _lblNumber.font = [UIFont systemFontOfSize:16.0];
        [self.view addSubview:_lblNumber];
    }
    return _lblNumber;
}
@end
