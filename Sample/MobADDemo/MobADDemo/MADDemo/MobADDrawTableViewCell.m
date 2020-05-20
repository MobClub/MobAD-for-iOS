//
//  MobADDrawTableViewCell.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/5.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MobADDrawTableViewCell.h"
#import "MobADPlayerViewController.h"
#import <MobAD/MobAD.h>


#define GlobleHeight [UIScreen mainScreen].bounds.size.height
#define GlobleWidth [UIScreen mainScreen].bounds.size.width
#define inconWidth 45
#define inconEdge 15
#define bu_textEnde 5
#define bu_textColor MOB_RGB(0xf0, 0xf0, 0xf0)
#define bu_textFont 14

@interface MobADDrawBaseTableViewCell()

@property (nonatomic, strong, nullable) UIImageView *likeImg;
@property (nonatomic, strong, nullable) UILabel *likeLable;
@property (nonatomic, strong, nullable) UIImageView *commentImg;
@property (nonatomic, strong, nullable) UILabel *commentLable;
@property (nonatomic, strong, nullable) UIImageView *forwardImg;
@property (nonatomic, strong, nullable) UILabel *forwardLable;

@end


@implementation MobADDrawBaseTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildupView];
    }
    return self;
}

- (void)buildupView {
    self.adLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, GlobleHeight-200, 50, 17)];
    [self.contentView addSubview:self.adLogoImageView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.frame = CGRectMake(13, GlobleHeight-180, GlobleWidth-26, 30);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = bu_textColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.frame = CGRectMake(13, GlobleHeight-180+40, GlobleWidth-26, 50);
    self.descriptionLabel.font = [UIFont systemFontOfSize:16];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.textColor = bu_textColor;
    [self.contentView addSubview:self.descriptionLabel];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, GlobleHeight*0.3, inconWidth, inconWidth)];
    _headImg.image = [UIImage imageNamed:@"head"];
    _headImg.clipsToBounds = YES;
    _headImg.layer.cornerRadius = inconWidth/2;
    _headImg.layer.borderColor = bu_textColor.CGColor;
    _headImg.layer.borderWidth = 1;
    [self.contentView addSubview:_headImg];
    
    _likeImg = [[UIImageView alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _headImg.frame.origin.y + inconWidth + inconEdge, inconWidth, inconWidth)];
    _likeImg.image = [UIImage imageNamed:@"like"];
    [self.contentView addSubview:_likeImg];
    
    _likeLable = [[UILabel alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _likeImg.frame.origin.y + inconWidth + bu_textEnde, inconWidth, bu_textFont)];
    _likeLable.font = [UIFont systemFontOfSize:bu_textFont];
    _likeLable.textAlignment = NSTextAlignmentCenter;
    _likeLable.textColor = bu_textColor;
    _likeLable.text = @"21.4w";
    [self.contentView addSubview:_likeLable];
    
    _commentImg = [[UIImageView alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _likeLable.frame.origin.y + bu_textFont + inconEdge, inconWidth, inconWidth)];
    _commentImg.image = [UIImage imageNamed:@"comment"];
    [self.contentView addSubview:_commentImg];
    
    _commentLable = [[UILabel alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _commentImg.frame.origin.y + inconWidth + bu_textEnde, inconWidth, bu_textFont)];
    _commentLable.font = [UIFont systemFontOfSize:bu_textFont];
    _commentLable.textAlignment = NSTextAlignmentCenter;
    _commentLable.textColor = bu_textColor;
    _commentLable.text = @"3065";
    [self.contentView addSubview:_commentLable];
    
    _forwardImg = [[UIImageView alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _commentLable.frame.origin.y + bu_textFont + inconEdge, inconWidth, inconWidth)];
    _forwardImg.image = [UIImage imageNamed:@"forward"];
    [self.contentView addSubview:_forwardImg];
    
    _forwardLable = [[UILabel alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _forwardImg.frame.origin.y + inconWidth + bu_textEnde, inconWidth, bu_textFont)];
    _forwardLable.font = [UIFont systemFontOfSize:bu_textFont];
    _forwardLable.textAlignment = NSTextAlignmentCenter;
    _forwardLable.textColor = bu_textColor;
    _forwardLable.text = @"2.9w";
    [self.contentView addSubview:_forwardLable];
}

+ (CGFloat)cellHeight{
    return GlobleHeight;
}


@end



@interface MobADDrawNormalTableViewCell()

@property (nonatomic, strong) MobADPlayerViewController *player;

@end


@implementation MobADDrawNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

-(void)autoPlay {
    self.player = [self reuseInlinePlayer];
    NSString *resourceName = [NSString stringWithFormat:@"drawLocal_11%u",arc4random()%3];
    NSString *loacUrl = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"mov"];
    _player.contentURL = [NSURL fileURLWithPath:loacUrl];
    [_player play];
}

- (void)pause
{
    [_player pause];
}

- (void)setPlayer:(MobADPlayerViewController *)player {
    _player = player;
    if (_player) {
        _player.view.frame = CGRectMake(0, 0, GlobleWidth, GlobleHeight);
        [self.contentView insertSubview:_player.view atIndex:0];
    }
}

- (BOOL)willDealloc {
    return NO;
}

- (MobADPlayerViewController *)reuseInlinePlayer {
    static MobADPlayerViewController* player = nil;
    if (!player) {
        player = [[MobADPlayerViewController alloc] init];
    }else{
        player.contentURL = nil;
        [player.view removeFromSuperview];
        [player pause];
    }
    return player;
}

-(void)refreshUIAtIndex:(NSUInteger)index{
    self.titleLabel.text = [NSString stringWithFormat:@"第【%lu】页, [Draw] 模拟视频标题",(unsigned long)index];
    self.descriptionLabel.text = @"沉浸式视频，超强体验，你值得拥有。";
}

@end



@implementation MobADDrawTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self buildupVideoView];
    }
    return self;
}

- (void)buildupVideoView{
    
    if (self.creativeButton && !self.creativeButton.superview) {
        self.creativeButton.frame = CGRectMake(15, GlobleHeight-80, GlobleWidth-30, 40);
        [self.creativeButton.layer setCornerRadius:3];
        [self.contentView addSubview:self.creativeButton];
    }
    [self addAccessibilityIdentifier];
}

- (UIButton *)creativeButton
{
    if (!_creativeButton) {
        _creativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creativeButton setTitle:@"View details >" forState:UIControlStateNormal];
        _creativeButton.backgroundColor = MOB_RGB(0x80,0xbb,0x41);
        _creativeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _creativeButton;
}

-(void)refreshUIWithModel:(MOBADNativeAdData *)model
{
    // send log
   // [MobAD sendAdLogWithState:MADStateWillExposure adObject:model error:nil];
    
//    for (UIView *v in self.contentView.subviews) {
//        [v removeFromSuperview];
//    }
    self.adLogoImageView.image = model.adLogoImage;
    self.titleLabel.text = model.adTitle;
    self.descriptionLabel.text = model.adDesc;
    [self.creativeButton setTitle:@"下载" forState:UIControlStateNormal];
    
    model.mediaView.frame = CGRectMake(0, 0, GlobleWidth, GlobleHeight);
    [self.contentView insertSubview:model.mediaView atIndex:0];
    
    [model registerContainer:self.contentView containerFrame:[UIScreen mainScreen].bounds withClickableViews:@[self.creativeButton,self.titleLabel,self.descriptionLabel,self.headImg]];
}

#pragma mark addAccessibilityIdentifier
- (void)addAccessibilityIdentifier
{
    self.creativeButton.accessibilityIdentifier = @"button";
    self.titleLabel.accessibilityIdentifier = @"draw_appname";
    self.descriptionLabel.accessibilityIdentifier = @"draw_appdetial";
}


@end

