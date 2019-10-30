//
//  MADNativeExpressAdView.h
//  MobAD
//
//  Created by Sands_Lee on 2019/9/17.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 该View为所有原生模版广告统一对外的广告视图
 */
@interface MADNativeExpressAdView : UIView

// 广告视图View
@property (nonatomic, strong) UIView *adView;

/*
 *  viewControllerForPresentingModalView
 *  详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/**
 *[必选]
 *原生模板广告渲染
 */
- (void)render;

@end

NS_ASSUME_NONNULL_END
