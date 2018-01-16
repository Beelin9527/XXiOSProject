//
//  XXAuthorizationStatusManager.h
//  XXCommunityCenter
//
//  Created by Beelin on 17/4/13.
//  Copyright © 2017年 com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XXAuthorizationType) {
    XXAuthorizationTypeAlbum, //相册类型
    XXAuthorizationTypeVideo, //视频、拍照类型
    XXAuthorizationTypeAudio,  //语音类型
    XXAuthorizationTypeMap  //地图类型
};
@interface XXAuthorizationStatusManager : NSObject

/**
 弹框
 @param type 类型
 @param target 弹框控制器
 */
+ (void)authorizationType:(XXAuthorizationType)type target:(UIViewController *)target;


/** 很单纯的检测权限 不弹框，可根据返回值自定义逻辑*/
+ (BOOL)authorizationStatusMediaTypeAlbumIsOpen;
+ (BOOL)authorizationStatusMediaTypeVideoIsOpen;
+ (BOOL)authorizationStatusMediaTypeAudioIsOpen;
+ (BOOL)authorizationStatusMediaTypeMapIsOpen;
@end
