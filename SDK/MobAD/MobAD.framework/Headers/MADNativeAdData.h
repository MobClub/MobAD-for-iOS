//
//  MADNativeAdData.h
//  MobAD
//
//  Created by Sands_Lee on 2019/9/18.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADNativeAdData : NSObject

/**
 广告标题
 */
@property (nonatomic, copy) NSString *adTitle;

/**
 广告描述
 */
@property (nonatomic, copy) NSString *adDesc;

/**
 大图、三小图、视频等广告的资源Url集合
 */
@property (nonatomic, strong) NSArray *mediaUrls;

/**
 图片宽度
 */
@property (nonatomic, assign) CGFloat imgWidth;

/**
 图片高度
 */
@property (nonatomic, assign) CGFloat imgHeight;

/**
 广告Logo图片
 */
@property (nonatomic, strong) UIImage *adLogoImage;

/**
 应用类广告App 图标Url
 */
@property (nonatomic, copy) NSString *iconUrl;

/**
 广告来源信息
 */
@property (nonatomic, copy) NSString *adSource;

/**
 必须设置，广告跳转控制器
 */
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
 是否是视频广告
 */
@property (nonatomic, assign) BOOL isVideoAd;


/**
 视频播放View,register后 才可自行设置frame
 */
@property (nonatomic, strong) UIView *mediaView;

/**
 广告来源平台
 */
@property (nonatomic, assign, readonly) NSInteger adPlat;

/**
 广告位id
 */
@property (nonatomic, copy, readonly) NSString *placementId;


/**
 绑定广告点击事件
 */
- (void)registerContainer:(__kindof UIView *)containerView withClickableViews:(NSArray<__kindof UIView *> *_Nullable)clickableViews;

/**
 取消绑定
 */
- (void)unregisterView;

@end

