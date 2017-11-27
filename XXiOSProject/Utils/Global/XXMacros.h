//
//  XXMacros.h
//  XXiOSProject
//
//  Created by Beelin on 17/6/14.
//  Copyright © 2017年 xx. All rights reserved.
//

#ifndef XXMacros_h
#define XXMacros_h

#pragma mark - frame
/** 屏幕宽度 **/
#define M_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/** 屏幕高度 **/
#define M_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/** 顶部栏高度 **/
#define  M_TOPBAR_HEIGHT 64

/** 顶部栏高度 **/
#define  M_TARBAR_HEIGHT 49

// 计算自适应高度
#define  M_RECT_HEIGHT(number)         (Screen_Width / 375.0) * number


#pragma mark - Device
//是否为IOS7及以上
#define IOS7ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f ? YES : NO)

//是否为IOS8及以上
#define IOS8ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f ? YES : NO)

//是否为Iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//是否为iPhone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//是否为iPhone6 Plus
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)


#pragma mark - Color
// RGB色
#define M_RGB_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define M_RGB_COLOR_APLPHA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机色
#define M_RANDOM_COLOR M_RGB_COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//十六进制转RGB色
#define M_COLOR_TO_RGB(Value) M_COLOR_TO_RGB_WITH_ALPHA(rgbValue, 1.0f)
#define M_COLOR_TO_RGB_WITH_ALPHA(rgbValue, alpha1) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha1]

//主调色
#define M_COLOR_MAIN M_RGB_COLOR(69,223, 167)
//背景色
#define M_COLOR_BACKGROUND M_RGB_COLOR(245,245, 245)
//分割线色
#define M_COLOR_SEPRATOR M_RGB_COLOR(221,221, 221)

//正常文本色
#define M_COLOR_BODY M_RGB_COLOR(51,51, 51)
//内容文本色
#define M_COLOR_CONTENT M_RGB_COLOR(102,102, 102)
//次要辅助色
#define M_COLOR_SECONDARY M_RGB_COLOR(153,153, 153)
//按钮高亮色
#define M_COLOR_HIGHLIGHT M_RGB_COLOR(60,93, 161)


#pragma mark - Font
//正常大小
#define M_FONT_TITLE [UIFont systemFontOfSize:17]            //文章标题、输入文字
#define M_FONT_CONTENT [UIFont systemFontOfSize:14]         //一般字号，文章正文
#define M_FONT_FOOTNOTE [UIFont systemFontOfSize:12]        //注释文字，解释说明


#pragma mark - Othor
//获取沙盒 Document
#define M_PATH_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Libaray目录的Cache
#define M_PATH_CACHE [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//获取泥沙盒 tmp
#define M_PATH_TMP NSTemporaryDirectory();


// 字符串是否为空
#define M_STRING_IS_EMPTY(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#define M_ARRAY_IS_EMPTY(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#define M_DICT_IS_EMPTY(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
// 是否是空对象
#define M_OBJECT_IS_EMPTY(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


//弱引用/强引用  可配对引用在外面用WeakSelf(self)，block用StrongSelf(self)  也可以单独引用在外面用WeakSelf(self) block里面用weakself
#define M_WEAK_SELF(type)  __weak typeof(type) weak##type = type;
#define M_STRONG_SELF(type)  __strong typeof(type) type = weak##type;
#endif /* XXMacros_h */
