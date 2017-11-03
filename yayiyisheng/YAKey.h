//
//  YAKey.h
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SCREEN_width [UIScreen mainScreen].bounds.size.width
#define SCREEN_height [UIScreen mainScreen].bounds.size.height

// rgb颜色
#define YAYIColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define YAYIColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]

// 线条颜色
#define YAYILineColor  YAYIColor(239,240,240)
#define YAYICellTitleColor  YAYIColor(0x25, 0x25, 0x25)
#define YAYICellLineColor  YAYIColor(239,240,240)
#define YAYIBackgroundColor YAYIColor(250,250,250)
#pragma mark    ================ 常量key ===============


/** 登录 */
static  NSString  * const YAYILoginCookieKey  = @"loginCookie";
static  NSString  * const YAYIManagerKey = @"managerKey" ;
static  NSString  * const YAYIManagerMobile =  @"mobileKey";
/**
 *  保存位置信息的key，保存为字典类型
 locDcit:{
	locality : 杭州市,
	administrativeArea : 浙江省,
	latitude : 30.26724521944026,
	longitude : 120.1020869588854,
	areacode : 330100
 }
 */
static  NSString  * const YAYILocationKey = @"locationKey";
static  NSString  * const YAYIUsernameKey = @"username" ;
static  NSString  * const YAYIPasswordKey = @"password" ;
static  NSString  * const YAYIUserIDKey  = @"userID" ;
static  NSString  * const YAYIDoctorNameKey  = @"doctornamekey" ;
static  NSString  * const YAYIDoctorAvatarKey  = @"doctoravatarkey" ;
static  NSString  * const YAYIHeadKey = @"head" ;
static  NSString  * const YAYIShockID  = @"YAYIShockID" ;
static  NSString  * const YAYIVoiceID  = @"YAYIVoiceID" ;
static  NSString  * const YAYIVerifyState = @"YAYIVerifyState" ; // NSInteger 认证标志(0、未提交，1、待处理，2、已认证，3、认证失败)
static  NSString  * const YAYIMutiPracticeNewUserGuidShowed = @"mutiPracticeNewUserGuid" ; // BOOL 进入点点医生是否显示过新手引导
static  NSString  * const YAYIMeetingNewUserGuidShowed  = @"meetingNewUserGuidShowed" ; // BOOL 进入会议详情是否显示过新手引导
static  NSString  * const YAYINetStateChanged  = @"netStateChanged" ;

@interface YAKey : NSObject

@end
