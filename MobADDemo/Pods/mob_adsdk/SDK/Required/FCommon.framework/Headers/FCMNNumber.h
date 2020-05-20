//
//  FCMNNumberUtils.h
//  FCommon
//
//  Created by fcmn on 15-1-20.
//  Copyright (c) 2015年 FCMN. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  数值工具类
 */
@interface FCMNNumber : NSObject

/**
 *  获取随机整型值
 *
 *  @param max 最大随机数
 *
 *  @return 随机整数
 */
+ (NSInteger)randomInteger:(NSInteger)max;

@end
