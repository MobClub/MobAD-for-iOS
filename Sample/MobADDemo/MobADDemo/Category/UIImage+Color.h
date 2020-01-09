//
//  UIImage+Color.h
//  MobADDemo
//
//  Created by Sands_Lee on 2019/11/25.
//  Copyright © 2019 Max. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 渐变方向枚举

 - UIImageGradientDirectionLeftToRight: 从左到右（默认值）
 - UIImageGradientDirectionTopToBottom: 从上到下
 - UIImageGradientDirectionLeftTopToRightBottom: 从左上到右下
 - UIImageGradientDirectionLeftBottomToRightTop: 从左下到右上
 */
typedef NS_ENUM(NSInteger, UIImageGradientDirection) {
    UIImageGradientDirectionLeftToRight             = 0,
    UIImageGradientDirectionTopToBottom,
    UIImageGradientDirectionLeftTopToRightBottom,
    UIImageGradientDirectionLeftBottomToRightTop,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)

/// 颜色生成单色图片
/// @param color 图片颜色
+ (UIImage *)imageWithColor:(UIColor *)color;

/// 多个颜色生成渐变色图片
/// @param colors 颜色数组
+ (UIImage * _Nullable)gradientImageWithColors:(NSArray<UIColor *> *)colors;

/// 多个颜色生成渐变色图片,可调整渐变点
/// @param colors 颜色数组
/// @param locations 渐变点数组, 每个元素取值[0,1], 个数必须与颜色数组元素个数一致
+ (UIImage * _Nullable)gradientImageWithColors:(NSArray<UIColor *> *)colors gradientLocations:(NSArray<NSNumber *>  * _Nullable)locations;

/// 多个颜色生成渐变色图片,可调整渐变方向和渐变点
/// @param colors 颜色数组
/// @param direction 渐变方向
/// @param locations 渐变点数组, 每个元素取值[0,1], 个数必须与颜色数组元素个数一致
+ (UIImage * _Nullable)gradientImageWithColors:(NSArray<UIColor *> *)colors gradientDirection:(UIImageGradientDirection)direction gradientLocations:(NSArray<NSNumber *>  * _Nullable)locations;

@end

NS_ASSUME_NONNULL_END
