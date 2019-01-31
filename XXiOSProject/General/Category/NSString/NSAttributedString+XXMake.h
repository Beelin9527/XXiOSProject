//
//  NSAttributedString+XXMake.h
//  XXiOSProject
//
//  Created by Beelin on 2019/1/31.
//  Copyright © 2019 xx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XXAttributedStringMaker;
@interface NSAttributedString (XXMake)
+ (NSAttributedString *)makeAttributedString:(void(NS_NOESCAPE ^)(XXAttributedStringMaker *make))block;
@end

@class XXAttributedStringChain;
@interface XXAttributedStringMaker : NSObject
- (XXAttributedStringChain *(^)(NSString *text))text;
- (NSAttributedString *)install;
@end

@interface XXAttributedStringChain : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableAttributedString *> *attributedStrings;
- (XXAttributedStringChain *(^)(UIColor *color))foregroundColor;
- (XXAttributedStringChain *(^)(UIColor *color))backgroundColor;
- (XXAttributedStringChain *(^)(UIFont *font))font;
- (XXAttributedStringChain *(^)(NSUnderlineStyle style))underline;
- (XXAttributedStringChain *(^)(UIColor *color))underlineColor;
- (XXAttributedStringChain *(^)(CGFloat offset))baseline;
- (XXAttributedStringChain *(^)(NSUnderlineStyle style))strike;
- (XXAttributedStringChain *(^)(UIColor *color))strikeColor;
- (XXAttributedStringChain *(^)(NSParagraphStyle *style))paragraphStyle;
- (XXAttributedStringChain *(^)(NSString *link))link;
- (void)buildSubAttributedString;
@end

NS_ASSUME_NONNULL_END
