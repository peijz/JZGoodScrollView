//
//  JZGoodScrollViewCell.m
//  JZGoodScrollView
//
//  Created by wanhongios on 17/1/10.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "JZGoodScrollViewCell.h"

@implementation JZGoodScrollViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加图像到视图
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:imageView];
        self.m_imageView = imageView;
    }
    return self;
}


@end
