//
//  RequestCMD.h
//  Colourful
//
//  Created by MagicPoint on 13-9-22.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//  

#ifndef Colourful_RequestCMD_h
#define Colourful_RequestCMD_h

#pragma mark URL

#define url_baseURL     [NSURL URLWithString:@"http://192.168.0.171:8082/index.php/openapi/buffetapi/api"]
#define url_subBaseURL        @"http://192.168.0.171:8082/"

//#define url_baseURL     [NSURL URLWithString:@"http://192.168.0.169/index.php/openapi/buffetapi/api"]
//#define url_subBaseURL     @"http://192.168.0.169/"


#define url_testImageUrl  [NSURL URLWithString:@"http://192.168.0.18/NewBuffetClub/web/public/images/1b/31/c5/39673a979d8546e0b3a5b77d323e833a.jpg"]
//*****************************
#pragma mark - 所有产品

#define RequestCMD_AllCoupons_AllList @"11101" //所有产品 / 优惠大全 列表
#define RequestCMD_AllCoupons_ComboDetails @"11102"  // 套餐详情
#define RequestCMD_AllCoupons_RightCardsDetails @"11103"  //权益卡详情
#define RequestCMD_AllCoupons_AccommodationDetails @"11104"  // 住宿券详情
#define RequestCMD_AllCoupons_SPADetails @"11105"  // SPA详情
#define RequestCMD_AllCoupons_DinnerDetails @"11106"  // 餐饮券详情

#define RequestCMD_AllCoupons_SigleRightCardsRangeOfHotel @"11107"  // 单品权益卡使用商户
#define RequestCMD_AllCoupons_AccommodationRangeOfCity @"11108"  // 单品非权益卡使用城市范围
#define RequestCMD_AllCoupons_AccommodationRangeOfHotel_InCity @"11109"  // 单品住宿券使用城市商户
#define RequestCMD_AllCoupons_DinnerRangeOfHotel @"11110"  // 单品餐饮券使用城市商户
#define RequestCMD_AllCoupons_HotelDetails @"11111"  // 酒店详情
#define RequestCMD_AllCoupons_ComboRightCardsRangeOfHotel @"11112"  // 套餐权益卡使用商户
#define RequestCMD_AllCoupons_ComboDinnerRangeOfCity @"11113"  // 套餐餐饮券使用城市
#define RequestCMD_AllCoupons_ComboDinnerRangeOfHotelInCity @"11114"  // 套餐餐饮券使用城市商户

//*****************************
#pragma mark - 我的权益-按类别

#define RequestCMD_MyRight_Category_Dinner @"12101"  // 我的餐饮券
#define RequestCMD_MyRight_Category_Accommodation @"12102"  // 我的住宿券
#define RequestCMD_MyRight_Category_RightCards @"12103"  // 我的权益卡
#define RequestCMD_MyRight_Category_DinnerRangeOfCity @"12104"  // 我的餐饮券城市统计

//*****************************
#pragma mark - 我的权益-按产品
#define RequestCMD_MyRight_Products_Combo @"13101"  // 我的权益套餐
#define RequestCMD_MyRight_Products_CouponsStats @"13102"  // 我的权益优惠券统计
#define RequestCMD_MyRight_Products_RightCards @"13103"  // 我的权益卡
#define RequestCMD_MyRight_Products_StatsInCombo @"13104"  // 套餐所含权益统计
#define RequestCMD_MyRight_Products_DinnerRangeOfCityInCombo @"13105"  // 套餐内餐饮券城市统计
#define RequestCMD_MyRight_Products_DinnerInCombo @"13106"  // 套餐内餐饮券
#define RequestCMD_MyRight_Products_AccommodationInCombo @"13107"  // 套餐内住宿券

//*****************************
#pragma mark - 我的权益操作

#define RequestCMD_MyRight_Operate_AccommodationResMerchantList @"14101"  // 住宿券预约商户列表
#define RequestCMD_MyRight_Operate_AccommodationResDays @"14102"  // 住宿预约商户天数列表
#define RequestCMD_MyRight_Operate_AccommodationRes @"14203"  // 下住宿商户预约单
#define RequestCMD_MyRight_Operate_BuffetRes @"14204"  // 下自助餐预约单
#define RequestCMD_MyRight_Operate_DonateSigle @"14205"  // 单券转赠
#define RequestCMD_MyRight_Operate_DonateCombo @"14206"  // 套餐转赠

//*****************************
#pragma mark - 我的预约

#define RequestCMD_MyReservation_List @"15101"  // 预约列表
#define RequestCMD_MyReservation_Details @"15102"  // 预约单详情
#define RequestCMD_MyReservation_Cancel @"15203"  // 取消/使用预约

//*****************************
#pragma mark - 我的账号

#define RequestCMD_MyAccount_Login @"17201"  // 用户登录
#define RequestCMD_MyAccount_Regist @"17202"  // 用户注册
#define RequestCMD_MyAccount_ResetPassword @"17203"  // 忘记密码 / 密码重置 
#define RequestCMD_MyAccount_EditUserInfo @"17204"  // 编辑账户信息
#define RequestCMD_MyAccount_ModifyPassword @"17205"  // 修改密码
#define RequestCMD_MyAccount_SendPhoneCode @"17206"  // 发送手机验证码
#define RequestCMD_MyAccount_FistPageInfo @"17107"  // 账户首页信息
#define RequestCMD_MyAccount_DonateRecord @"17108"  // 赠出记录
#define RequestCMD_MyAccount_GetRecord @"17109"  // 收到记录
#define RequestCMD_MyAccount_WaitingActivationOrder @"17110"  // 待激活订单
#define RequestCMD_MyAccount_HistoryOrder @"17111"  // 历史订单
#define RequestCMD_MyAccount_ActivationOrder @"17212"  // 激活订单
#define RequestCMD_MyAccount_OrderDetails @"17113"  // 订单详情
#define RequestCMD_MyAccount_BingdingPhone @"17214"  // 绑定手机号  
#define RequestCMD_MyAccount_DonationDetailsList @"17116"  // 转赠详情列表 




//*****************************
#pragma mark - 更多
#define RequestCMD_CityList @"18102"  // 城市列表
#define RequestCMD_UserFeedBack @"18201"  // 用户反馈

////*****************************
//#pragma mark - 注册登录
//
//#define RequestCMD_Login  @"17201"   //用户登录
//#define RequestCMD_Regist @"17202"   //用户注册


#endif
