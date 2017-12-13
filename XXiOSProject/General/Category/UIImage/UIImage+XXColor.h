//
//  UIImage+XXColor.h
//  XXCategory
//
//  Created by Beelin on 17/7/17.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 渐变方向 */
typedef NS_ENUM(NSInteger, UIImageGradientDirection) {
    UIImageGradientDirectionRight, //左-->右
    UIImageGradientDirectionDown  //上-->下
};

@interface UIImage (XXColor)
/**
 *  获取图片
 *
 *  @param color 颜色
 *
 *  @return 颜色图片
 */
+ (UIImage *)xx_imageWithColor:(UIColor *)color;

/**
 *  获取图片，，
 *
 *  @param color 颜色
 *  @param size  宽高
 
 *  @return 颜色图片
 */
+ (UIImage *)xx_imageWithColor:(UIColor *)color
                          size:(CGSize)size;

/**
 *   获取渐变的图片
 *
 *  @param bounds bounds
 *  @param colors 数组颜色
 *  @param direction 方向
 *
 *  @return 渐变的图片
 */
+ (UIImage *)xx_gradientImageWithBounds:(CGRect)bounds
                              direction:(UIImageGradientDirection)direction
                                 colors:(NSArray *)colors;
@end
