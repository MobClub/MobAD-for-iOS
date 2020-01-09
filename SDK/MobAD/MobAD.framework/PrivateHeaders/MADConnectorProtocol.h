//
//  MADConnectorProtocol.h
//  MobAD
//
//  Created by Sands_Lee on 2019/10/31.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MOBFoundation/IMOBFServiceComponent.h>


@protocol MADConnectorProtocol <IMOBFComponent>

/**
 Connector 桥接的SDK版本号
 */
+ (NSString *)connectorVersion;

/**
 判断是不是该平台的connector
 */
+ (BOOL)isConnectorForPlatType:(NSInteger)platType;

/**
 注册AppID
 */
+ (void)registerAppId:(NSString *)appid;

@optional

// 获取广告的eCPM值（仅GDT使用,插屏2.0,原生模版,激励视频）
+ (NSInteger)geteCPMWithAdObject:(id)adObject;

// 开屏广告
+ (void)showSplashAdWithPlacementId:(NSString *)pid
                             onView:(UIView *)onView
                              frame:(CGRect)frame
                     viewController:(UIViewController *)vc
                           skipView:(UIView *)skipView
                         bottomView:(UIView *)bottomView
                    tolerateTimeout:(NSTimeInterval)tolerateTimeout
                   lifeTimeCallback:(void (^)(NSInteger lifeTime))lifeTimeCallback
                       stateChanged:(void (^)(id adObj, NSInteger state, NSError *error))stateCallback;

// 横幅广告
+ (void)showBannerAdWithPlacementId:(NSString *)pid
                             onView:(UIView *)onView
                     viewController:(UIViewController *)vc
                              frame:(CGRect)frame
                           interval:(NSInteger)interval
                       stateChanged:(void (^)(id adObj, NSInteger state, NSError *error))stateCallback
                    dislikeCallback:(void (^)(id adObj, NSArray<NSString *> *reasons))dislikeCallback;
// 关闭横幅广告
+ (void)dismissBannerAd:(id)adObject;


// 插屏广告
+ (void)showInterstitialAdWithPlacementId:(NSString *)pid
                           viewController:(UIViewController *)vc
                                   adSize:(CGSize)size
                             eCPMCallback:(void (^)(NSInteger eCPM))eCPMCallback
                             stateChanged:(void (^)(id adObj, NSInteger state, NSError *error))stateCallback;


// 原生模版广告
+ (void)nativeExpressAdWithPlacementId:(NSString *)pid
                                adSize:(CGSize)size
                               adCount:(NSInteger)count
                       adViewsCallback:(void (^)(NSArray *adViews, NSError *error))adViewsCallback
                          eCPMCallback:(void (^)(NSInteger eCPM))eCPMCallback
                          stateChanged:(void (^)(id adObj, NSInteger state, NSError *error))stateCallback
                       dislikeCallback:(void (^)(id adObj, NSArray<NSString *> *reasons))dislikeCallback;


// 原生自渲染
+ (void)nativeAdWithPlacementId:(NSString *)pid
                        adCount:(NSInteger)count
                 viewController:(UIViewController *)viewController
                    adsCallback:(void (^)(NSArray *ads, NSError *error))adsCallback
                   eCPMCallback:(void (^)(NSInteger eCPM))eCPMCallback
                   stateChanged:(void (^)(id adObj, NSInteger state, NSError *error))stateCallback
                dislikeCallback:(void (^)(id adObj, NSArray<NSString *> *reasons))dislikeCallback;
// 获取原生自渲染的绑定视图对象（仅GDT使用,主要是为了让GDT的自渲染广告事件有回调）
+ (UIView *)getGDTUnifiedNativeAdViewForNativeAdDataObject:(id)dataObject;
// 原生自渲染绑定视图（仅GDT使用,主要是为了让GDT的自渲染广告事件有回调）
+ (void)registerNativeAdDataObject:(id)dataObject
                    clickableViews:(NSArray<UIView *> *)clickableViews
                  forContainerView:(UIView *)contaniner
                    containerFrame:(CGRect)containerFrame;
// 解除原生自渲染绑定视图（仅GDT使用）
+ (void)unregisterNativeAdDataObject:(id)dataObject;
// 设置原生自渲染广告的rootvc（仅GDT使用）
+ (void)setRootViewController:(UIViewController *)vc forNativeAdDataObject:(id)dataObject;
// 获取广告logo视图（仅GDT使用）
+ (id)getAdLogoImageFromNativeAdDataObject:(id)dataObject;
// 获取广告视频视图（仅GDT使用）
+ (id)getAdMediaViewFromNativeAdDataObject:(id)dataObject;

// 全屏视频广告（仅BUD使用）
+ (void)showFullScreenVideoAdWithPlacementId:(NSString *)pid
                              viewController:(UIViewController *)vc
                            ritSceneDescribe:(NSString *)sceneDescirbe
                                stateChanged:(void (^)(id adObj, NSInteger state, NSError *error))stateCallback;


// 激励视频广告
+ (void)showRewardVideoAdWithPlacementId:(NSString *)pid
                          viewController:(UIViewController *)vc
                            eCPMCallback:(void (^)(NSInteger eCPM))eCPMCallback
                            stateChanged:(void (^)(id adObj, NSInteger state, NSError *error))stateCallback;

// Draw视频流广告（仅BUD使用）
+ (void)drawVideoFeedAdWithPlacementId:(NSString *)pid
                               adCount:(NSInteger)count
                        viewController:(UIViewController *)viewController
                    drawVideosCallback:(void (^)(NSArray *drawVideoDatas, NSError *error))videosCallback
                          stateChanged:(void (^)(id adObj, NSInteger state, NSError *error))stateCallback
                       dislikeCallback:(void (^)(id adObj, NSArray<NSString *> *reasons))dislikeCallback;


@end

