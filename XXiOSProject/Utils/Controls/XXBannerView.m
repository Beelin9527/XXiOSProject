//
//  XXBannerView.m
//  XXiOSProject
//
//  Created by Beelin on 2017/8/29.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXBannerView.h"

const CGFloat kPadding = 10; //差值

@interface XXBannerView() <UIScrollViewDelegate>
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (nonatomic, strong) XXPageControl *pageControl;

/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign) CGFloat bannerWidth;
@property (nonatomic, assign) CGFloat bannerHeight;

@property (nonatomic, strong) NSArray <XXBannerModel *>*dataSource;

@end


@implementation XXBannerView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bannerWidth = frame.size.width;
        _bannerHeight = frame.size.height;
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        // 开启定时器
        [self startTimer];
        
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > ((self.dataSource.count-1)*self.bannerWidth - kPadding)) {
        [scrollView setContentOffset:CGPointMake(self.bannerWidth, 0) animated:NO];
    } else if (scrollView.contentOffset.x < kPadding){
        [scrollView setContentOffset:CGPointMake(((self.dataSource.count-2)*self.bannerWidth), 0) animated:NO];
    }
    self.pageControl.currentPage = (scrollView.contentOffset.x + self.bannerWidth*.5)/self.bannerWidth - 1;
}

/**
 *  当用户即将开始拖拽scrollView时，停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 *  当用户已经结束拖拽scrollView时，开启定时器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark - TimerMethod
- (void)startTimer
{
    // 返回一个自动开始执行任务的定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    
    // 修改NSTimer在NSRunLoop中的模式：NSRunLoopCommonModes
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  显示下一页
 */
- (void)nextPage:(NSTimer *)timer
{
    int x =  self.scrollView.contentOffset.x/self.bannerWidth;
    x++;
    if (x > self.dataSource.count) {
        x = 1;
        [self.scrollView setContentOffset:CGPointMake(self.bannerWidth * x, 0) animated:NO];
    }
    [self.scrollView setContentOffset:CGPointMake(self.bannerWidth * x, 0) animated:YES];
}

#pragma mark - EventResponser
- (void)tapContent:(UITapGestureRecognizer *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerViewDidSelectIndexLinkUrl:title:)]) {
        XXBannerModel *model = self.dataSource[sender.view.tag];
        [self.delegate bannerViewDidSelectIndexLinkUrl:model.linkUrl title:model.title];
    }
}

#pragma mark - Setter
/** 通过重写代理方法，触发bannerViewDataSource代理，获取数据源 */
- (void)setDelegate:(id)delegate {
    if (!delegate) return;
    
    _delegate = delegate;
    if ([_delegate respondsToSelector:@selector(bannerViewDataSource)]) {
        self.dataSource = [_delegate bannerViewDataSource];
    }
}

- (void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage {
    _currentPageIndicatorImage = currentPageIndicatorImage;
    _pageControl.currentImage = _currentPageIndicatorImage;
}

- (void)setPageIndicatorImage:(UIImage *)pageIndicatorImage {
    _pageIndicatorImage = pageIndicatorImage;
    _pageControl.defaultImage = _pageIndicatorImage;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    _pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    _pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
}
/**
 *  根据图片名数据做一些操作
 */
- (void)setDataSource:(NSArray *)dataSource {
    // 判空
    if (dataSource.count == 0) return;
    
    NSMutableArray *mDataSource = [dataSource mutableCopy];
    // 复制最后一个对象插入第0下标
    [mDataSource insertObject:[mDataSource lastObject] atIndex:0];
    // 复制第一个对象插入最后下标
    [mDataSource addObject:mDataSource[1]];
    
    _dataSource = mDataSource.copy;
    
    // 先移除所有的imageView
    // 让self.scrollView.subviews数组中的所有对象都执行removeFromSuperview方法
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 根据图片名数据创建对应的imageView
    [_dataSource enumerateObjectsUsingBlock:^(XXBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(idx * self.bannerWidth, 0, self.bannerWidth, self.bannerHeight);
        imageView.tag = idx;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        //代理实现图片下载，内部不依赖SDWebImage
        if (self.delegate && [self.delegate respondsToSelector:@selector(bannerViewDownLoadWithImageView:image:imageUrl:)]) {
            [self.delegate bannerViewDownLoadWithImageView:imageView image:obj.image imageUrl:obj.imageUrl];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContent:)];
        [imageView addGestureRecognizer:tap];
    }];
    
    // 设置总页数
    self.pageControl.numberOfPages = _dataSource.count - 2;
    
    // 设置scrollView的contentSize
    [self.scrollView setContentSize:CGSizeMake(_dataSource.count * self.bannerWidth, self.bannerHeight)];
    //设置初始滑动到实际的第一张图位置
    [self.scrollView setContentOffset:CGPointMake(self.bannerWidth, 0) animated:YES];
}

#pragma mark - Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (XXPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[XXPageControl alloc] initWithFrame:CGRectMake(0, self.bannerHeight - 30, self.bannerWidth, 30)];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}

@end



@implementation XXPageControl
/**
 重写currentPage方法，添加自定义UIImageView，通过currentImage与defaultImage显示样式
 */
- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    
    //判断currentImage与defaultImage是否有值，无值reture
    if (!self.currentImage || !self.defaultImage) return;
    
    for (int i=0; i<[self.subviews count]; i++) {
        //圆点
        UIView* dot = [self.subviews objectAtIndex:i];
        dot.backgroundColor = [UIColor clearColor];
        //添加imageView
        if ([dot.subviews count] == 0) {
            UIImageView * imv = [[UIImageView alloc]initWithFrame:dot.bounds];
            imv.contentMode = UIViewContentModeCenter;
            [dot addSubview:imv];
        };
        
        //配置imageView
        UIImageView *imv = dot.subviews[0];
        
        if (i == self.currentPage) {
            imv.image=self.currentImage;
        }else {
            imv.image=self.defaultImage;
        }
    }
    
}
@end


@implementation XXBannerModel
@end
