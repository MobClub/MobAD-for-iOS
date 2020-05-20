//
//  FCMNImageServiceTypeDef.h
//  FCommon
//
//  Created by fcmn on 15/6/8.
//  Copyright (c) 2015年 FCMN. All rights reserved.
//

#ifndef FCommon_FCMNImageServiceTypeDef_h
#define FCommon_FCMNImageServiceTypeDef_h

#import <UIKit/UIKit.h>


/**
 图片缓存处理
 
 @param imageData 图片的数据
 */
typedef NSData* (^FCMNImageGetterCacheHandler)(NSData *imageData);

/**
 *  图片加载返回
 *
 *  @param image 图片对象
 *  @param error 错误信息
 */
typedef void (^FCMNImageGetterResultHandler)(UIImage *image, NSError *error);

/**
 *  图片加载返回
 *
 *  @param imageData 图片数据
 *  @param error 错误信息
 */
typedef void (^FCMNImageDataGetterResultHandler)(NSData *imageData, NSError *error);

#endif
