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
static NSString *kSSplashPID = @"1242325128971223042"; //@"1004462";
static NSString *kSBannerPID = @"1242292865407590402"; //@"1004463";
static NSString *kSInterstitialPID = @"1242271928054390786"; //@"1004464";
static NSString *kSNativeExpressPID = @"1242371519500181505"; // 原生模版  1242371519500181505
static NSString *kSNativePID = @"1242337705163939841"; //@"100424036"; // 原生自渲染
static NSString *kSFullScreenVideoPID = @"1194192692676878337"; //@"9";
static NSString *kSRewardVideoPID = @"1242270822066757633"; //@"8";1227841137979355137
static NSString *kSDrawVideoFeedPID = @"1194192651434287105"; //@"10";

#endif

#endif /* Const_h */
