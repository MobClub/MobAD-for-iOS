//
//  MobAD+Private.h
//  MobAD
//
//  Created by Sands_Lee on 2019/11/25.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <MobAD/MobAD.h>


@interface MobAD (Private)

/// 更新本地配置信息（仅用于内部debug demo，能够更换appkey，方便测试）
/// @param appkey MobAppkey
/// @param completeHandler 配置更新成功回调
+ (void)updateLocalConfigWithAppkey:(NSString *)appkey onComplete:(void (^)(NSDictionary *configDict, NSError *error))completeHandler;


/// 强制使用测试环境（仅用于内部debug demo，能够切换SDK配置请求环境）
/// @param isDebug YES 使用, NO 不使用（由SDK内部配置决定）
+ (void)useDebugAPI:(BOOL)isDebug;

+ (void)setBundleId:(NSString *)bundleId;

@end
