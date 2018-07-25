//
//  UIImage+XXColor.m
//  XXCategory
//
//  Created by Beelin on 17/7/17.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "UIImage+XXColor.h"

@implementation UIImage (XXColor)
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

+ (UIImage *)xx_gradientImageWithBounds:(CGRect)bounds  direction:(UIImageGradientDirection)direction colors:(NSArray *)colors {
    if (!colors.count) return nil;
    NSMutableArray *crefs = @[].mutableCopy;
    [colors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *c = obj;
        CGColorRef cref = c.CGColor;
        [crefs addObject:(__bridge id _Nonnull)(cref)];
    }];
    
    CALayer * bgGradientLayer = [self xx_gradientBGLayerForBounds:bounds colors:crefs.copy direction:direction];
    UIGraphicsBeginImageContext(bgGradientLayer.bounds.size);
    [bgGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * bgAsImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return bgAsImage;
}

+ (CALayer *)xx_gradientBGLayerForBounds:(CGRect)bounds colors:(NSArray *)colors direction:(UIImageGradientDirection)direction
{
    CAGradientLayer * gradientBG = [CAGradientLayer layer];
    gradientBG.frame = bounds;
    gradientBG.colors = colors;
    if (direction == UIImageGradientDirectionRight) {
        gradientBG.startPoint = CGPointMake(0.0, 0);
        gradientBG.endPoint = CGPointMake(1, 0);
    } else {
        gradientBG.startPoint = CGPointMake(0.0, 0);
        gradientBG.endPoint = CGPointMake(0.0, 1.0);
    }
    return gradientBG;
}


+ (UIImage *)imageWithGradient:(UIImage *)image startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(context, rect, image.CGImage);
    
    // Create gradient
    NSArray *colors = [NSArray arrayWithObjects:(id)endColor.CGColor, (id)startColor.CGColor, nil];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, NULL);
    
    // Apply gradient
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0,0), CGPointMake(0, image.size.height), 0);
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
    
    return gradientImage;
}

- (UIImage *)xx_setWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
