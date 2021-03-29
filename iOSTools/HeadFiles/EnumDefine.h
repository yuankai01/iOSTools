//
//  EnumDefine.h
//  CETCHospital
//
//  Created by gao on 16/4/5.
//  Copyright © 2016年 Aaron Yu. All rights reserved.
//

#ifndef EnumDefine_h
#define EnumDefine_h

#pragma mark - 发起群聊 选择类别
typedef NS_ENUM(NSInteger,CreatGroupChatType)
{
    CreatGroupChatType_StartLink        = 1,    //星标联系人
    CreatGroupChatType_Depatment        = 2,    //选择科室
    CreatGroupChatType_PropertyLab      = 3,    //属性标签 质控员/职务等
};

#pragma mark - 群消息设置 是群主还是成员
typedef NS_ENUM(NSInteger,ChatGroupMemberType)
{
    ChatGroupMemberType_Creater      = 1,    //群主 创建者
    ChatGroupMemberType_Common       = 2,    //群成员
};

#pragma mark - 聊天界面 个人/群聊
typedef NS_ENUM(NSInteger,ChatType)
{
    ChatType_Person     = 0,    //个人 默认
    ChatType_Group      = 1,    //群聊
};

#pragma mark - 筛选群成员 添加/删除群成员/发起群时搜索成员
typedef NS_ENUM(NSInteger,SelectMemberType)
{
    SelectMemberType_Creat      = 1,    //创建群成员
    SelectMemberType_Search     = 2,    //创建群时搜索成员
    SelectMemberType_Add        = 3,    //添加群成员
    
    SelectMemberType_Delete     = 4,    //删除群成员
    SelectMemberType_Share      = 5,    //分享质控报表
};

#pragma mark - 院内通知类型
typedef NS_ENUM(NSInteger,NoticeType)
{
    NoticeType_DocTask  = 1,     //医生任务
    NoticeType_NurseTask,   //护理任务
    NoticeType_Alert,       //提醒告知
    NoticeType_QC,          //质控管理
    NoticeType_Warning,     //危机预警
};

#pragma mark - 折线类型：体温、脉搏、检验数据折线图
typedef NS_ENUM(NSInteger,LineType)
{
    LineType_Other,         //脉搏、其他
    
    LineType_Axilla,        //腋温
    LineType_Mouth,         //口温
    LineType_Ear,           //耳温
    LineType_Anus,          //肛温
};

#endif /* EnumDefine_h */
