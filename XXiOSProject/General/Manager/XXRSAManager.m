//
//  XXRSAManager.m
//  XXiOSProject
//
//  Created by Beelin on 2018/2/2.
//  Copyright © 2018年 xx. All rights reserved.
//

#import "XXRSAManager.h"
#import "RSA.h"

#define DocumentsDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define RSAPublicKeyPath [DocumentsDir stringByAppendingPathComponent:@"publicKey"]

#define M_PATH_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define M_PATH_USERINFO [M_PATH_DOCUMENT stringByAppendingPathComponent:@"userInfo"]

@implementation XXRSAManager
{
    RSA *_rsaPublic;
}


+ (instancetype)sharedManager
{
    static XXRSAManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return  instance;
}


- (BOOL)savePublicKey:(NSString *)publicKey {
    NSString *publicKeyStr = publicKey;
    NSMutableString *result = [NSMutableString string];
    [result appendString:@"-----BEGIN PUBLIC KEY-----\n"];
    int count = 0;
    for (int i = 0; i < [publicKeyStr length]; ++i) {
        unichar c = [publicKeyStr characterAtIndex:i];
        if (c == '\n' || c == '\r') {
            continue;
        }
        [result appendFormat:@"%c", c];
        if (++count == 64) {
            [result appendString:@"\n"];
            count = 0;
        }
    }
    [result appendString:@"\n-----END PUBLIC KEY-----"];

    [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"publicKey"];
    
   
    return YES;
    
}

- (NSString *)encryptPublicKeyWithInfoString:(NSString *)string {
    NSString *publicKey =  [[NSUserDefaults standardUserDefaults] objectForKey:@"publicKey"];
    return [RSA encryptString:string publicKey:publicKey];
}
@end
