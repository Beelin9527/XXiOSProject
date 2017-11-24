//
//  UIButton+XXSwapPlace.m
//  XXCategory
//
//  Created by Beelin on 17/7/15.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "UIButton+XXSwapPlace.h"

@implementation UIButton (XXSwapPlace)
- (void)xx_imageUpTitleDown {
    [self xx_imageUpTitleDownWithOffset:5];
}

- (void)xx_imageUpTitleDownWithOffset:(CGFloat)offset {
    self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                            -self.imageView.frame.size.width,
                                            -self.imageView.frame.size.height - offset,
                                            0);
    // 由于iOS8中titleLabel的size为0，使用intrinsicContentSize
    self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height - offset,
                                            0,
                                            0,
                                            -self.titleLabel.intrinsicContentSize.width);
}

- (void)xx_imageRightTitleLeft {
    [self xx_imageRightTitleLeftWithOffset:5];
}

- (void)xx_imageRightTitleLeftWithOffset:(CGFloat)offset {
    self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                            -self.imageView.frame.size.width - offset,
                                            0,
                                            self.imageView.frame.size.width + offset);
    self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                            self.titleLabel.intrinsicContentSize.width + offset,
                                            0,
                                            0);
}
@end
