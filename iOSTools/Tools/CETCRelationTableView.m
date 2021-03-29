//
//  CETCRelationTableView.m
//  CETCDoctorCommunity
//
//  Created by gao on 2017/5/18.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import "CETCRelationTableView.h"

@interface CETCRelationTableView () <UITableViewDataSource,UITableViewDelegate>
{
    CETCRelationModel *_majorSelectModel;     //主列表选中model
}

@property (nonatomic,strong) UITableView *majorTableView;
@property (nonatomic,strong) UITableView *subTableView;

@end

@implementation CETCRelationTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.majorTableView];
        [self addSubview:self.subTableView];
    }
    
    return self;
}

- (void)setMajorArray:(NSArray *)majorArray
{
    _majorArray = majorArray;
    [self.majorTableView reloadData];
    
    //刷子二级数据
    if (majorArray.count > 0) {
        _majorSelectModel = majorArray[0];
        self.subArray = [_majorSelectModel.subArray mutableCopy];
        
        [self.subTableView reloadData];
        
        [self.majorTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
//        [self.subTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.majorTableView)
    {
        return self.majorArray.count;
    }else
    {
        return self.subArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDentify = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDentify];
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = CETC_MAIN_COLOR;
        cell.textLabel.textColor = CETC_BLACK_COLOR;
        cell.textLabel.font = FONT_WITH_SIZE(15.0);
    }
    
    if (tableView ==self.majorTableView)
    {
        cell.backgroundColor = CETC_GRAY_COLOR_BG;
        
        CETCRelationModel *model = self.majorArray[indexPath.row];
        cell.textLabel.text = model.majorModel.name;
    }
    else
    {
        CETCItemModel *model = self.subArray[indexPath.row];
        cell.textLabel.text = model.name;
    }
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.majorTableView)
    {
        CETCRelationModel *model = self.majorArray[indexPath.row];
        self.subArray = [model.subArray mutableCopy];
        [self.subTableView reloadData];
        
        _majorSelectModel = model;
    }else   //选择的二级数据
    {
        CETCItemModel *model = self.subArray[indexPath.row];
        
        if (self.selectedItem) {
            self.selectedItem(_majorSelectModel, model);
        }
    }
}

#pragma mark - 懒加载
-(UITableView *)majorTableView
{
    if (!_majorTableView)
    {
        _majorTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 140, CGRectGetHeight(self.frame)) style:UITableViewStylePlain];
        _majorTableView.backgroundColor = CETC_GRAY_COLOR_BG;
        _majorTableView.delegate = self;
        _majorTableView.dataSource = self;
        _majorTableView.tableFooterView = [[UIView alloc]init];
    }
    
    return _majorTableView;
}

-(UITableView *)subTableView
{
    if (!_subTableView)
    {
        _subTableView = [[UITableView alloc]initWithFrame:CGRectMake(140, 0, APP_SCREEN_WIDTH-140, CGRectGetHeight(self.frame)) style:UITableViewStylePlain];
        _subTableView.delegate = self;
        _subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _subTableView.dataSource = self;
    }
    
    return _subTableView;
}

@end

@implementation CETCRelationModel

@end
