//
//  XXCollectionViewLayout.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/25.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXCollectionViewLayout.h"

@implementation XXCollectionViewLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获得super已经计算好的布局属性（在super已经算好的基础上，再去做一些改进）
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 在原有布局属性的基础上进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // cell的中心点x和collectionView最中心点的x值 的间距
        CGFloat delta = ABS(attrs.center.x - centerX);
        
        // 根据间距值计算cell的缩放比例
        CGFloat scale = 1 - delta / self.collectionView.frame.size.width;
        
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

/*
 这个方法在你手离开屏幕之前会调用，也就是cell即将停止滚动的时候 （记住这一点）
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    // 修改原有的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}
@end
