//
//  MADDislikeReason.h
//  MobAD
//
//  Created by Sands_Lee on 2019/9/24.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MADDislikeReason : NSObject

/**
 reason index
 */
@property (nonatomic, copy, readonly) NSString *dislikeID;

/**
 reason text
 */
@property (nonatomic, copy, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END
