//
//  MobADToolTableViewCell.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/13.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADToolTableViewCell.h"

@implementation MobADToolTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.bgView.layer.cornerRadius = 3.3;
    self.bgView.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,2.7);
    self.bgView.layer.shadowOpacity = 1;
    self.bgView.layer.shadowRadius = 6.7;
    
    self.openBtn.layer.cornerRadius = 15.f;
    self.openBtn.layer.masksToBounds = YES;
    
    self.openBtn.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)openAction:(id)sender {
    
}


@end
