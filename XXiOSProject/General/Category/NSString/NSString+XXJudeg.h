//
//  NSString+XXJudeg.h
//  XXCategory
//
//  Created by Beelin on 17/8/1.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XXJudeg)
/** 判断字符串是否为空 */
- (BOOL)xx_isEmpty;

/** 判断字符串是否是手机号 */
- (BOOL)xx_isMobilePhone;

/** 判断字符串是否是固定电话 */
- (BOOL)xx_isTelephone;

/** 判断字符串是否是邮箱 */
- (BOOL)xx_isEmail;
@end
