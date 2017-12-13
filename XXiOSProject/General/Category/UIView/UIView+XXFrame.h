//
//  UIView+XXFrame.h
//  XXCategory
//
//  Created by Beelin on 17/7/17.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XXFrame)

@property (nonatomic) CGFloat xx_x;
@property (nonatomic) CGFloat xx_y;
@property (nonatomic) CGFloat xx_w;
@property (nonatomic) CGFloat xx_h;

@property (nonatomic) CGFloat xx_centerX;
@property (nonatomic) CGFloat xx_centerY;
@property (nonatomic) CGPoint xx_center;

@property (nonatomic) CGPoint xx_origin;
@property (nonatomic) CGSize  xx_size;

@property (nonatomic, readonly) CGFloat xx_left;
@property (nonatomic, readonly) CGFloat xx_right;
@property (nonatomic, readonly) CGFloat xx_top;
@property (nonatomic, readonly) CGFloat xx_bottom;

- (UIViewController *)xx_viewController;
@end
