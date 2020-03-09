//
//  GDTSDKDefines.h
//  GDTMobApp
//
//  Created by royqpwang on 2017/11/6.
//  Copyright © 2017年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// 广告请求超时时间
#define MSADLOADTIMEOUT 30

#define MSWS(weakSelf) __weak __typeof(&*self)weakSelf = self;

// RGB颜色转换（16进制->10进制）
#define MSUIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define MSUIColorFromRGB_Alpha(rgbValue,alphaValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:alphaValue]

typedef NS_ENUM(NSInteger, MOBShowType) {
    MSShowTypeMS    = 0, // 展示美数
    MSShowTypeGDT   = 1, // 展示广点通
    MSShowTypeBU    = 2, // 展示穿山甲
};

typedef NS_ENUM(NSInteger, MOBNativeAdViewShowType) {
    MSLeftImage         = 0, // 展示左图右文+下载按钮
    MSLeftImageNoButton = 1, // 展示左图右文
    MSBottomImage       = 2, // 展示上文下大图
};

typedef NS_ENUM(NSInteger, MOBNativeExpressAdViewShowType) {
    MSExpressAdViewShowTypeLeftImage        = 70, // 展示左图右文
    MSExpressAdViewShowTypeRightImage       = 71, // 展示右图左文
    MSExpressAdViewShowTypeTopImage         = 73, // 展示上图下文
    MSExpressAdViewShowTypeBottomImage      = 72, // 展示上文下图
    MSExpressAdViewShowTypeTwoImages        = 76, // 展示两图一文
    MSExpressAdViewShowTypeThreeImages      = 77, // 展示三图一文
    MSExpressAdViewShowTypeTwoText          = 0, // 展示两文一图（暂无）
    MSExpressAdViewShowTypeTextFloat        = 74, // 文字悬浮
    MSExpressAdViewShowTypeTwoTextFloat     = 75, // 文字悬浮+标题
    MSExpressAdViewShowTypeVideo            = 78, // 展示视频
    MSExpressAdViewShowTypeFullImage        = 79, // 单张图片填充
};

