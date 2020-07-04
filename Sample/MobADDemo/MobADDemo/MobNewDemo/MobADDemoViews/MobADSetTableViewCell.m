//
//  MobADSetTableViewCell.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/12.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADSetTableViewCell.h"

@implementation MobADSetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = MOB_RGB(250, 250, 250);
    self.backImgView.image = [UIImage imageNamed:@"bg_cell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
