//
//  MADChannelManager_Private.h
//  MobAD
//
//  Created by Sands_Lee on 2019/9/18.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#ifndef MADChannelManager_Private_h
#define MADChannelManager_Private_h

#import "MADChannelManager.h"

@class MADConfig;

@interface MADChannelManager()

@property (nonatomic, copy) NSString *mobDuid;
@property (nonatomic, copy) NSString *mobAppkey;

/**
 广告初始化配置信息
 */
@property (nonatomic, strong) MADConfig *config;

/**
 记录请求id,用于服务端响应时校验
 */
@property (nonatomic, strong) NSMutableArray *reqIds;

/**
 app 启动次数,仅供MOB使用
 */
@property (nonatomic, assign, readonly) NSInteger appStartCount;

/**
 广告总曝光次数计数
 */
@property (nonatomic, assign) NSInteger adTotalExposedTimes;

/**
 是否强制使用测试环境(仅供 Debug Demo 使用)
 */
@property (nonatomic, assign) BOOL isForceDebug;

/// 强制使用测试包名(仅供 Debug Demo 使用)
@property (nonatomic, copy) NSString *debugBundleId;

/// 更新本地配置信息（仅用于内部debug demo，能够更换appkey，方便测试）
/// @param appkey MobAppkey
/// @param completeHandler 配置更新成功回调
- (void)updateLocalConfigWithAppkey:(NSString *)appkey onComplete:(void (^)(NSDictionary *configDict, NSError *error))completeHandler;

@end



#endif /* MADChannelManager_Private_h */
