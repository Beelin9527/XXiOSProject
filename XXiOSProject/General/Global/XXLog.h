//
//  XXLog.h
//  XXiOSProject
//
//  Created by Beelin on 2017/12/20.
//  Copyright © 2017年 xx. All rights reserved.
//

#ifndef XXLog_h
#define XXLog_h

#ifdef DEBUG
# define XXLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define XXLog(...);
#endif

#endif /* XXLog_h */
