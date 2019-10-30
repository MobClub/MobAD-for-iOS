//
//  MADTypeDefines.h
//  MobAD
//
//  Created by Max on 2019/7/31.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#ifndef MADTypeDefines_h
#define MADTypeDefines_h

@class MGADHybridAd, MADNativeExpressAdView, MADNativeAdData, MADDislikeReason;

#pragma mark - 统一接口定义

// 广告平台
typedef NS_ENUM(NSInteger, MADPlat) {
    MADPlatUnknown  = 0, // 未知平台
    MADPlatMS       = 1, // 美数
    // 2,3预留
    MADPlatGDT      = 4, // 广点通
    MADPlatBUD      = 5, // 穿山甲
};


/**
 MAD广告状态变化回调
 
 - MADStateUnknown: 未知状态
 - MADStateDidReceived: 请求广告条数据成功
 - MADStateFailReceived: 请求广告条数据失败
 - MADStateDidSuccessPresent: 开屏广告成功展示
 - MADStateDidFailPresent: 开屏广告展示失败
 - MADStateAppWillEnterBackground: 当点击应用下载或者广告调用系统程序打开时
 - MADStateWillExposured: 广告曝光回调
 - MADStateDidClick: 广告点击回调
 - MADStateWillClosed: 广告有关闭按钮被用户关闭时调用
 - MADStateDidClosed: 广告已经被关闭
 - MADStateWillPresent: 插屏2.0广告将要展示回调
 - MADStateDidPresent: 插屏2.0广告视图展示成功回调
 - MADStateWillDismiss: 全屏广告页将要展示结束
 - MADStateDidDismiss: 全屏广告页展示结束回调
 - MADStateWillPresentFullScreenModal: 广告点击以后即将弹出全屏广告页
 - MADStateDidPresentFullScreenModal: 广告点击以后弹出全屏广告页
 - MADStateWillDismissFullScreenModal: 全屏广告页即将被关闭
 - MADStateDidDismissFullScreenModal: 全屏广告页已经被关闭
 - MADStateAdViewRenderSuccess: 原生模板广告渲染成功
 - MADStateAdViewRenderFail: 原生模板广告渲染失败
 - MADStateDidRewardEffective: 激励视频广告,达到激励条件
 */
typedef NS_ENUM(NSInteger, MADState) {
    MADStateUnknown                                 = -1,
    MADStateDidReceived                             = 0,
    MADStateFailReceived                            = 1,
    MADStateDidClick                                = 2,
    MADStateWillClosed                              = 3,
    MADStateDidClosed                               = 4,
    MADStateWillPresent                             = 5,
    MADStateDidPresent                              = 6,
    MADStateAdViewRenderSuccess                     = 7,
    MADStateAdViewRenderFail                        = 8,
    
    MADStateDidSuccessPresent                       = 9,
    MADStateDidFailPresent                          = 10,
    MADStateAppWillEnterBackground                  = 11,
    MADStateWillExposured                           = 12,
    MADStateWillDismiss                             = 13,
    MADStateDidDismiss                              = 14,
    MADStateWillPresentFullScreenModal              = 15,
    MADStateDidPresentFullScreenModal               = 16,
    MADStateWillDismissFullScreenModal              = 17,
    MADStateDidDismissFullScreenModal               = 18,
    MADStateDidRewardEffective                      = 19,
    
    MADStateDidCloseOtherController                 = 30,
    MADStateVideoDataDidLoad                        = 31,
    MADStateVideoDidPlayFinish                      = 32,
    MADStateDidClickSkip                            = 33,
    MADStateServerRewardDidSucceed                  = 34,
    MADStateServerRewardDidFail                     = 35,
    MADStateFinishViewDidClick                      = 36,
    MADStateWillPresentScreen                       = 37,
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
typedef void(^MADDislikeCallback)(id adObject, NSArray<MADDislikeReason *> *reasons);

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





#pragma mark - 分平台接口定义 (注意⚠️: 以下定义 v2.0.0 及以上版本请忽略)

/**
 MGAD广告状态变化回调
 
 - MGADStateUnknown: 未知状态
 - MGADStateDidReceived: 请求广告条数据成功
 - MGADStateFailReceived: 请求广告条数据失败
 - MGADStateDidSuccessPresent: 开屏广告成功展示
 - MGADStateDidFailPresent: 开屏广告展示失败
 - MGADStateAppWillEnterBackground: 当点击应用下载或者广告调用系统程序打开时
 - MGADStateWillExposured: 广告曝光回调
 - MGADStateDidClick: 广告点击回调
 - MGADStateWillClosed: 广告有关闭按钮被用户关闭时调用
 - MGADStateDidClosed: 广告已经被关闭
 - MGADStateWillPresent: 插屏2.0广告将要展示回调
 - MGADStateDidPresent: 插屏2.0广告视图展示成功回调
 - MGADStateWillDismiss: 全屏广告页将要展示结束
 - MGADStateDidDismiss: 全屏广告页展示结束回调
 - MGADStateWillPresentFullScreenModal: 广告点击以后即将弹出全屏广告页
 - MGADStateDidPresentFullScreenModal: 广告点击以后弹出全屏广告页
 - MGADStateWillDismissFullScreenModal: 全屏广告页即将被关闭
 - MGADStateDidDismissFullScreenModal: 全屏广告页已经被关闭
 - MGADStateAdViewRenderSuccess: 原生模板广告渲染成功
 - MGADStateAdViewRenderFail: 原生模板广告渲染失败
 - MGADStateDidRewardEffective: 激励视频广告,达到激励条件
 */
typedef NS_ENUM(NSInteger, MGADState) {
    MGADStateUnknown                            = -1,
    MGADStateDidReceived                        = 0,
    MGADStateFailReceived                       = 1,
    MGADStateDidClick                           = 2,
    MGADStateWillClosed                         = 3,
    MGADStateDidClosed                          = 4,
    MGADStateWillPresent                        = 5,
    MGADStateDidPresent                         = 6,
    MGADStateAdViewRenderSuccess                = 7,
    MGADStateAdViewRenderFail                   = 8,
    
    MGADStateDidSuccessPresent                  = 9,
    MGADStateDidFailPresent                     = 10,
    MGADStateAppWillEnterBackground             = 11,
    MGADStateWillExposured                      = 12,
    MGADStateWillDismiss                        = 13,
    MGADStateDidDismiss                         = 14,
    MGADStateWillPresentFullScreenModal         = 15,
    MGADStateDidPresentFullScreenModal          = 16,
    MGADStateWillDismissFullScreenModal         = 17,
    MGADStateDidDismissFullScreenModal          = 18,
    MGADStateDidRewardEffective                 = 19,
};

typedef NS_ENUM(NSInteger, MGADMediaAdState) {
    MGADMediaAdStateWillPresentVideoVC=0,//原生视频模板详情页将要弹出
    MGADMediaAdStateDidPresentVideoVC,//原生视频模板详情页弹出后
    MGADMediaAdStateInitial,         // 初始状态
    MGADMediaAdStateLoading,         // 加载中
    MGADMediaAdStateLoaded,          // 加载完成
    MGADMediaAdStateStarted,         // 开始播放
    MGADMediaAdStatePaused,          // 用户行为导致暂停
    MGADMediaAdStateStoped,          // 播放停止
    MGADMediaAdStateCompleted,       // 播放完成
    MGADMediaAdStateError,           // 播放出错
    MGADMediaAdStateWillDismissVideoVC, //原生视频模板详情页将要关闭
    MGADMediaAdStateDidDismissVideoVC //原生视频模板详情页已经关闭
};


/**
 激励视频广告状态

 - MGADRewardVideoAdStateDidLoad: 广告数据加载成功
 - MGADRewardVideoAdStateVideoDidLoad: 视频文件加载成功
 - MGADRewardVideoAdStateWillVisible: 视频播放页即将打开
 - MGADRewardVideoAdStateDidExposed: 广告已曝光
 - MGADRewardVideoAdStateDidClose: 广告已关闭
 - MGADRewardVideoAdStateDidClicked: 广告已点击
 - MGADRewardVideoAdStateDidFail: 各种广告失败
 - MGADRewardVideoAdStateDidRewardEffective: 播放达到激励条件
 - MGADRewardVideoAdStateDidPlayFinish: 视频播放结束
 */
typedef NS_ENUM(NSInteger, MGADRewardVideoAdState) {
    MGADRewardVideoAdStateDidLoad               = 0,
    MGADRewardVideoAdStateVideoDidLoad          = 31,
    MGADRewardVideoAdStateWillVisible           = 5,
    MGADRewardVideoAdStateDidExposed            = 12,
    MGADRewardVideoAdStateDidClose              = 4,
    MGADRewardVideoAdStateDidClicked            = 2,
    MGADRewardVideoAdStateDidFail               = 1,
    MGADRewardVideoAdStateDidRewardEffective    = 19,
    MGADRewardVideoAdStateDidPlayFinish         = 32,
};


/**
 H5 广告选项

 - MGADHybridAdOptionRewardVideo: 激励视频
 */
typedef NS_ENUM(NSInteger, MGADHybridAdOptions) {
    MGADHybridAdOptionRewardVideo = 1 << 0,
};


/**
 内存警告
 */
typedef void(^MGADMemoryWarning)(void);

/**
 广告状态回调
 */
typedef void(^MGADStateCallback)(id adObject, MGADState state,NSError *error);

/**
 视频广告状态回调
 */
typedef void(^MGADMediaAdStateCallback)(MGADMediaAdState state);

/**
 广告生命周期
 */
typedef void(^MGADLifeTimeCallback)(NSInteger time);

/**
 广告视图回调
 */
typedef void(^MGADViewCallback)(UIView *view);


/**
 广告eCPM回调
 */
typedef void(^MGADeCPMCallback)(NSInteger eCPM);

/**
 原生模板广告回调
 */
typedef void(^MGADNativeAdCallback)(NSArray *nativeAds, NSError *error);

/**
 自渲染 2.0 广告回调
 */
typedef void(^MGADUnifiedNativeAdCallback)(NSArray *unifiedNativeAds, NSError *error);

/**
 激励视频广告回调
 */
typedef void(^MGADRewardVideoAdStateCallback)(id adObject, MGADRewardVideoAdState state, NSError *error);

/**
 H5广告回调
 */
typedef void(^MGADHybridAdCallback)(MGADHybridAd *hybridAd, NSError *error);

/**
 MBAD广告状态变化

 - MBADStateDidLoad: 广告元数据加载成功
 - MBADStateDidLoadFailed: 广告元数据加载失败
 - MBADStateWillVisible: 广告即将展示
 - MBADStateDidVisible: 广告即将展示
 - MBADStateDidClick: 广告被点击
 - MBADStateWillClose: 广告即将关闭
 - MBADStateDidClose: 广告已经被关闭
 - MBADStateDidCloseOtherController: 将要关闭另一个控制器
 - MBADStateVideoDataDidLoad: 视频广告-视频缓存成功
 - MBADStateVideoDidPlayFinish: 视频广告-视频播放完成
 - MBADStateDidClickSkip: 视频广告-点击跳过按钮
 - MBADStateServerRewardDidSucceed: 激励视频广告-奖励成功
 - MBADStateServerRewardDidFail: 激励视频广告-奖励失败
 - MBADStateFinishViewDidClick: Draw视频广告-视频播放完成Card点击
 - MBADStateViewRenderSuccess: 个性模版Banner广告-广告渲染成功
 - MBADStateViewRenderFail: 个性模版Banner广告-广告渲染失败
 - MBADStateWillPresentScreen: 个性模版广告-点击后将要展示内容
 */
typedef NS_ENUM(NSInteger, MBADState) {
    MBADStateDidLoad                    = 0,
    MBADStateDidLoadFailed              = 1,
    MBADStateDidClick                   = 2,
    MBADStateWillClose                  = 3,
    MBADStateDidClose                   = 4,
    MBADStateWillVisible                = 5,
    MBADStateDidVisible                 = 6,
    MBADStateViewRenderSuccess          = 7,
    MBADStateViewRenderFail             = 8,
    
    MBADStateDidCloseOtherController    = 30,
    MBADStateVideoDataDidLoad           = 31,
    MBADStateVideoDidPlayFinish         = 32,
    MBADStateDidClickSkip               = 33,
    MBADStateServerRewardDidSucceed     = 34,
    MBADStateServerRewardDidFail        = 35,
    MBADStateFinishViewDidClick         = 36,
    MBADStateWillPresentScreen          = 37,
};

//广告交互类型
typedef NS_ENUM(NSInteger, MBADInteractionType) {
    MBADInteractionTypeCustorm = 0,
    MBADInteractionTypeNO_INTERACTION = 1,  // pure ad display
    MBADInteractionTypeURL = 2,             // open the webpage using a browser
    MBADInteractionTypePage = 3,            // open the webpage within the app
    MBADInteractionTypeDownload = 4,        // download the app
    MBADInteractionTypePhone = 5,           // make a call
    MBADInteractionTypeMessage = 6,         // send messages
    MBADInteractionTypeEmail = 7,           // send email
    MBADInteractionTypeVideoAdDetail = 8    // video ad details page
};

// 原生Draw视频流播放器播放状态
typedef NS_ENUM(NSInteger, MBADPlayerPlayState) {
    MBADPlayerStateUnknown   = -1,
    MBADPlayerStateFailed    = 0,
    MBADPlayerStateBuffering = 1,
    MBADPlayerStatePlaying   = 2,
    MBADPlayerStateStopped   = 3,
    MBADPlayerStatePause     = 4,
    MBADPlayerStateDefalt    = 5
};



/**
 关闭广告选项回调
 */
typedef void(^MBADDislikeCallback)(id adObject, NSArray *reasons);

/**
 广告状态回调
 */
typedef void(^MBADStateCallback)(id adObject, MBADState state, NSError *error);

/**
 Draw视频广告状态回调
 */
typedef void(^MBADDrawVideoStateCallback)(MBADState state, MBADInteractionType interactionType,NSError *error, MBADPlayerPlayState playerState);

/**
 原生广告回调
 */
typedef void(^MBADNativeAdCallback)(NSArray *nativeAds, NSError *error);

/**
 个性化原生广告回调
 */
typedef void(^MBADNativeAExpressAdCallback)(NSArray *nativeExpressAdViews, NSError *error);

#endif /* MADTypeDefines_h */
