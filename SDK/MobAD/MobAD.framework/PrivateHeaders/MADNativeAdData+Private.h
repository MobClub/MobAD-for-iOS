//
//  MADNativeAdData+Private.h
//  MobAD
//
//  Created by Sands_Lee on 2019/9/18.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import "MADNativeAdData.h"


@class MSNativeAd;

@interface MADNativeAdData (Private)

- (instancetype)initWithBUNativeAd:(id)nativeAd;

- (instancetype)initWithMSNativeAd:(MSNativeAd *)nativeAd;

- (instancetype)initWithUnifiedNativeAdObject:(id)dataObject;

- (void)setAdPlatWith:(NSInteger)plat;

- (void)setAdPlacementIdWith:(NSString *)pid;

- (MSNativeAd *)getMSNativeAd;

@end
