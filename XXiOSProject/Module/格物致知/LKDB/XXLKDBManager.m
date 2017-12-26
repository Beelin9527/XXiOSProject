//
//  XXLKDBManager.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/23.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXLKDBManager.h"

@implementation XXLKDBManager
- (NSString *)filePath
{
    if (!_filePath)
    {
        // document目录下
        NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *document = [documentArray objectAtIndex:0];
        _filePath = [document stringByAppendingPathComponent:@"SQLDB"];
    }
    
    NSLog(@"filePath %@", _filePath);
    
    return _filePath;
}

- (LKDBHelper *)dbHelper
{
    if (!_dbHelper)
    {
        _dbHelper = [[LKDBHelper alloc] initWithDBPath:self.filePath];
        
        [_dbHelper dropAllTable];
    }
    
    return _dbHelper;
}
@end
