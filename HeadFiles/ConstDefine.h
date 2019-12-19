//
//  ConstDefine.h
//  CETCHospital
//
//  Created by gao on 16/4/14.
//  Copyright © 2016年 Aaron Yu. All rights reserved.
/*
 常量头文件
 */

#ifndef ConstDefine_h
#define ConstDefine_h

#define kPageSize                   50          //单页拉去
#define kPageSizeMax                10000       //默认全部拉取数据

#define kAddGroupMemMaxNum          50      //添加群成员最大数量
#define kGroupMemMaxNum             499      //群成员最大数量
#define kTextAddMemberMaxNum        @"每次只能添加50个群成员"
#define kTextGroupMaxNum            @"群成员超过499后不可添加"

#pragma mark - 通知 ********

#define kNotificationModifyGroupName            @"kNotificationModifyGroupName"     //修改群名称
#define kNotificationReleaseNotice              @"kNotificationReleaseNotice"       //发布群公告
#define kNotificationQuitGroup                  @"kNotificationQuitGroup"           //退群
#define kNotificationDismissGroup               @"kNotificationDismissGroup"        //解散群
#define kNotificationAddGroupMember             @"kNotificationAddGroupMember"       //添加群成员
#define kNotificationDelGroupMember             @"kNotificationDelGroupMember"       //删除群成员

#endif /* ConstDefine_h */
