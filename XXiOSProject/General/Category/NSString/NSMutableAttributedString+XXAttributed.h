//
//  NSMutableAttributedString+XXAttributed.h
//  XXCategory
//
//  Created by Beelin on 17/8/1.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIColor;

@interface NSMutableAttributedString (XXAttributed)
/**
 *  富文本 文字前景颜色
 *
 *  @param colors 数组<UIColor *>
 *  @param ranges 数组<包装NSRange的NSValue>
 */
- (void)xx_attributedForegroundColorWithColors:(NSArray<UIColor *> *)colors ranges:(NSArray <NSValue*>*)ranges;
@end
