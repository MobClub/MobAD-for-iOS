//
//  MADNativeFeedTableViewCell.h
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/18.
//  Copyright © 2019 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MADNativeAdData;

NS_ASSUME_NONNULL_BEGIN

@interface MADNativeFeedBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *adTitleLabel;
@property (nonatomic, strong) UILabel *adDescLabel;
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UIImageView *appIconImageView;
@property (nonatomic, strong) UIImageView *adLogoImageView;

- (void)refrashWithModel:(MADNativeAdData *)model;

+ (CGFloat)cellHeightWithModel:(MADNativeAdData *)model width:(CGFloat)width;

@end

@interface MADNativeFeedLeftTableViewCell : MADNativeFeedBaseTableViewCell

@end

@interface MADNativeFeedLargeTableViewCell : MADNativeFeedBaseTableViewCell

@end

@interface MADNativeFeedThreeTableViewCell : MADNativeFeedBaseTableViewCell

@end

@interface MADNativeFeedVideoTableViewCell : MADNativeFeedBaseTableViewCell

@end


NS_ASSUME_NONNULL_END
