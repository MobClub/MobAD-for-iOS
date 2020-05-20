//
//  MobADMainCollectionViewCell.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/11.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADMainCollectionViewCell.h"

@interface MobADMainCollectionViewCell ()

@property (copy, nonatomic) NSArray *iconArray;


@end

@implementation MobADMainCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.layer.contents = (id)[UIImage imageNamed:@"ad_bg_nor"].CGImage;
    self.backgroundColor = [UIColor clearColor];
    self.backImgView.image = [UIImage imageNamed:@"ad_bg_nor"];
    self.iconArray = @[@"ad_icon_splash",@"ad_icon_chaping",@"ad_icon_banner",@"ad_icon_native",@"ad_icon_video",@"ad_icon_rendering"];
}

-(void)setSelectBackImageViewWithIndex:(NSInteger)index
{
    self.backImgView.image = [UIImage imageNamed:@"ad_bg_sel"];
    self.adTitleLabel.textColor = [UIColor whiteColor];
    self.adIconImageView.image = [UIImage imageNamed:self.iconArray[index]];
}


@end
