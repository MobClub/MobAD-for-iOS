//
//  FCMNImageObserver.h
//  FCommon
//
//  Created by fcmn on 16/1/21.
//  Copyright © 2016年 FCMN. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  图片观察者
 */
@interface FCMNImageObserver : NSObject

/**
 *  图片链接
 */
@property (nonatomic, strong, readonly) NSURL *url;

@end
