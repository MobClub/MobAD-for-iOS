//
//  MobADDeviceAlertView.h
//  MobADDemo
//
//  Created by Rocker on 2020/5/12.
//  Copyright © 2020 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobADDeviceAlertView : UIView

@property (copy, nonatomic) void (^dismissBlock)(void);

@property (copy, nonatomic) void (^copyBlock)(void);

@end

NS_ASSUME_NONNULL_END
