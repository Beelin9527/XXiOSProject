//
//  NSMutableAttributedString+XXAttributed.m
//  XXCategory
//
//  Created by Beelin on 17/8/1.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "NSMutableAttributedString+XXAttributed.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString (XXAttributed)
- (void)xx_attributedForegroundColorWithColors:(NSArray<UIColor *> *)colors ranges:(NSArray <NSValue*>*)ranges {
    for (int i = 0; i < colors.count; i ++) {
        NSValue *r = ranges[i];
        NSRange range = r.rangeValue;
        [self addAttribute:NSForegroundColorAttributeName value:colors[i] range:range];
    }
}
@end
