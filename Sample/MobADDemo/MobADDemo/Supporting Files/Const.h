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

// 线上广告位id  new:2d7ce93a26944  ori:moba6b6c6d6
static NSString *kSSplashPID =  @"1194165940084097025";//@"1209324613127892994";//@"1211924620918059010";//测试  @"1194165940084097025";//正式 //@"1005291";// @"1185090101854515202"; // 1005291 @"1194165940084097025"
static NSString *kSBannerPID = @"1194166061135904770";//@"1005289"; // 1185090065267601409 // 1005289  @"1194166061135904770"
static NSString *kSInterstitialPID = @"1193850332511576066"; // @"1208234187570475010" ;//@"1193850332511576066";//@"1005285"; // 1185090015397326850 // 1005285  1193850332511576066
static NSString *kSNativeExpressPID = @"1194166321325359105"; //@"1194166321325359105"; // @"1005281"; // 1185089948514955265 // 1005281 // 原生模版(美数单图)
//static NSString *kSNativeExpressPID = @"1005356"; // 原生模版(美数三图)
//static NSString *kSNativeExpressPID = @"1005288"; // 原生模版(美数视频)
static NSString *kSNativePID = @"1194166367437537282"; //@"1005282"; // 1185089948514955265 // 1005282  1194166367437537282 // 原生自渲染
static NSString *kSFullScreenVideoPID = @"1194166204300083201"; // @"1005382";
static NSString *kSRewardVideoPID = @"1202807702073372674"; //@"1209794660175683586";//@"1194166257326149634"; //@"1005380";  1194166257326149634
static NSString *kSDrawVideoFeedPID = @"1194166159697854465"; // @"1005381";

#else

// 测试广告位id
static NSString *kSSplashPID = @"1194192593036992513"; //@"1004462";
static NSString *kSBannerPID = @"1194191107204800513"; //@"1004463";
static NSString *kSInterstitialPID = @"1194192565706907650"; //@"1004464";
static NSString *kSNativeExpressPID = @"1194192793843490818"; //@"1004465"; // 原生模版
static NSString *kSNativePID = @"1233279383639097346"; //@"100424036"; // 原生自渲染
static NSString *kSFullScreenVideoPID = @"1194192692676878337"; //@"9";
static NSString *kSRewardVideoPID = @"1194192740223508481"; //@"8";
static NSString *kSDrawVideoFeedPID = @"1194192651434287105"; //@"10";

#endif

#endif /* Const_h */
