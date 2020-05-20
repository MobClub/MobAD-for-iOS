//
//  MobADMainCollectionViewCell.h
//  MobADDemo
//
//  Created by Rocker on 2020/5/11.
//  Copyright © 2020 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobADMainCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backImgView;

@property (weak, nonatomic) IBOutlet UIImageView *adIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *adTitleLabel;

-(void)setSelectBackImageViewWithIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
