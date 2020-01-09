//
//  MADTypeDefines.h
//  MobAD
//
//  Created by Max on 2019/7/31.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#ifndef MADTypeDefines_h
#define MADTypeDefines_h

@class MADNativeExpressAdView, MADNativeAdData;

#pragma mark - 统一接口定义

// 广告平台
typedef NS_ENUM(NSInteger, MADPlat) {
    MADPlatUnknown  = 0, // 未知
    MADPlatMS       = 1,
    // 2,3预留
    MADPlatGDT      = 4,
    MADPlatBUD      = 5,
    MADPlatKS       = 6,
};


/**
 MAD广告状态变化回调
 */
typedef NS_ENUM(NSInteger, MADState) {
    MADStateUnknown                                    = -1,
    MADStateDidLoad                                    = 0,
    MADStateFailLoad                                   = 1,
    MADStateViewRenderSuccess                          = 2,
    MADStateViewRenderFail                             = 3,
    MADStateWillVisible                                = 4,
    MADStateDidVisible                                 = 5,
    MADStateDidClick                                   = 6,
    MADStateWillClose                                  = 7,
    MADStateDidClose                                   = 8,
    MADStateWillPresentScreen                          = 9,
    
    MADStateDidPresentScreen                           = 10,
    MADStateFailPresentScreen                          = 11,
    MADStateWillExposure                               = 12,
    MADStateDidExposure                                = 13,
    
    MADStateVideoDidLoad                               = 14,
    MADStateDidStartPlay                               = 15,
    MADStateDidPlayFinish                              = 16,
    
    MADStateWillDismissScreen                          = 20,
    MADStateDidDismissScreen                           = 21,
    MADStateWillLeaveApplication                       = 22,
    MADStateWillPresentFullScreenModal                 = 23,
    MADStateDidPresentFullScreenModal                  = 24,
    MADStateWillDismissFullScreenModal                 = 25,
    MADStateDidDismissFullScreenModal                  = 26,
    MADStateDidRewardEffective                         = 27,
    MADStateWillPresentVideoVC                         = 28,
    MADStateDidPresentVideoVC                          = 29,
    MADStateWillDismissVideoVC                         = 30,
    MADStateDidDismissVideoVC                          = 31,
    
    MADStateDidCloseOtherController                    = 40,
    MADStateMaterialMetaDidLoad                        = 41,
    MADStateDidClickSkip                               = 42,
    MADStateServerRewardDidSucceed                     = 43,
    MADStateServerRewardDidFail                        = 44,
};


/**
 广告状态回调

 @param adObject 广告视图View或广告原始数据Model(可能为空)
 @param state 广告状态
 @param error 错误信息
 */
typedef void(^MADStateCallback)(id adObject, MADState state, NSError *error);

/**
 关闭广告选项回调

 @param adObject 被关闭的广告对象
 @param reasons 不喜欢原因
 */
typedef void(^MADDislikeCallback)(id adObject, NSArray<NSString *> *reasons);

/**
 开屏广告剩余时间回调, 单位秒
 */
typedef void(^MADSplashAdLifeTimeCallback)(NSInteger lifeTime);

/**
 广告eCPM回调, -1则表示广告没有eCPM回调
 */
typedef void(^MADeCPMCallback)(NSInteger eCPM);

/**
 原生模版广告回调
 */
typedef void(^MADNativeExpressAdViewCallback)(NSArray<MADNativeExpressAdView *> *nativeExpressAdViews, NSError *error);

/**
 原生广告回调
 */
typedef void(^MADNativeAdCallback)(NSArray<MADNativeAdData *> *nativeAdDatas, NSError *error);

#endif /* MADTypeDefines_h */
