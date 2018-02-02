//
//  XXRSAManager.m
//  XXiOSProject
//
//  Created by Beelin on 2018/2/2.
//  Copyright © 2018年 xx. All rights reserved.
//

#import "XXRSAManager.h"
#import "RSA.h"

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
    [[NSUserDefaults standardUserDefaults] setObject:publicKey forKey:@"publicKey"];
    return YES;
    
}

- (NSString *)encryptPublicKeyWithInfoString:(NSString *)string {
    NSString *publicKey =  [[NSUserDefaults standardUserDefaults] objectForKey:@"publicKey"];
    return [RSA encryptString:string publicKey:publicKey];
}
@end
