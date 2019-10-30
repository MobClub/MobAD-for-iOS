//
//  MobADDrawTableViewCell.h
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/5.
//  Copyright © 2019 Max. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MADNativeAdData;

NS_ASSUME_NONNULL_BEGIN

@protocol MobADDrawCellProtocol <NSObject>

+ (CGFloat)cellHeight;

@end

@interface MobADDrawBaseTableViewCell : UITableViewCell<MobADDrawCellProtocol>

@property (nonatomic, strong, nullable) UIImageView *adLogoImageView;
@property (nonatomic, strong, nullable) UILabel *titleLabel;
@property (nonatomic, strong, nullable) UILabel *descriptionLabel;
@property (nonatomic, strong, nullable) UIImageView *headImg;

@end


@interface MobADDrawNormalTableViewCell : MobADDrawBaseTableViewCell<MobADDrawCellProtocol>

@property (nonatomic, assign) NSInteger videoId;

- (void)refreshUIAtIndex:(NSUInteger)index;

- (void)autoPlay;

- (void)pause;

@end


@interface MobADDrawTableViewCell : MobADDrawBaseTableViewCell<MobADDrawCellProtocol>

@property (nonatomic, strong) UIButton *creativeButton;

- (void)refreshUIWithModel:(MADNativeAdData *_Nonnull)model;

@end


NS_ASSUME_NONNULL_END
