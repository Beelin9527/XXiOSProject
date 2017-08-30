//
//  XXBannerView.h
//  XXiOSProject
//
//  Created by Beelin on 2017/8/29.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXPageControl;
@protocol XXBannerViewDelegate;

/*
 注：自定义page control 的圆点，设置image属性
 默认系统page control的圆点，设置color属性
 */
@interface XXBannerView : UIView
/** 默认 page control 图片 */
@property (nonatomic, strong) UIImage *pageIndicatorImage;
/** 当前 page control 图片 */
@property (nonatomic, strong) UIImage *currentPageIndicatorImage;

/** 默认 page control 颜色 */
@property(nonatomic,strong) UIColor *pageIndicatorTintColor;
/** 当前 page control 颜色 */
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;

/** delegate */
@property (nonatomic, weak) id<XXBannerViewDelegate> delegate;
@end


@interface XXPageControl : UIPageControl
/** 当前 page control 图片 */
@property (nonatomic, strong) UIImage *currentImage;

/** 默认 page control 图片 */
@property (nonatomic, strong) UIImage *defaultImage;
@end


@interface XXBannerModel : NSObject
/** 链接 */
@property (nonatomic, copy) NSString *linkUrl;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 图片url */
@property (nonatomic, copy) NSString *imageUrl;
/** 本地image */
@property (nonatomic, strong) UIImage *image;

@end


@protocol XXBannerViewDelegate <NSObject>
@required
/**
 数据源代理
 @return    XXBannerModel数组
 */
- (NSArray <XXBannerModel *>*)bannerViewDataSource;

/**
 通过此代理实现图片方案
 方案1：image赋值，加载本地资源图片 如下:
 imagView.image = image;
 
 方案2：imageUrl赋值,通过第三方SDWebImage下载 如下：
 [imageView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
 
 @param imageView   图片容器
 @param image       本地图片
 @param imageUrl    图片链接
 */
- (void)bannerViewDownLoadWithImageView:(UIImageView *)imageView image:(UIImage *)image imageUrl:(NSString *)imageUrl;

@optional
/**
 点击事件代理
 @param linkUrl 点击事件的链接
 @param title   标题
 */
- (void)bannerViewDidSelectIndexLinkUrl:(NSString *)linkUrl title:(NSString *)title;
@end

