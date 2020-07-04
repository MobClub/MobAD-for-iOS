//
//  MobADSetDebugTableViewCell.h
//  MobADDemo
//
//  Created by Rocker on 2020/5/13.
//  Copyright © 2020 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobADSetDebugTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *debugSwitch;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UITextField *apiTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;

-(void)setCellStyleSwitch;

-(void)setCellStyleTextField;

-(void)setCellStyleNormal;

@property (copy, nonatomic) void(^switchBlock)(BOOL isOn);

@property (copy, nonatomic) void(^getConfigBlock)(NSString *config);

@end

NS_ASSUME_NONNULL_END
