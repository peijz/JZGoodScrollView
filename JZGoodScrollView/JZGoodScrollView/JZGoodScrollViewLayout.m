//
//  JZGoodScrollViewLayout.m
//  JZGoodScrollView
//
//  Created by wanhongios on 17/1/10.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "JZGoodScrollViewLayout.h"

@implementation JZGoodScrollViewLayout
-(void)prepareLayout
{
    [super prepareLayout];
    
    // 直接利用collectionview的属性设置布局
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}
@end
