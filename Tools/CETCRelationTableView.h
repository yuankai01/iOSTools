//
//  CETCRelationTableView.h
//  CETCDoctorCommunity
//
//  Created by gao on 2017/5/18.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CETCBaseModel.h"

@class CETCRelationModel;

@interface CETCRelationTableView : UIView

@property (nonatomic,strong) NSArray *majorArray;       //一级列表数组
@property (nonatomic,strong) NSArray *subArray;         //二级列表数组

@property (nonatomic,copy) void (^selectedItem)(CETCRelationModel *majorItem,CETCItemModel *subItem);

@end


@interface CETCRelationModel : CETCBaseModel

@property (nonatomic,strong) CETCItemModel *majorModel;
@property (nonatomic,strong) NSArray *subArray;

@end

