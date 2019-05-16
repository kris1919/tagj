//
//  FFBannerFlowLayout.m
//  BannerView
//
//  Created by tsfa on 2018/4/10.
//  Copyright © 2018年 tsfa. All rights reserved.
//

#import "FFBannerFlowLayout.h"

@implementation FFBannerFlowLayout

//-(void)prepareLayout{
//    [super prepareLayout];
//
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.minimumLineSpacing = 0;
//    self.minimumInteritemSpacing = 0;
//
//    CGFloat margin = (self.collectionView.frame.size.width - self.itemSize.width) / 2;
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, margin, 0, margin);
//}
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    return YES;
//}
//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
//    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
//    CGFloat ceterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
//    for (UICollectionViewLayoutAttributes *att in attributes) {
//        CGFloat delta = ABS(att.center.x - ceterX);
//        CGFloat scale = 1.1 - delta / self.collectionView.frame.size.width;
//        att.transform = CGAffineTransformMakeScale(scale, scale);
//    }
//    return attributes;
//}
///**
// * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
// */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
//    // 计算出最终显示的矩形框
//    CGRect rect;
//    rect.origin.y = 0;
//    rect.origin.x = proposedContentOffset.x;
//    rect.size = self.collectionView.frame.size;
//
//    //获得super已经计算好的布局的属性
//    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
//
//    //计算collectionView最中心点的x值
//    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
//
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attrs in arr) {
//        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
//            minDelta = attrs.center.x - centerX;
//        }
//    }
//    proposedContentOffset.x += minDelta;
//    return proposedContentOffset;
//}
@end
