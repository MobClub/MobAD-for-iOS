//
//  MobAD.h
//  MobAD
//
//  Created by Max on 2019/7/30.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MADTypeDefines.h"
#import "MOBADNativeAdData.h"
#import "MOBADNativeExpressAdView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 广告 SDK 入口,提供各种接口
 */
@interface MobAD : NSObject

/**
 获取SDK版本号

 @return SDK版本号
 */
+ (NSString *)version;

/**
 展示开屏广告

 @param pid 广告位id
 @param view 开屏广告的载体视图，建议传Window
 @param frame 开屏广告frame,bottomView参数不为空时生效!需要在开屏广告底部展示App图标、名称等内容时可将广告的高度调小一些,让屏幕底部留出空间,但是建议保证广告视图frame的高度 + bottomView的高度 = 承载view的高度,以便撑满一屏.
 @param viewController 用于跳转的控制器
 @param skipView 自定义 `跳过` 按钮, 建议结合 `lifeTimeCallback` 设置内容.(传 nil 时使用默认的跳过按钮)
 @param bottomView 自定义底部视图,请注意⚠️：如果设置了该参数,MobAD将获取的广告以半屏形式展示在传入的Window上半部分,剩余的部分展示传入的bottomView.必须需设置好宽高,所占的空间不能过大,建议宽度与广告frame宽度一致,并保证高度不超过屏幕高度的25%.(传 nil 时默认广告视图充满)
 @param tolerateTimeout 广告加载超时时间设置, 默认3秒
 @param lifeTimeCallback 广告展示剩余时间回调, 单位秒
 @param stateChanged 广告状态回调
 */
+ (void)showSplashAdWithPlacementId:(NSString *)pid
                             onView:(UIView *)view
                            adFrame:(CGRect)frame
                     viewController:(UIViewController *)viewController
                     customSkipView:(UIView *_Nullable)skipView
                   customBottomView:(UIView *_Nullable)bottomView
                    tolerateTimeout:(NSTimeInterval)tolerateTimeout
                 adLifeTimeCallback:(MADSplashAdLifeTimeCallback)lifeTimeCallback
                       stateChanged:(MADStateCallback)stateChanged;



/**
 展示开屏广告
 
 @param pid 广告位id
 @param view 开屏广告的载体视图，建议传window
 @param viewController 用于跳转的控制器
 @param hideSkipButton 是否隐藏跳过按钮
 @param stateChanged 广告状态回调
 */
+ (void)showSplashAdWithPlacementId:(NSString *)pid
                             onView:(UIView *)view
                     viewController:(UIViewController *)viewController
                     hideSkipButton:(BOOL)hideSkipButton
                       stateChanged:(MADStateCallback)stateChanged __deprecated_msg("Deprecated from v2.0.2 Use 'showSplashAdWithPlacementId:onView:adFrame:viewController:customSkipView:adLifeTimeCallback:stateChanged:' instead!");


/**
 展示横幅广告
 
 @param pid 广告位id
 @param onView 广告视图的载体View
 @param viewController 用于跳转的控制器
 @param frame 广告视图frame
 @param interval 广告刷新间隔,范围 [30, 120] 秒, 不想要刷新则该字段传 0 即可
 @param stateChanged 广告状态回调
 @param dislikeCallback 用户选择关闭理由回调
 */
+ (void)showBannerAdWithPlacementId:(NSString *)pid
                             onView:(UIView *)onView
                     viewController:(UIViewController *)viewController
                              frame:(CGRect)frame
                           interval:(NSInteger)interval
                       stateChanged:(MADStateCallback)stateChanged
                    dislikeCallback:(MADDislikeCallback)dislikeCallback;

    /**
 关闭横幅广告

 @param adObject 横幅广告对象
 */
+ (void)dismissBannerAd:(id)adObject;

/**
 展示插屏广告
 
 @param pid 广告位id
 @param onView 广告视图的载体View
 @param viewController 用于跳转的控制器
 @param frame 广告视图frame
 @param eCPMCallback 用于获取广告eCPM,不回调或回调-1则表示无eCPM
 @param stateChanged 广告状态回调
 */
+ (void)showInterstitialAdWithPlacementId:(NSString *)pid
                                   onView:(UIView *)onView
                           viewController:(UIViewController *)viewController
                                    frame:(CGRect)frame
                             eCPMCallback:(MADeCPMCallback)eCPMCallback
                             stateChanged:(MADStateCallback)stateChanged;


/**
 原生模版信息流广告
 
 @param pid 广告配置项
 @param size 广告大小
 @param edgeInsets 广告内容边距, 大图样式默认(0,0,0,0), 其他样式默认 (10,10,10,10), 仅 >= 0 时生效
 @param adViewsCallback 广告模版视图回调
 @param eCPMCallback 用于获取广告eCPM,不回调或回调-1则表示无eCPM
 @param stateCallback 广告状态回调
 @param dislikeCallback 广告不喜欢原因回调
 */
+ (void)nativeExpressAdWithPlacementId:(NSString *)pid
                                adSize:(CGSize)size
                            edgeInsets:(UIEdgeInsets)edgeInsets
                       adViewsCallback:(MADNativeExpressAdViewCallback)adViewsCallback
                          eCPMCallback:(MADeCPMCallback)eCPMCallback
                         stateCallback:(MADStateCallback)stateCallback
                       dislikeCallback:(MADDislikeCallback)dislikeCallback;



/**
 原生自渲染信息流广告
 
 @param pid 广告配置项
 @param viewController 用于跳转的控制器
 @param adsCallback 广告数据回调
 @param eCPMCallback 用于获取广告eCPM,不回调或回调-1则表示无eCPM
 @param stateCallback 广告状态回调
 @param dislikeCallback 广告不喜欢原因回调
 */
+ (void)nativeAdWithPlacementId:(NSString *)pid
                 viewController:(UIViewController *)viewController
                    adsCallback:(MADNativeAdCallback)adsCallback
                   eCPMCallback:(MADeCPMCallback)eCPMCallback
                  stateCallback:(MADStateCallback)stateCallback
                dislikeCallback:(MADDislikeCallback)dislikeCallback;


/**
 展示全屏视频广告
 
 @param pid 广告位id
 @param viewController 用于跳转的控制器
 @param sceneDescirbe 可选,场景描述信息
 @param stateChanged 广告状态回调
 */
+ (void)showFullScreenVideoAdWithPlacementId:(NSString *)pid
                              viewController:(UIViewController *)viewController
                            ritSceneDescribe:(NSString *_Nullable)sceneDescirbe
                                stateChanged:(MADStateCallback)stateChanged;

/**
 展示激励视频广告
 
 @param pid 广告位id
 @param viewController 用于 present 激励视频的 VC
 @param eCPMCallback 用于获取广告eCPM,不回调或回调-1则表示无eCPM
 @param stateCallback 激励视频广告状态回调
 */
+ (void)showRewardVideoAdWithPlacementId:(NSString *)pid
                          viewController:(UIViewController *)viewController
                            eCPMCallback:(MADeCPMCallback)eCPMCallback
                           stateCallback:(MADStateCallback)stateCallback;


/**
 获取Draw视频流

 @param pid 广告位id
 @param count 广告个数
 @param viewController 用于 present 视频的 VC
 @param callback Draw视频流广告回调
 @param stateCallback 广告状态回调
 @param dislikeCallback 广告不喜欢原因回调
 */
+ (void)drawVideoFeedAdWithPlacementId:(NSString *)pid
                               adCount:(NSInteger)count
                        viewController:(UIViewController *)viewController
                            adCallback:(MADNativeAdCallback)callback
                         stateCallback:(MADStateCallback)stateCallback
                       dislikeCallback:(MADDislikeCallback)dislikeCallback;

#pragma mark - 广告日志

/**
 发送广告状态日志(主要用于自渲染等类型广告)

 @param state 广告状态
 @param data 广告数据
 @param error 错误信息,可以传nil
 */
+ (void)sendAdLogWithState:(MADState)state adObject:(MOBADNativeAdData *)data error:(NSError *_Nullable)error;

@end

NS_ASSUME_NONNULL_END
