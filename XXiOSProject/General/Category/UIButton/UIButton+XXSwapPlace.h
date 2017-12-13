//
//  UIButton+XXSwapPlace.h
//  XXCategory
//
//  Created by Beelin on 17/7/15.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XXSwapPlace)
/**
 图文上下间隙默认为5
 */
- (void)xx_imageUpTitleDown;

/**
 offset 自定义设置图文间隙
 */
- (void)xx_imageUpTitleDownWithOffset:(CGFloat)offset;

/**
 图文左右间隙默认为5
 */
- (void)xx_imageRightTitleLeft;

/**
 offset 自定义设置图文间隙
 */
- (void)xx_imageRightTitleLeftWithOffset:(CGFloat)offset;
@end
