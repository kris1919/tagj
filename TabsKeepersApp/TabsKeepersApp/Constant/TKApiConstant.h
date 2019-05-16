//
//  TKApiConstant.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/11.
//  Copyright © 2019 Marco. All rights reserved.
//

#ifndef TKApiConstant_h
#define TKApiConstant_h

//域名https://www.showdoc.cc/321034458440338
static NSString *const kTKApiConstantDomin = @"http://wuye.gugangkf.cn/";


//首页
static NSString *const kTKApiConstantHomeBanner = @"json/getIndex.aspx";
static NSString *const kTKApiConstantHomeAD = @"json/getGg.aspx";

static NSString *const kTKApiConstantCurrentWaterFee = @"json/getShuiFei.aspx";
static NSString *const kTKApiConstantHistoryWaterFee = @"json/getShuiFeiLiShi.aspx";

static NSString *const kTKApiConstantCurrentWYFee = @"json/getWuYeFei.aspx";
static NSString *const kTKApiConstantHistoryWYFee = @"json/getWuYeFeiLiShi.aspx";

static NSString *const kTKApiConstantGetServiceType = @"json/getLieBie.aspx";
static NSString *const kTKApiConstantGetShopList = @"json/getShop.aspx";
//小区公告
static NSString *const kTKApiConstantNotification = @"json/getGongGao.aspx";

//天安管家
static NSString *const kTKApiConstantHKList = @"json/getBaoXiu.aspx";
static NSString *const kTKApiConstantUploadImg = @"json/addImg.aspx";
static NSString *const kTKApiConstantSubmitBaoXiu = @"json/addBx.aspx";
static NSString *const kTKApiConstantAddEvaluate = @"json/addPj.aspx";
static NSString *const kTKApiConstantDeleteBaoxiu = @"json/delBaoXiu.aspx";
static NSString *const kTKApiConstantBaoxiuDetail = @"json/baoXiuDetails.aspx";

//登录 找回密码
static NSString *const kTKApiConstantLogin = @"json/login.aspx";
static NSString *const kTKApiConstantResetPwd = @"json/editPwd.aspx";
static NSString *const kTKApiConstantServicePage = @"json/content.aspx?id=1";
static NSString *const kTKApiConstantGetPhoneMsgCode = @"json/phoneYzm.aspx";

//我的-我的家人
static NSString *const kTKApiConstantPersonalMyFamily = @"json/myJia.aspx";
static NSString *const kTKApiConstantRelationType = @"json/getGx.aspx";
static NSString *const kTKApiConstantFamilyGetCode = @"json/jiaYzm.aspx";
static NSString *const kTKApiConstantFamilyAddNew = @"json/addJia.aspx";
//我的-费用记录
static NSString *const kTKApiConstantFeeWY = @"json/getWuYeFeiJiLu.aspx";
static NSString *const kTKApiConstantFeeWater = @"json/getShuiFeiJiLu.aspx";
//我的-消息
static NSString *const kTKApiConstantNotiNumber = @"json/getNum.aspx";
static NSString *const kTKApiConstantNotiBill = @"json/getMess.aspx";
static NSString *const kTKApiConstantNotiSystem = @"json/getNum.aspx";
static NSString *const kTKApiConstantNotiStatusChanged = @"json/editMess.aspx";

//response
static NSString *const kTKResponseResultCode = @"result";
static NSString *const kTKResponseResultMsg = @"msg";
static NSString *const kTKResponseResultData = @"data";

//notification
static NSString *const kNotificationLoginSuccess = @"kNotificationLoginSuccess";
static NSString *const kNotificationLogout = @"kNotificationLogout";

//other
static NSString *const kFilePathBaoXiuImagePath = @"BaoXiu";
#endif /* TKApiConstant_h */
