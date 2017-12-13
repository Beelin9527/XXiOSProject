//
//  XXGuideController.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/11.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXGuideController.h"

#define M_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define M_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define M_RGB_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define M_COLOR_MAIN M_RGB_COLOR(69,223, 167)

@interface XXGuideController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *openFireButton;

@property (strong, nonatomic) NSMutableArray *imvs;
@property (strong, nonatomic) NSArray *imageNames;
@end

@implementation XXGuideController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupImageNames];
    [self layoutSubView];
}

- (void)setupImageNames {
    //设置图片资源
    self.imageNames = @[@"guide_1", @"guide_2", @"guide_3"];
}

- (void)layoutSubView {
    for (int i = 0; i < self.imageNames.count; i ++) {
        UIImageView *imv = [[UIImageView alloc] init];
        imv.frame = [UIScreen mainScreen].bounds;
        imv.image = [UIImage imageNamed:[self.imageNames objectAtIndex:i]];
        [self.imvs addObject:imv];
        
        if (i == 0) {
            [self.view addSubview:imv];
        } else {
            UIImageView *lastImv = [self.imvs objectAtIndex:i-1];
            [self.view insertSubview:imv belowSubview:lastImv];
        }
    }
    
    UIImageView *firstImv = [self.imvs objectAtIndex:0];
    [self.view insertSubview:self.scrollView aboveSubview:firstImv];
    [self.view insertSubview:self.pageControl aboveSubview:self.scrollView];
    
    [self.scrollView addSubview:self.openFireButton];
    self.openFireButton.center = CGPointMake(M_SCREEN_WIDTH * self.imageNames.count - M_SCREEN_WIDTH * 0.5, M_SCREEN_HEIGHT - 100);
}

#pragma mark - Private Method
- (void)calculateImagesAlphaWithPoint:(CGFloat)pointX {
    static CGFloat imgEnd = 0;
    static NSInteger currentIdx = 0;
    static UIImageView *imv = nil;
    
    imgEnd = M_SCREEN_WIDTH;
    currentIdx = (NSInteger)pointX / imgEnd;
    self.pageControl.currentPage = currentIdx;
    CGFloat currentX = pointX - imgEnd*currentIdx ;
    imv = [self.imvs objectAtIndex:currentIdx];
    imv.alpha = 1 - currentX / imgEnd;
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self calculateImagesAlphaWithPoint:scrollView.contentOffset.x];
}

#pragma mark - Event
- (void)openFireAction {
   /*
    set up key window the root view controller
    XX *c = [[XX alloc] init];
    [[UIApplication sharedApplication].keyWindow setRootViewController:c];
    */
}

#pragma mark - Getter
- (UIButton *)openFireButton {
    if (!_openFireButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 100, 30);
        NSMutableDictionary *attrsDictionary = [NSMutableDictionary dictionaryWithObject:
                                                [UIFont systemFontOfSize:20]
                                                                                  forKey:NSFontAttributeName];
        [attrsDictionary setObject:M_COLOR_MAIN forKey:NSForegroundColorAttributeName];
        NSAttributedString *titleStr = [[NSAttributedString alloc] initWithString:@"立即体验" attributes:attrsDictionary];
        [button setAttributedTitle:titleStr forState:UIControlStateNormal];
        button.layer.cornerRadius = 65 * 0.25;
        button.layer.borderWidth = 1;
        button.layer.borderColor = M_COLOR_MAIN.CGColor;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(openFireAction) forControlEvents:UIControlEventTouchUpInside];
        
        _openFireButton = button;
    }
    return _openFireButton;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.imageNames.count, [UIScreen mainScreen].bounds.size.height);
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        pageControl.numberOfPages = self.imageNames.count;
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPageIndicatorTintColor = M_COLOR_MAIN;
        [pageControl sizeToFit];
        pageControl.center = CGPointMake(M_SCREEN_WIDTH / 2.0,M_SCREEN_HEIGHT - 50);
        
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (NSMutableArray *)imvs {
    if (!_imvs) {
        _imvs = @[].mutableCopy;
    }
    return _imvs;
}

@end


