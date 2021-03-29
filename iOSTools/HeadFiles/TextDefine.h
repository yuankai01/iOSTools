//
//  TextDefine.h
//  CpicPeriodicaliPad
//
//  Created by magicmac on 12-9-4.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#ifndef CpicPeriodicaliPad_TextDefine_h
#define CpicPeriodicaliPad_TextDefine_h

#pragma mark _ 拨打电话           
#define kText_CallNum           NSLocalizedString(@"12345678",@"")
#define kText_CallMainNum           NSLocalizedString(@"400 821 5390",@"")

#define kText_Font   @"--unknown-1--"
#define upSpacing 2
#define cellRowHeight 40

#pragma mark - /* 公共模块 */
/* 公共模块 */
/* 网络连接 */
//#define kText_HttpRequestFailed                         NSLocalizedString(@"数据为空 或 网络连接失败", nil)
#define kText_HttpRequestFailed                         NSLocalizedString(@"网络连接失败，请检查网络设置", nil)
//待更正
#define kText_HttpRequestParserError                    NSLocalizedString(@"服务器忙，请稍后再试", nil)
#define kText_Loading                                   NSLocalizedString(@"加载中...", nil)
#define kText_Warning                                   NSLocalizedString(@"提示", nil)

// textField提示
#define kText_LoginUserNameIsEmpty                      NSLocalizedString(@"用户名为空",@"")
#define kText_LoginPasswordIsEmpty                      NSLocalizedString(@"密码为空",@"")
#define kText_LoginPasswordIsWrong                      NSLocalizedString(@"用户名或密码有误",@"")
#define kText_RegisterPasswordIsNotSameToSurePassword   NSLocalizedString(@"两次输入密码不一致",@"")
#define kText_RegisterUserNameIllegal                   NSLocalizedString(@"用户名格式有误",@"")
#define kText_RegisterPasswordIllegal                   NSLocalizedString(@"密码格式有误",@"")
#define kText_Register_FillInVerificationCodeInTwoHour  NSLocalizedString(@"请输入校验码",@"")
#define kText_FillInNewPassword                         NSLocalizedString(@"请输入新密码",@"")
#define kText_ConfirmNewPasswordAgain                   NSLocalizedString(@"请再次输入新密码",@"")
#define kText_ResetPassword                             NSLocalizedString(@"重置密码",@"")
#define kText_NewPassword                               NSLocalizedString(@"新密码：",@"")
#define kText_CurrentPassword                           NSLocalizedString(@"当前密码：",@"")
#define kText_FillInCurrentPassword                     NSLocalizedString(@"请输入当前密码",@"")
#define kText_ConfirmNewPassword                        NSLocalizedString(@"确认新密码：",@"")
#define kText_MyAccount_ModifyUserPwdSuccess            NSLocalizedString(@"密码修改成功", nil)


// 首页
#define kText_BuffetClub                        NSLocalizedString(@"巴菲特CLUB",@"")
#define kText_LoginIn_NavTitle                  NSLocalizedString(@"登录",@"")
#define kText_NavLeftTitle                      NSLocalizedString(@"...", nil)
#define kText_MyCoupon                          NSLocalizedString(@"我的优惠券", nil)
#define kText_AllCoupon                         NSLocalizedString(@"优惠大全", nil)
#define kText_MyAppointment                     NSLocalizedString(@"我的预约", nil)
#define kText_MyAccount                         NSLocalizedString(@"我的账户", nil)
#define kText_NeedToPhoneCall                   NSLocalizedString(@"若您有任何需求或疑问，请拨打电话", nil)
#define kText_TelPhoneNum                       NSLocalizedString(@"400-400-4000", nil)

#define kText_Back                              NSLocalizedString(@"返回",@"")
#define kText_AllCoupons_MemnberShipCard_Title  NSLocalizedString(@"会员卡",@"")
#define kText_MyCoupons_AccommodationVouchers   NSLocalizedString(@"住宿券", nil)
#define kText_Bulk_Title                        NSLocalizedString(@"金牌会员",@"")

// 登录
#define kText_LoginIn_Account                   NSLocalizedString(@"账号：", nil)
#define kText_LoginIn_Password                  NSLocalizedString(@"密码：", nil)
#define kText_LoginIn_RememberMe                NSLocalizedString(@"记住我的登录", nil)
#define kText_LoginIn_ForgetPassword            NSLocalizedString(@"忘记密码？", nil)
#define kText_LoginIn_FillInAccount             NSLocalizedString(@"请输入巴菲特账号", nil)
#define kText_LoginIn_FillInPassword            NSLocalizedString(@"请输入密码", nil)
#define kText_LoginFailed                       NSLocalizedString(@"登录失败",nil)
#define kText_LoginUsernamePasswordEror         NSLocalizedString(@"用户名或密码错误",nil)
#define kText_LoginSuccess                      NSLocalizedString(@"登录成功",nil)

// 退出
#define kText_Logout                       NSLocalizedString(@"退出",@"")

// 注册
#define kText_Register                          NSLocalizedString(@"注册",@"")
#define kText_LoginIn_RewritePassword           NSLocalizedString(@"确认密码：", nil)
#define kText_Register_Email                    NSLocalizedString(@"电子邮箱：",@"")
#define kText_Register_FillInEmail              NSLocalizedString(@"请输入电子邮箱",@"")
#define kText_Register_PhoneNumber              NSLocalizedString(@"手机号：",@"")
#define kText_Register_FillInPhoneNumber        NSLocalizedString(@"请输入手机号",@"")
#define kText_MyAccount_VerificationCode        NSLocalizedString(@"校验码：", nil)
#define kText_MyAccount_SendVerificationCode    NSLocalizedString(@"发送校验码", nil)
#define kText_Register_PleaseInputAuthCode      NSLocalizedString(@"请输入校验码",@"")
#define kText_Regaster_AggreementConditions     NSLocalizedString(@"服务条款",@"")
#define kText_Register_Agreement                NSLocalizedString(@"我已确认《巴菲特用户服务协议》",@"")
#define kText_RegisterNotAgreedRegisterTerms    NSLocalizedString(@"您尚未同意注册条款",@"")


// 我的优惠券
// segment title
#define kText_MyCoupons_Available               NSLocalizedString(@"未用券", nil)
#define kText_MyCoupons_Unactivated             NSLocalizedString(@"使用中", nil)
#define kText_MyCoupons_Used                    NSLocalizedString(@"已用券", nil)
#define kText_MyCoupons_Reserving                    NSLocalizedString(@"预约中", nil)
#define kText_MyCoupons_Using                    NSLocalizedString(@"使用中", nil)
#define kText_MyCoupons_Reserved                    NSLocalizedString(@"已预约", nil)
// sectionherder title

#define kText_MyCoupons_PromotionVouchers       NSLocalizedString(@"限时促销券", nil)
#define kText_MyCoupons_BuffetVouchers          NSLocalizedString(@"餐饮券", nil)
#define kText_MyCoupons_Other                   NSLocalizedString(@"其他", nil)
#define kText_MyCoupons_Package                 NSLocalizedString(@"套餐", nil)
#define kText_MyCoupons_CommonVouchers          NSLocalizedString(@"优惠券", nil)
// button title
#define kText_MyCoupons_ButtonTitle_Reservate       NSLocalizedString(@"预约", nil)
#define kText_MyCoupons_ButtonTitle_Use             NSLocalizedString(@"使用", nil)
#define kText_MyCoupons_ButtonTitle_Delete          NSLocalizedString(@"删除", nil)
#define kText_MyCoupons_ButtonTitle_Gift            NSLocalizedString(@"转赠", nil)
#define kText_MyCoupons_ButtonTitle_Activate        NSLocalizedString(@"激活", nil)
// cell text
#define kText_MyCoupons_ExpiryDate              NSLocalizedString(@"有效期：", nil)
#define kText_MyCoupons_To                      NSLocalizedString(@"至", nil)
#define kText_MyCoupons_UseAt                   NSLocalizedString(@"使用时间：", nil)
#define kText_MyCoupons_PrincipalCard           NSLocalizedString(@"主", nil)
#define kText_MyCoupons_SupplementaryCard       NSLocalizedString(@"副", nil)
#define kText_MyCoupons_VerificationCode        NSLocalizedString(@"验证码：", nil)

#define kText_WaitingForServer                  NSLocalizedString(@"待服务器验证", nil)
#define kText_SuccessfullyVerifiedWaitForConfirmation  NSLocalizedString(@"使用中,待商户确认", nil)
#define kText_ConfirmationFailed                NSLocalizedString(@"商户确认失败，请重试或直接在商户pad验证会员卡号与优惠券号", nil)
#define kText_MembershipHasExpired              NSLocalizedString(@"会籍已过期，请先续购会籍", nil)

#define kText_VoucherHasExpired                 NSLocalizedString(@"优惠券已过期", nil)
#define kText_MyCoupons_Message_DeleteSuccess       NSLocalizedString(@"删除成功", nil)
#define kText_MyCoupons_Around500               NSLocalizedString(@"500米内优惠券", nil)
#define kText_MyCoupons_Around1000              NSLocalizedString(@"1000米内优惠券", nil)
#define kText_MyCoupons_Around3000              NSLocalizedString(@"3000米内优惠券", nil)

#define kText_CurrentLocation                   NSLocalizedString(@"当前位置", nil)
#define kText_More                              NSLocalizedString(@"更多", nil)
#define kText_NearBy                            NSLocalizedString(@"附近", nil)
#define kText_Map                               NSLocalizedString(@"地图",@"") 

#define kText_FailedToUseThisVoucher            NSLocalizedString(@"该券暂时无法使用，请在商户pad验证会员卡号与优惠券号或直接联系客服",@"")
#define kText_CallUs                            NSLocalizedString(@"联系客服",@"") 
#define kText_GiftRecordNeedBuyBulkmembership   NSLocalizedString(@"您需要购买散货会籍才能激活",nil)

#define kText_BuffetClubNeedToPinpointYourCurrentLocation NSLocalizedString(@"巴菲特CLUB要使用您当前的位置",nil)
#define kText_Refuse                            NSLocalizedString(@"不允许",@"")
#define kText_Accept                            NSLocalizedString(@"允许",@"")
#define kText_Sure                              NSLocalizedString(@"确定",@"")
#define kText_Cancel                            NSLocalizedString(@"取消",@"")

//限时促销券预约单 @"请填写提货日期yyyy-MM-dd" @"请输入正确的日期"
#define kText_Promotion_GetDate                 NSLocalizedString(@"提货日期: ", nil)
#define kText_Promotion_GetDateAlert                 NSLocalizedString(@"请输入提货日期", nil)
#define kText_Promotion_GetDateRightDate                 NSLocalizedString(@"请输入正确的日期", nil)
#define kText_Promotion_GetDatePlaceHolder      NSLocalizedString(@"请输入提货日期yyyy-MM-dd", nil)
#define kText_Promotion_OutDate                 NSLocalizedString(@"您输入的时间已过期", nil)
#define kText_Promotion_CredicCardOutDate                 NSLocalizedString(@"信用卡有效期已过期", nil)

// 填写住宿券预约单
#define kText_ReservationForm_NavTitle          NSLocalizedString(@"住宿券预约单", nil)
#define kText_ReservationForm_Promotion         NSLocalizedString(@"限时促销券预约单", nil)
#define kText_ReservationForm_IdNumber          NSLocalizedString(@"身份证号：", nil)
#define kText_ReservationForm_FillInIdNumber    NSLocalizedString(@"请填写入住人的身份证号", nil)
#define kText_ReservationForm_Hotel             NSLocalizedString(@"酒店：", nil)
#define kText_ReservationForm_FillInHotelName   NSLocalizedString(@"请选择入住酒店", nil)
#define kText_ReservationForm_RoomType          NSLocalizedString(@"房型：", nil)
#define kText_ReservationForm_FillInRoomType    NSLocalizedString(@"请选择房型", nil)
#define kText_ReservationForm_StandardQueenRoom NSLocalizedString(@"标准大床房", nil)
#define kText_ReservationForm_StandardDoubleRoom NSLocalizedString(@"标准双人房", nil)
#define kText_ReservationForm_NumberNights      NSLocalizedString(@"住宿天数：", nil)
#define kText_ReservationForm_AcommodationDays  NSLocalizedString(@"请选择入住天数",nil)
#define kText_ReservationForm_CheckInDate       NSLocalizedString(@"入住时间：", nil)
#define kText_ReservationForm_FillInCheckInDate NSLocalizedString(@"请选择入住时间", nil)

#define kText_ReservationForm_ReserveHotelDays  NSLocalizedString(@"请提前21天预约酒店", nil)
#define kText_ReservationForm_Submit            NSLocalizedString(@"确定预约", nil)
#define kText_Reservation_ReceivedYourReservation  NSLocalizedString(@"我们已收到您的预约申请，稍后将以短信给您确认；您可以在我的预约中查看或取消本次预约", nil)


#define kText_Reservation_ReservationTimeLimit  NSLocalizedString(@"预约时限：", nil)
#define kText_CheckInAt                         NSLocalizedString(@"入住时间", nil)
#define kText_ChooseHotel                       NSLocalizedString(@"入住酒店", nil)
#define kText_ChooseRoomType                    NSLocalizedString(@"入住房型", nil)

// 新加的   信用卡号和信用卡有效期
#define kText_ReservationForm_ReserveHotelLimitAppointmentLabel  NSLocalizedString(@"请提前21天预约", nil)
#define kText_ReservationForm_CreditCardNum     NSLocalizedString(@"信用卡号:", nil)
#define kText_ReservationForm_CreditCardNumInput     NSLocalizedString(@"请输入信用卡号", nil)
#define kText_ReservationForm_CreditCardValidity      NSLocalizedString(@"信用卡有效期: ", nil)
#define kText_ReservationForm_CreditCardValidityInput      NSLocalizedString(@"请输入有效期yyMM", nil)
#define kText_ReservationForm_CreditCardValidityDateInput      NSLocalizedString(@"请输入信用卡有效期", nil)
#define kText_ReservationForm_CreditCardNumIllegal      NSLocalizedString(@"信用卡号格式错误", nil)
#define kText_ReservationForm_CreditCardValidityIllegal      NSLocalizedString(@"信用卡有效期格式(yyMM)错误", nil)

#define kText_ReservationForm_CheckInDateEarly      NSLocalizedString(@"入住时间小于当前时间", nil)
#define kText_ReservationForm_CreditCardTimeLessCheckInDate      NSLocalizedString(@"入住时间在信用卡有效期外,请更换信用卡或更改入住时间", nil)

//身份证号
#define kText_ReservationForm_cardID                    NSLocalizedString(@"请输入正确的身份证号", nil)

// 未使用和未激活的 券详情
#define kText_PrincipalCardProduct              NSLocalizedString(@"主卡套餐",nil)
#define kText_SupplementaryCardProduct          NSLocalizedString(@"附属卡套餐",nil)
#define kText_SendPrincipalCardProduct          NSLocalizedString(@"转赠主卡套餐",nil)
#define kText_SendSupplementaryCardProduct      NSLocalizedString(@"转赠副卡套餐",nil)
#define kText_ActivatePrincipalCardProduct      NSLocalizedString(@"激活主卡套餐",nil)
#define kText_ActivateSupplementaryCardProduct  NSLocalizedString(@"激活副卡套餐",nil)

// 优惠大全
// 筛选位置  
#define kText_Search_Search                             NSLocalizedString(@"搜索", nil)
#define kText_Search_Keyword                            NSLocalizedString(@"请输入关键字", nil)
#define kText_Search_ChooseCity                         NSLocalizedString(@"筛选位置", nil)
#define kText_Search_SearchBar_FilterButtonTitle        NSLocalizedString(@"筛选", nil)
#define kText_Search_Type                               NSLocalizedString(@"类型", nil)
#define kText_Search_Sort                               NSLocalizedString(@"排序", nil)

#define kText_Search_All                                NSLocalizedString(@"全部", nil)
#define kText_Search_Membership                         NSLocalizedString(@"会籍", nil)
#define kText_Search_Accommodation                      NSLocalizedString(@"住宿", nil)
#define kText_Search_Promotion                          NSLocalizedString(@"限时促销", nil)
#define kText_Search_Restaurant                         NSLocalizedString(@"餐饮", nil)
#define kText_Search_SPA                                NSLocalizedString(@"SPA", nil)

#define kText_Search_Range                              NSLocalizedString(@"范围", nil)

#define kText_NearByDistance_500                        NSLocalizedString(@"500",@"")
#define kText_NearByDistance_1000                       NSLocalizedString(@"1000",@"")
#define kText_NearByDistance_3000                       NSLocalizedString(@"3000",@"")
#define kText_NearByDistanceIn                          NSLocalizedString(@"米内",@"")

// 排序
#define kText_Sort_LatestReleased                       NSLocalizedString(@"最新发布",@"")
#define kText_Sort_PriceLowToHigh                       NSLocalizedString(@"价格最低",@"")
#define kText_Sort_PriceHighToLow                       NSLocalizedString(@"价格最高",@"")
#define kText_Sort_StarsHighToLow                       NSLocalizedString(@"星级最高",@"")
#define kText_Sort_StarsLowToHigh                       NSLocalizedString(@"星级最低",@"")
#define kText_Sort_NearestHotel                         NSLocalizedString(@"距离最近",@"")
#define kText_Sort_TopRecommended                       NSLocalizedString(@"火热推荐",@"")
#define kText_Sort_No                                   NSLocalizedString(@"不排序",@"")
#define kText_Done                                      NSLocalizedString(@"完成",@"")

// 距离
#define kText_Distance_Around_All                       NSLocalizedString(@"全部",@"")
#define kText_Distance_Around_500                       NSLocalizedString(@"附近500米",@"")
#define kText_Distance_Around_1000                      NSLocalizedString(@"附近1000米",@"")
#define kText_Distance_Around_3000                      NSLocalizedString(@"附近3000米",@"")

//附近
#define kText_AllCoupons_Nearby_NoMerchants         NSLocalizedString(@"附近没有商户",@"")
#define kText_AllCoupons_Nearby_NearCityId          NSLocalizedString(@"99999",@"")
#define kText_AllCoupons_Nearby_AllCityId           NSLocalizedString(@"0",@"")

// 转赠
#define kText_Gift_SendGift                     NSLocalizedString(@"我要转赠",@"")
#define kText_Gift_Gift                         NSLocalizedString(@"转赠品：",@"")
#define kText_Gift_SendTo                       NSLocalizedString(@"转赠给：",@"")
#define kText_Gift_PlaceHolder                  NSLocalizedString(@"已注册的巴菲特用户",@"")
#define kText_Confirm                           NSLocalizedString(@"确认转赠",nil)
#define kText_Gift_SuccessfullyTransfered       NSLocalizedString(@"转赠成功，我们将短信通知您和您的转赠客户",@"")
#define kText_Gift_FailedWithUserError          NSLocalizedString(@"转赠失败,该用户不存在",@"")

// 我的预约
#define kText_MyAppointment_Reserveding        NSLocalizedString(@"预约中", nil)
#define kText_MyAppointment_Confirming        NSLocalizedString(@"确认中", nil)
#define kText_MyAppointment_Reserved        NSLocalizedString(@"已预约", nil)
#define kText_MyAppointment_Canceling       NSLocalizedString(@"取消中", nil)
#define kText_MyAppointment_CanceleSuccess        NSLocalizedString(@"取消成功", nil)
#define kText_MyAppointment_CancelTimeLimit           NSLocalizedString(@" 取消时限：", nil)
#define kText_MyAppointment_TwentyDaysBefore    NSLocalizedString(@"提前20天", nil)
#define kText_MyAppointment_ReReservation       NSLocalizedString(@"若要修改预约单则需取消后重新填写", nil)
#define kText_MyAppointment_WaitForConfirmation NSLocalizedString(@"已提交申请，待客服确认", nil)
#define kText_MyAppointment_Cancel              NSLocalizedString(@"取消预约", nil)
#define kText_MyAppointment_Successfully        NSLocalizedString(@"预约成功", nil)
#define kText_MyAppointment_Failed      NSLocalizedString(@"预约失败", nil)
#define kText_MyAppointment_OverdueTimeLimit    NSLocalizedString(@"取消时限已到,请即时入住,逾期作已用处理", nil)
#define kText_MyAppointment_MyReservationRecord NSLocalizedString(@"预约历史记录", nil)
#define kText_MyAppointment_CancelledTime       NSLocalizedString(@"取消时间", nil)
#define kText_MyAppointment_GetPromotionDate                   NSLocalizedString(@"提货时间：", nil)
#define kText_MyAppointment_ConvertPromotionSuccess        NSLocalizedString(@"兑换成功", nil)
#define kText_MyAppointment_SureConvertPromotion        NSLocalizedString(@"确认兑换", nil)

// 我的账户
#define kText_MyAccount_NavTitle                NSLocalizedString(@"用户信息", nil)
#define kText_MyAccount_Edit                    NSLocalizedString(@"编辑", nil)
#define kText_MyAccount_Email                   NSLocalizedString(@"邮箱：", nil)
#define kText_MyAccount_FillInEmail             NSLocalizedString(@"请输入您的email地址", nil)
#define kText_MyAccount_Mobile                  NSLocalizedString(@"手机：", nil)
#define kText_MyAccount_FillInMobileNum         NSLocalizedString(@"请输入您的手机号", nil)
#define kText_MyAccount_UserName                NSLocalizedString(@"称谓：", nil)
#define kText_MyAccount_FillInUserName          NSLocalizedString(@"请输入您的称谓", nil)
#define kText_MyAccount_ResetPassword           NSLocalizedString(@"修改密码", nil)
#define kText_MyAccount_BuffetClubMembership    NSLocalizedString(@"会籍信息", nil)
#define kText_MyAccount_BulkMembership          NSLocalizedString(@"金牌会员：", nil)
#define kText_Save              NSLocalizedString(@"保存",@"")

// 转赠记录
#define kText_GiftList                          NSLocalizedString(@"转赠记录", nil)
#define kText_GiftSent                          NSLocalizedString(@"已送出", nil)
#define kText_GiftReceived                      NSLocalizedString(@"已收到", nil)
#define kText_GiftRecordSend                    NSLocalizedString(@"赠与", nil)
#define kText_GiftRecordReceive                 NSLocalizedString(@"收", nil)

// 会员卡
#define kText_EnterWeb                          NSLocalizedString(@"您可以进入网站购买",@"")
#define kText_Introduce                         NSLocalizedString(@"介绍",@"")
#define kText_Merchants                         NSLocalizedString(@"合作商户",@"")
#define kText_Handle                            NSLocalizedString(@"操作",@"")

// 酒店介绍
#define kText_HotelIntroduce_CallNumber         NSLocalizedString(@"是否拨打电话：",@"")
#define kText_CardInfo_Address                  NSLocalizedString(@"地址：", nil)
#define kText_CardInfo_Phone                    NSLocalizedString(@"电话：", nil)
#define kText_CardInfo_Call                     NSLocalizedString(@"拨打", nil)
#define kText_CardInfo_HotelIntroduce           NSLocalizedString(@"酒店介绍", nil)
#define kText_CardInfo_HotelTermsAndConditions  NSLocalizedString(@"订房须知和条款细则", nil)
#define kText_HotelIntroduce_Terms              NSLocalizedString(@"条款细则", nil)

#define kText_HotelIntroduce_MemberAccommodation    NSLocalizedString(@"会员卡/住宿券", nil)
#define kText_HotelIntroduce_MemberPromotion        NSLocalizedString(@"会员卡/限时促销券", nil)
#define kText_AttachedCards                         NSLocalizedString(@"附属卡", nil)
#define kText_CardInfo_BusinessHours                NSLocalizedString(@"营业时间：", nil)

#define kText_PickupAddress                         NSLocalizedString(@"提货地址", nil)
#define kText_ProductSynopsis                       NSLocalizedString(@"产品简介", nil)

// 更多
#define kText_More_UserFeedback                 NSLocalizedString(@"用户反馈",@"")
#define kText_More_AboutBuffetClub              NSLocalizedString(@"关于巴菲特",@"")
#define kText_More_FillInFeedback               NSLocalizedString(@"请输入反馈",@"")
#define kText_More_YourFeedbackEmpty            NSLocalizedString(@"输入内容为空",@"")

#define kText_Submit            NSLocalizedString(@"提交",nil)
#define kText_More_Feedback_ThanksSuggestions   NSLocalizedString(@"感谢您的建议",@"")

//分页请求数据
#define kText_SwitchCityPageSize              @"13"
#define kText_AllCouponsPageSize              @"10"
#define kText_TransferedRecordPageSize              @"5"

//下拉刷新
#define kText_Pull_Downrefresh                NSLocalizedString(@"下拉可以刷新",@"")
#define kText_Pull_UpMore                     NSLocalizedString(@"上拖加载更多",@"")
#define kText_Pull_ReleaseRefresh             NSLocalizedString(@"释放刷新数据",@"")
#define kText_Pull_ReleaseLoad                NSLocalizedString(@"释放加载数据",@"")
#define kText_Pull_Refreshing                 NSLocalizedString(@"正在刷新...",@"")
#define kText_Pull_Loading                    NSLocalizedString(@"正在加载...",@"")
#define kText_Pull_Loaded                     NSLocalizedString(@"已加载全部数据",@"")
#define kText_Pull_RefreshTime                NSLocalizedString(@"上次更新于",@"")

#endif
