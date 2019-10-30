//
//  Const.h
//  MobADDemo
//
//  Created by Max on 2019/8/13.
//  Copyright © 2019 Max. All rights reserved.
//

#ifndef Const_h
#define Const_h

#define AppRelease    // 注释此行则为测试环境

#ifdef AppRelease

// 线上广告位id
static NSString *kSSplashPID = @"1005291";// @"1185090101854515202"; // 1005291
static NSString *kSBannerPID = @"1005289"; // 1185090065267601409 // 1005289
static NSString *kSInterstitialPID = @"1005285"; // 1185090015397326850 // 1005285
static NSString *kSNativeExpressPID = @"1005281"; // 1185089948514955265 // 1005281 // 原生模版(美数单图)
//static NSString *kSNativeExpressPID = @"1005356"; // 原生模版(美数三图)
//static NSString *kSNativeExpressPID = @"1005288"; // 原生模版(美数视频)
static NSString *kSNativePID = @"1005282"; // 1185089948514955265 // 1005282 // 原生自渲染
static NSString *kSFullScreenVideoPID = @"1005382";
static NSString *kSRewardVideoPID = @"1005380";
static NSString *kSDrawVideoFeedPID = @"1005381";

#else

// 测试广告位id
static NSString *kSSplashPID = @"1004462";
static NSString *kSBannerPID = @"1004463";
static NSString *kSInterstitialPID = @"1004464";
static NSString *kSNativeExpressPID = @"1004465"; // 原生模版
static NSString *kSNativePID = @"100424036"; // 原生自渲染
static NSString *kSFullScreenVideoPID = @"9";
static NSString *kSRewardVideoPID = @"8";
static NSString *kSDrawVideoFeedPID = @"10";

#endif

#endif /* Const_h */
