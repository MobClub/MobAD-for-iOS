//
//  MADNativeExpressAdView+Private.h
//  MobAD
//
//  Created by Sands_Lee on 2019/9/17.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import "MADNativeExpressAdView.h"

@class MSNativeExpressAdView;

NS_ASSUME_NONNULL_BEGIN

@interface MADNativeExpressAdView (Private)

- (instancetype)initWithBUNativeExpressAdView:(id)buView;

- (instancetype)initWithGDTNativeExpressAdView:(id)adView;

- (instancetype)initWithMSNativeExpressAdView:(MSNativeExpressAdView *)msView;

@end

NS_ASSUME_NONNULL_END
