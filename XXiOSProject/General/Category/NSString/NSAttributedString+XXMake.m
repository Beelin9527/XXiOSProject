//
//  NSAttributedString+XXMake.m
//  XXiOSProject
//
//  Created by Beelin on 2019/1/31.
//  Copyright © 2019 xx. All rights reserved.
//

#import "NSAttributedString+XXMake.h"

@implementation NSAttributedString (XXMake)

+ (NSAttributedString *)makeAttributedString:(void (^)(XXAttributedStringMaker * _Nonnull))block {
    XXAttributedStringMaker *make = [[XXAttributedStringMaker alloc] init];
    block(make);
    return [make install];
}

@end

@interface XXAttributedStringMaker ()
@property (nonatomic, strong) XXAttributedStringChain *chain;
@end

@implementation XXAttributedStringMaker

- (XXAttributedStringChain * (^)(NSString *))text {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *text) {
        NSAssert(text.length, @"The text's length cannot be 0.");
        __strong typeof(self) self = weakSelf;
        self.chain.text = text;
        [self.chain buildSubAttributedString];
        return self.chain;
    };
}

- (NSAttributedString *)install {
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
    NSArray<NSMutableAttributedString *> *attributedStrings = self.chain.attributedStrings.copy;
    for (NSMutableAttributedString *attributedString in attributedStrings) {
        [mutableAttributedString appendAttributedString:attributedString.copy];
    }
    return mutableAttributedString.copy;
}

- (XXAttributedStringChain *)chain {
    if (!_chain) {
        _chain = [[XXAttributedStringChain alloc] init];
    }
    return _chain;
}

@end

@interface XXAttributedStringChain ()
@property (nonatomic, strong) NSMutableArray<NSMutableAttributedString *> *attributedStrings;
@property (nonatomic, strong) NSMutableAttributedString *currentAttributedString;
@end

@implementation XXAttributedStringChain

- (XXAttributedStringChain * (^)(UIColor *))foregroundColor {
    return ^id(UIColor *color) {
        return [self addAttribute:NSForegroundColorAttributeName value:color];
    };
}

- (XXAttributedStringChain * (^)(UIColor *))backgroundColor {
    return ^id(UIColor *color) {
        return [self addAttribute:NSBackgroundColorAttributeName value:color];
    };
}

- (XXAttributedStringChain * (^)(UIFont *))font {
    return ^id(UIFont *font) {
        return [self addAttribute:NSFontAttributeName value:font];
    };
}

- (XXAttributedStringChain * (^)(NSUnderlineStyle))underline {
    return ^id(NSUnderlineStyle style) {
        return [self addAttribute:NSUnderlineStyleAttributeName value:@(style)];
    };
}

- (XXAttributedStringChain * (^)(UIColor *))underlineColor {
    return ^id(UIColor *color) {
        return [self addAttribute:NSUnderlineColorAttributeName value:color];
    };
}

- (XXAttributedStringChain * (^)(CGFloat))baseline {
    return ^id(CGFloat offset) {
        return [self addAttribute:NSBaselineOffsetAttributeName value:@(offset)];
    };
}

- (XXAttributedStringChain * (^)(NSUnderlineStyle))strike {
    return ^id(NSUnderlineStyle style) {
        return [self addAttribute:NSStrikethroughStyleAttributeName value:@(style)];
    };
}

- (XXAttributedStringChain * (^)(UIColor *))strikeColor {
    return ^id(UIColor *color) {
        return [self addAttribute:NSStrikethroughColorAttributeName value:color];
    };
}

- (XXAttributedStringChain * (^)(NSParagraphStyle *))paragraphStyle {
    return ^id(NSParagraphStyle *style) {
        return [self addAttribute:NSParagraphStyleAttributeName value:style];
    };
}

- (XXAttributedStringChain * _Nonnull (^)(NSString * _Nonnull))link {
    return ^id(NSString *link) {
        return [self addAttribute:NSLinkAttributeName value:link];
    };
}

- (XXAttributedStringChain *)addAttribute:(NSAttributedStringKey)key value:(id)value {
    [self.currentAttributedString addAttribute:key value:value range:NSMakeRange(0, self.text.length)];
    return self;
}

- (void)buildSubAttributedString {
    if (!self.text) { return; }
    self.currentAttributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [self.attributedStrings addObject:self.currentAttributedString];
}

- (NSMutableArray<NSMutableAttributedString *> *)attributedStrings {
    if (!_attributedStrings) {
        _attributedStrings = [NSMutableArray array];
    }
    return _attributedStrings;
}

@end
