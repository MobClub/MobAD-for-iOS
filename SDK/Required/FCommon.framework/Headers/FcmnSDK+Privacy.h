//
//  FCmnSDK+Privacy.h
//  FCMN
//
//  Created by liyc on 2020/1/21.
//  Copyright © 2020 FCMN. All rights reserved.
//

#import <FCommon/FCmnSDK.h>
#import <UIKit/UIKit.h>

#ifndef FCmnSDK_Privacy_h
#define FCmnSDK_Privacy_h

@interface FcmnSDK (Privacy)

/**
 上传隐私协议授权状态
 @param isAgree 是否同意（用户授权后的结果）
 */
+ (void)uploadPrivacyPermissionStatus:(BOOL)isAgree
                             onResult:(void (^_Nullable)(BOOL success))handler;


/**
 获取隐私协议授权状态
 @return 隐私协议授权状态（-1：未授权 0：拒绝 1：同意）
 */
+ (NSInteger)privacyPermissionStatus;


@end


#endif /* FCmnSDK_Privacy_h */
