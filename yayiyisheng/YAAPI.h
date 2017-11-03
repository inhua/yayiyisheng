//
//  YAAPI.h
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#ifndef YAAPI_h
#define YAAPI_h

/** 这里切换正式和测试环境，0:测试环境 1:正式环境 2:bufix环境 */
#define RunEnvironment 0

#if RunEnvironment

#define API @"https://appdt.yayi365.cn"   // 正式环境
#define WXShareAPI @"https://wx.yayi365.cn/reservation/reservation_resdet.html" // 微信分享正式环境
#define PushCertName @"production"   // 百川IM推送证书名，正式是：doctornew_apnsdev    测试是：sand

#else

//#define API @"https://app1.yayi365.cn/ya_bugfix/"   // bugfix环境
//#define WXShareAPI @"https://wx1.yayi365.cn/bugfix/reservation/reservation_resdet.html" // 微信分享bugfix环境
#define API @"https://appdt1.yayi365.cn"   // 测试环境
#define WXShareAPI @"https://wx1.yayi365.cn/reservation/reservation_resdet.html" // 微信分享测试环境

#define PushCertName @"sand"   // 百川IM推送证书名，正式是：production    测试是：sand

#endif

#pragma mark   ==============登录=====================



#pragma mark ============== 首页 =====================



#pragma mark ============== 消息 =====================



#pragma mark ============== 我 =====================


#endif 
