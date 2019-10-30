//
//  MobADPlayerViewController.h
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/5.
//  Copyright © 2019 Max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobADPlayerViewController : UIViewController

@property (nonatomic, strong, nullable) NSURL *contentURL;

- (void)play;
- (void)pause;

@end

NS_ASSUME_NONNULL_END
