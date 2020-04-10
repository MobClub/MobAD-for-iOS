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
static NSString *kSSplashPID =  @"1194165940084097025";
static NSString *kSBannerPID = @"1194166061135904770";
static NSString *kSInterstitialPID = @"1193850332511576066";
static NSString *kSNativeExpressPID = @"1194166321325359105";

static NSString *kSNativePID = @"1225786627827527681";
static NSString *kSFullScreenVideoPID = @"1194166204300083201";
static NSString *kSRewardVideoPID = @"1202807702073372674";
static NSString *kSDrawVideoFeedPID = @"1194166159697854465";

#else   

// 测试广告位id
static NSString *kSSplashPID = @"1242703062404837378"; //@"1233300399330377730" ;
static NSString *kSBannerPID = @"1242702398656229378";//@"";
static NSString *kSInterstitialPID = @"1240213745090629634";//@"";
static NSString *kSNativeExpressPID = @"1242704944313544705";//@""; // 原生模版
static NSString *kSNativePID = @"1242705102958899201";//@"";  // 原生自渲染
static NSString *kSFullScreenVideoPID = @"1194192692676878337";
static NSString *kSRewardVideoPID = @"1242704312670707714"; //@"";
static NSString *kSDrawVideoFeedPID = @"1194192651434287105";

#endif

#endif /* Const_h */
