//
//  UIView+XXFrame.m
//  XXCategory
//
//  Created by Beelin on 17/7/17.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "UIView+XXFrame.h"

@implementation UIView (XXFrame)
- (CGFloat)xx_x {
    return self.frame.origin.x;
}

- (void)setXx_x:(CGFloat)xx_x {
    CGRect frame = self.frame;
    frame.origin.x = xx_x;
    self.frame = frame;
}

- (CGFloat)xx_y {
    return self.frame.origin.y;
}

- (void)setXx_y:(CGFloat)xx_y {
    CGRect frame = self.frame;
    frame.origin.y = xx_y;
    self.frame = frame;
}

- (CGFloat)xx_w {
    return self.frame.size.width;
}

- (void)setXx_w:(CGFloat)xx_w {
    CGRect frame = self.frame;
    frame.size.width = xx_w;
    self.frame = frame;
}

- (CGFloat)xx_h {
    return self.frame.size.height;
}

- (void)setXx_h:(CGFloat)xx_h {
    CGRect frame = self.frame;
    frame.size.height = xx_h;
    self.frame = frame;
}

- (CGFloat)xx_centerX {
    return self.center.x;
}

- (void)setXx_centerX:(CGFloat)xx_centerX {
    self.center = CGPointMake(xx_centerX, self.center.y);
}

- (CGFloat)xx_centerY {
    return self.center.y;
}

- (void)setXx_centerY:(CGFloat)xx_centerY {
    self.center = CGPointMake(self.center.x, xx_centerY);
}

- (CGPoint)xx_center {
    return self.center;
}

- (void)setXx_center:(CGPoint)xx_center {
    self.center = xx_center;
}

- (CGPoint)xx_origin {
    return self.frame.origin;
}

- (void)setXx_origin:(CGPoint)xx_origin {
    CGRect frame = self.frame;
    frame.origin = xx_origin;
    self.frame = frame;
}

- (CGSize)xx_size {
    return self.frame.size;
}

- (void)setXx_size:(CGSize)xx_size {
    CGRect frame = self.frame;
    frame.size = xx_size;
    self.frame = frame;
}

- (CGFloat)xx_left {
    return self.frame.origin.x;
}

- (CGFloat)xx_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)xx_top {
    return self.frame.origin.y;
}

- (CGFloat)xx_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (UIViewController *)xx_viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
