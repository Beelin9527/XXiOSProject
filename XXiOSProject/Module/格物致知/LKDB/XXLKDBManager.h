//
//  XXLKDBManager.h
//  XXiOSProject
//
//  Created by Beelin on 2017/12/23.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LKDBHelper.h"
@interface XXLKDBManager : NSObject
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) LKDBHelper *dbHelper;
@end
