//
//  FCMNSDKDef.h
//  FCommon
//
//  Created by fcmn on 2018/8/22.
//  Copyright © 2018年 FCMN. All rights reserved.
//

#ifndef FCMNSDKDef_h
#define FCMNSDKDef_h

/**
 *  国际域名类型
 */
typedef NS_ENUM(NSUInteger, FCMNSDKDomainType){
    /**
     *  默认（大陆域名）
     */
    FCMNSDKDomainTypeDefault  = 0,
    /**
     *  美国
     */
    FCMNSDKDomainTypeUS = 1,
    /**
     *  日本
     */
    FCMNSDKDomainTypeJapan = 2,
};

#endif /* FCMNSDKDef_h */
