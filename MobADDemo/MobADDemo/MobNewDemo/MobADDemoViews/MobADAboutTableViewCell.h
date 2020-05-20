//
//  MobADAboutTableViewCell.h
//  MobADDemo
//
//  Created by Rocker on 2020/5/12.
//  Copyright © 2020 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobADAboutTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

NS_ASSUME_NONNULL_END
