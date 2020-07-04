//
//  MobADNativeIDTableViewCell.h
//  MobADDemo
//
//  Created by Rocker on 2020/5/19.
//  Copyright © 2020 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobADNativeIDTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *textFiledl;

@property (copy, nonatomic) void(^getTextBlock)(NSString *text);

@end

NS_ASSUME_NONNULL_END
