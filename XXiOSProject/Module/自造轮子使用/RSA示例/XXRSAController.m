//
//  XXRSAController.m
//  XXiOSProject
//
//  Created by Beelin on 2018/2/2.
//  Copyright © 2018年 xx. All rights reserved.
//

#import "XXRSAController.h"
#import "XXRSAManager.h"

@interface XXRSAController ()

@end

@implementation XXRSAController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [XXRSAManager.sharedManager savePublicKey:@"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2TON2Tdfq+VOTrE8Dg4SECaB/JxDUTRkGnTWkB8xLz/+9rwFl265c+Kpw+K6blEmiHXXWgV1BzuNiCIhDHYG8Mr3a/A9onx4xRDujtDyBK1YssErHsybDPpJGH5+IVc0Luo82Wx43RuLQyiYLt3inTbMaZBak9vnwx/ZbsVT8p9/igDFFV1HvxW83NJdt1fYf54g42ePFOVzsKlnJUbIDv6wPsmtMI+DzcGQNAQSv7V5zGZgsNsE4gIWoyPI0ML+8jCFDkudMLEHpscHfdYADKOha3NhDhHe4qDvL2a3vX9p0vLhw2y9WlS9YDYdsQU0+JAjq0QqLs8FHil3DBQT0QIDAQAB"];
    NSString *str = [XXRSAManager.sharedManager encryptPublicKeyWithInfoString:@"123456"];
    NSLog(@"%@", str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
