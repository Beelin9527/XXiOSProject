//
//  XXRSAManager.h
//  XXiOSProject
//
//  Created by Beelin on 2018/2/2.
//  Copyright © 2018年 xx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXRSAManager : NSObject
+ (instancetype)sharedManager;

/**
 *  存储publicKey到本地
 *
 *  @param publicKey 公钥
 *
 *  @return 是否存储成功
 */
- (BOOL)savePublicKey:(NSString *)publicKey;

/**
 *  用公钥对信息进行加密
 *
 *  @param string 要加密的的信息
 *
 *  @return base64后的信息
 */
- (NSString *)encryptPublicKeyWithInfoString:(NSString *)string;

@end
