//
//  MobADPrivacyView.h
//  MobADDemo
//
//  Created by Rocker on 2020/5/19.
//  Copyright © 2020 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobADPrivacyView : UIView

-(void)loadWebViewWithURL:(NSURL *)url;

@property (copy, nonatomic) void (^clickBlock)(BOOL isAgree);

@end

NS_ASSUME_NONNULL_END
