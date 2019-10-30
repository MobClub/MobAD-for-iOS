//
//  MADNativeFeedTableViewCell.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/18.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MADNativeFeedTableViewCell.h"
#import <MobAD/MobAD.h>

static CGFloat const margin = 15;
static CGSize const appIconSize = {20, 20};
static CGSize const logoSize = {30, 10};
static CGSize const bigLogoSize = {49, 16};
static UIEdgeInsets const padding = {10, 15, 10, 15};

@interface MADNativeFeedBaseTableViewCell()
{
    MADNativeAdData *_nativeAdData;
}

@end

@implementation MADNativeFeedBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self _setupUI];
    }
    return self;
}

- (void)_setupUI
{
    self.adTitleLabel = [[UILabel alloc] init];
    self.adTitleLabel.numberOfLines = 1;
    self.adTitleLabel.textColor = [UIColor blackColor];
    self.adTitleLabel.font = [UIFont systemFontOfSize:17.f];
    self.adTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.adTitleLabel];
    
    self.adDescLabel = [[UILabel alloc] init];
    self.adDescLabel.numberOfLines = 0;
    self.adDescLabel.textColor = [UIColor lightTextColor];
    self.adDescLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.adDescLabel];
    
    self.adImageView = [[UIImageView alloc] init];
    self.adImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.adImageView];
    
    self.appIconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.appIconImageView];
    
    self.adLogoImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.adLogoImageView];
}

- (void)refrashWithModel:(MADNativeAdData *)model
{
    _nativeAdData = model;
    
    // send log
    [MobAD sendAdLogWithState:MADStateWillExposured adObject:model error:nil];
}

+ (CGFloat)cellHeightWithModel:(MADNativeAdData *)model width:(CGFloat)width
{
    return UITableViewAutomaticDimension;
}

+ (NSAttributedString *)subtitleAttributeText:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    NSMutableDictionary *attribute = @{}.mutableCopy;
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:12.f];
    attribute[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

+ (NSAttributedString *)infoAttributeText:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    NSMutableDictionary *attribute = @{}.mutableCopy;
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:12.f];
    attribute[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

@end



@implementation MADNativeFeedLeftTableViewCell

- (void)refrashWithModel:(MADNativeAdData *)model
{
    [super refrashWithModel:model];
    
    [model registerContainer:self withClickableViews:@[
                                                       self.adImageView,
                                                       ]];
    
    NSString *urlStr = model.mediaUrls.firstObject;
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat x = padding.left;
    CGFloat y = padding.top;
    
    // 主图
    const CGFloat imageWidth = width * 0.4 - margin;
    const CGFloat imageHeight = imageWidth * (model.imgHeight / model.imgWidth);
    self.adImageView.frame = CGRectMake(x, y, imageWidth, imageHeight);
    [[MOBFImageGetter sharedInstance] getImageWithURL:[NSURL URLWithString:urlStr] result:^(UIImage *image, NSError *error) {
        self.adImageView.image = image;
    }];
    
    // appicon
    x = width * 0.4 + margin;
    if (model.iconUrl.length > 0) {
        self.appIconImageView.frame = CGRectMake(x, y, appIconSize.width, appIconSize.height);
        [[MOBFImageGetter sharedInstance] getImageWithURL:[NSURL URLWithString:model.iconUrl] result:^(UIImage *image, NSError *error) {
            self.appIconImageView.image = image;
        }];
    }
    
    // ad logo
    self.adLogoImageView.frame = CGRectMake(CGRectGetMaxX(self.adImageView.frame) - logoSize.width, CGRectGetMaxY(self.adImageView.frame) - logoSize.height, logoSize.width, logoSize.height);
    self.adLogoImageView.image = model.adLogoImage;
    
    // title
    if (model.iconUrl.length > 0) {
        x = width * 0.4 + margin + appIconSize.width + margin;
    }
    CGFloat maxTitleWidth =  width - x - margin;
    self.adTitleLabel.frame = CGRectMake(x, y , maxTitleWidth, 20);
    self.adTitleLabel.text = model.adTitle;
    
    // desc
    x = width * 0.4 + margin;
    y = CGRectGetMaxY(self.adImageView.bounds) - 20;
    CGFloat maxInfoWidth = width - imageWidth - 3 * margin;
    self.adDescLabel.frame = CGRectMake(x , y , maxInfoWidth, 30);
    self.adDescLabel.attributedText = [MADNativeFeedBaseTableViewCell subtitleAttributeText:model.adDesc];
}

+ (CGFloat)cellHeightWithModel:(MADNativeAdData *)model width:(CGFloat)width
{
    const CGFloat imageWidth = width * 0.4 - margin;
    const CGFloat imageHeight = imageWidth * (model.imgHeight / model.imgWidth);
    return padding.top + imageHeight +padding.bottom;
}

@end


@implementation MADNativeFeedLargeTableViewCell

- (void)refrashWithModel:(MADNativeAdData *)model
{
    [super refrashWithModel:model];
    
    [model registerContainer:self withClickableViews:@[
                                                       self.adImageView,
                                                       ]];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    // desc
    CGFloat x = padding.left;
    CGFloat y = padding.top;
    CGFloat maxInfoWidth = width - 2 * margin;
    self.adDescLabel.frame = CGRectMake(x , y , maxInfoWidth, 30);
    self.adDescLabel.attributedText = [MADNativeFeedBaseTableViewCell subtitleAttributeText:model.adDesc];
    
    // 主图
    NSString *urlStr = model.mediaUrls.firstObject;
    y += 30;
    const CGFloat imageWidth = width - padding.left - padding.right;
    const CGFloat imageHeight = imageWidth * (model.imgHeight / model.imgWidth);
    self.adImageView.frame = CGRectMake(x, y, imageWidth, imageHeight);
    [[MOBFImageGetter sharedInstance] getImageWithURL:[NSURL URLWithString:urlStr] result:^(UIImage *image, NSError *error) {
        self.adImageView.image = image;
    }];
    
    // ad logo
    self.adLogoImageView.frame = CGRectMake(CGRectGetMaxX(self.adImageView.frame) - bigLogoSize.width, CGRectGetMaxY(self.adImageView.frame) - bigLogoSize.height, bigLogoSize.width, bigLogoSize.height);
    self.adLogoImageView.image = model.adLogoImage;
    
    // appicon
    y = CGRectGetMaxY(self.adImageView.frame) + margin;
    if (model.iconUrl.length > 0) {
        self.appIconImageView.frame = CGRectMake(x, y, appIconSize.width, appIconSize.height);
        [[MOBFImageGetter sharedInstance] getImageWithURL:[NSURL URLWithString:model.iconUrl] result:^(UIImage *image, NSError *error) {
            self.appIconImageView.image = image;
        }];
    }
    
    // title
    if (model.iconUrl.length > 0) {
        x = padding.left + appIconSize.width + margin;
    }
    CGFloat maxTitleWidth =  width - x - 2 * margin;
    self.adTitleLabel.frame = CGRectMake(x, y , maxTitleWidth, 20);
    self.adTitleLabel.text = model.adTitle;
}

+ (CGFloat)cellHeightWithModel:(MADNativeAdData *)model width:(CGFloat)width
{
    const CGFloat imageWidth = width - padding.left - padding.right;
    const CGFloat imageHeight = imageWidth * (model.imgHeight / model.imgWidth);
    return padding.top + 30 + imageHeight + margin + appIconSize.height + padding.bottom;
}

@end


@implementation MADNativeFeedThreeTableViewCell

- (void)refrashWithModel:(MADNativeAdData *)model
{
    [super refrashWithModel:model];
    
    [model registerContainer:self withClickableViews:@[
                                                       self.adImageView,
                                                       ]];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    // desc
    CGFloat x = padding.left;
    CGFloat y = padding.top;
    CGFloat maxInfoWidth = width - 2 * margin;
    self.adDescLabel.frame = CGRectMake(x , y , maxInfoWidth, 30);
    self.adDescLabel.attributedText = [MADNativeFeedBaseTableViewCell subtitleAttributeText:model.adDesc];
    
    // 左图
    NSString *urlStr = model.mediaUrls.firstObject;
    y += 30;
    const CGFloat imageWidth = (width - padding.left - padding.right - 2*margin) / 3.0;
    const CGFloat imageHeight = imageWidth * (model.imgHeight / model.imgWidth);
    self.adImageView.frame = CGRectMake(x, y, imageWidth, imageHeight);
    
    // 中间图
    UIImageView *midImageV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.adImageView.frame) + margin, y, imageWidth, imageHeight)];
    [self.contentView addSubview:midImageV];
    // 右图
    UIImageView *rImageV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(midImageV.frame) + margin, y, imageWidth, imageHeight)];
    [self.contentView addSubview:rImageV];
    
    [[MOBFImageGetter sharedInstance] getImageWithURL:[NSURL URLWithString:urlStr] result:^(UIImage *image, NSError *error) {
        self.adImageView.image = image;
        midImageV.image = image;
        rImageV.image = image;
    }];
    
    // ad logo
    self.adLogoImageView.frame = CGRectMake(CGRectGetMaxX(self.adImageView.frame) - bigLogoSize.width, CGRectGetMaxY(self.adImageView.frame) - bigLogoSize.height, bigLogoSize.width, bigLogoSize.height);
    self.adLogoImageView.image = model.adLogoImage;
    
    // appicon
    y = CGRectGetMaxY(self.adImageView.frame) + margin;
    self.appIconImageView.frame = CGRectMake(x, y, appIconSize.width, appIconSize.height);
    [[MOBFImageGetter sharedInstance] getImageWithURL:[NSURL URLWithString:model.iconUrl] result:^(UIImage *image, NSError *error) {
        self.appIconImageView.image = image;
    }];
    
    // title
    x = padding.left + appIconSize.width + margin;
    CGFloat maxTitleWidth =  width - x - 2 * margin;
    self.adTitleLabel.frame = CGRectMake(x, y , maxTitleWidth, 20);
    self.adTitleLabel.text = model.adTitle;
}

+ (CGFloat)cellHeightWithModel:(MADNativeAdData *)model width:(CGFloat)width
{
    const CGFloat imageWidth = (width - padding.left - padding.right - 2*margin) / 3.0;
    const CGFloat imageHeight = imageWidth * (model.imgHeight / model.imgWidth);
    return padding.top + 30 + imageHeight + margin + appIconSize.height + padding.bottom;
}

@end


@implementation MADNativeFeedVideoTableViewCell


- (void)refrashWithModel:(MADNativeAdData *)model
{
    [super refrashWithModel:model];
    
    [model registerContainer:self withClickableViews:@[
                                                       self.adImageView,
                                                       ]];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    // desc
    CGFloat x = padding.left;
    CGFloat y = padding.top;
    CGFloat maxInfoWidth = width - 2 * margin;
    self.adDescLabel.frame = CGRectMake(x , y , maxInfoWidth, 30);
    self.adDescLabel.attributedText = [MADNativeFeedBaseTableViewCell subtitleAttributeText:model.adDesc];
    
    // 主图 替换成 Video View
//    NSString *urlStr = model.mediaUrls.firstObject;
    y += 30;
    const CGFloat imageWidth = width - padding.left - padding.right;
    const CGFloat imageHeight = imageWidth * (model.imgHeight / model.imgWidth);
    [self.adImageView removeFromSuperview];
    UIView *videoView = model.mediaView;
    videoView.frame = CGRectMake(x, y, imageWidth, imageHeight);
    [self.contentView addSubview:videoView];
    
    // ad logo
    self.adLogoImageView.frame = CGRectMake(CGRectGetMaxX(videoView.frame) - bigLogoSize.width, CGRectGetMaxY(videoView.frame) - bigLogoSize.height, bigLogoSize.width, bigLogoSize.height);
    self.adLogoImageView.image = model.adLogoImage;
    
    // appicon
    y = CGRectGetMaxY(videoView.frame) + margin;
    self.appIconImageView.frame = CGRectMake(x, y, appIconSize.width, appIconSize.height);
    [[MOBFImageGetter sharedInstance] getImageWithURL:[NSURL URLWithString:model.iconUrl] result:^(UIImage *image, NSError *error) {
        self.appIconImageView.image = image;
    }];
    
    // title
    x = padding.left + appIconSize.width + margin;
    CGFloat maxTitleWidth =  width - x - 2 * margin;
    self.adTitleLabel.frame = CGRectMake(x, y , maxTitleWidth, 20);
    self.adTitleLabel.text = model.adTitle;
}

+ (CGFloat)cellHeightWithModel:(MADNativeAdData *)model width:(CGFloat)width
{
    const CGFloat imageWidth = width - padding.left - padding.right;
    const CGFloat imageHeight = imageWidth * (model.imgHeight / model.imgWidth);
    return padding.top + 30 + imageHeight + margin + appIconSize.height + padding.bottom;
}

@end
