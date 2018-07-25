//
//  UIImage+svgImage.h
//  XXiOSProject
//
//  Created by Beelin on 2018/7/25.
//  Copyright © 2018年 xx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (svgImage)
/**
 获取svg格式图片
 
 @param name svg name
 @param size image size
 @return svg image
 */
+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size;

/**
 获取自定义颜色图像
 
 @param name svg name
 @param size image size
 @param tintColor image color
 @return svg image
 */
+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size tintColor:(UIColor *)tintColor;


/**
 获取渐变图像

 @param name <#name description#>
 @param size <#size description#>
 @param startColor <#startColor description#>
 @param endColor <#endColor description#>
 @return <#return value description#>
 */
+ (UIImage *)svgImageNamed:(NSString *)name
                      size:(CGSize)size
                startColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor;
@end
