//
//  FcmnSDK.h
//  FCommon
//
//  Created by fcmn on 17/2/23.
//  Copyright © 2017年 FCMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCMNSDKDef.h"

/**
 FcmnSDK
 */
@interface FcmnSDK : NSObject

/**
 获取版本号

 @return 版本号
 */
+ (NSString * _Nonnull)version;

/**
 获取应用标识
 
 @return 应用标识
 */
+ (NSString * _Nullable)appKey;

/**
 获取应用密钥

 @return 应用密钥
 */
+ (NSString * _Nullable)appSecret;

/**
 获取当前国际域名

 @return 域名
 */
+ (NSString *_Nullable)getInternationalDomain;

/**
 设置国际域名

 @param domainType 域名类型
 */
+ (void)setInternationalDomain:(FCMNSDKDomainType)domainType;

/**
 变更应用密钥，针对服务器刷新应用密钥后，可以通过该方法进行修改

 @param appSecret 应用密钥
 */
+ (void)changeAppSecret:(NSString * _Nonnull)appSecret;

/**
 注册appKey、appSecret

 @param appKey appKey
 @param appSecret appSecret
 */
+ (void)registerAppKey:(NSString * _Nonnull)appKey
             appSecret:(NSString * _Nonnull)appSecret;

@end
