//
//  DPCollectionFlowLayout.m
//  DPCyclePageDemo
//
//  Created by 朱力珅 on 2018/7/12.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "DPCollectionFlowLayout.h"

@implementation DPCollectionFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //取出父类算出的布局属性
    NSArray *attsArray = [super layoutAttributesForElementsInRect:rect];
    //屏幕中心点对应于collectionView中content位置
    CGFloat centerX = self.collectionView.bounds.size.width / 2 + self.collectionView.contentOffset.x;
    //cell中的item一个个取出来进行更改
    for (UICollectionViewLayoutAttributes *atts in attsArray) {
        NSLog(@"%f",atts.center.x);
        // cell的中心点x 和 屏幕中心点 的距离
        CGFloat space = ABS(atts.center.x - centerX);
        CGFloat scale = 1 - (space / self.collectionView.frame.size.width / 2);
        atts.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attsArray;
}

@end
