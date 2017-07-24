//
//  UIImage+Color.m
//  XXiOSProject
//
//  Created by Beelin on 17/6/23.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)xx_imageWithColor:(UIColor *)color {
    return  [self xx_imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)xx_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
