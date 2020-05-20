//
//  MobADContentTableView.h
//  MobADDemo
//
//  Created by Rocker on 2020/5/15.
//  Copyright © 2020 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobADContentTableView : UIView

@property (copy, nonatomic) NSArray *iconArray;

@property (copy, nonatomic) NSArray *dataArray;

@property (copy, nonatomic) void(^selectCellBlock)(NSInteger index);

-(void)loadTableView;

@end

NS_ASSUME_NONNULL_END
