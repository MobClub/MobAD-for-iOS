//
//  UIImage+Color.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/11/25.
//  Copyright © 2019 Max. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 渐变颜色

+ (UIImage *)gradientImageWithColors:(NSArray<UIColor *> *)colors
{
    return [self gradientImageWithColors:colors gradientLocations:nil];
}


+ (UIImage *)gradientImageWithColors:(NSArray<UIColor *> *)colors gradientLocations:(NSArray<NSNumber *> *)locations
{
    return [self gradientImageWithColors:colors gradientDirection:UIImageGradientDirectionLeftToRight gradientLocations:locations];
}


+ (UIImage *)gradientImageWithColors:(NSArray<UIColor *> *)colors gradientDirection:(UIImageGradientDirection)direction gradientLocations:(NSArray<NSNumber *> *)locations
{
    if (colors.count < 1) {
        return nil;
    }
    if (locations && locations.count != colors.count) {
        return nil;
    }
    CGRect rect = CGRectMake(0, 0, colors.count, 1);
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    // gradient direction
    switch (direction) {
        case UIImageGradientDirectionLeftToRight:
        {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
        case UIImageGradientDirectionTopToBottom:
        {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
        }
            break;
        case UIImageGradientDirectionLeftTopToRightBottom:
        {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 1);
        }
            break;
        case UIImageGradientDirectionLeftBottomToRightTop:
        {
            gradientLayer.startPoint = CGPointMake(0, 1);
            gradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
            
        default:
        {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
    }
    
    NSMutableArray *mutColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors) {
        [mutColors addObject:(__bridge id)color.CGColor];
    }
    gradientLayer.colors = [NSArray arrayWithArray:mutColors];
    
    // gradient locations
    if (locations.count > 0) {
        gradientLayer.locations = locations;
    }
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.opaque, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}


@end
