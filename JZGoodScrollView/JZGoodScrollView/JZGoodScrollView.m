//
//  JZGoodScrollView.m
//  JZGoodScrollView
//
//  Created by wanhongios on 17/1/9.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "JZGoodScrollView.h"
#import "JZGoodScrollViewLayout.h"
#import "JZGoodScrollViewCell.h"
#import "UIImageView+WebCache.h"
NSString * const JZGoodScrollViewId = @"JZGoodScrollViewId";
@interface JZGoodScrollView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) JZGoodScrollViewClickBlock didSelectedBlock;
@property(nonatomic,strong) JZGoodScrollViewClickBlock stopBlock;

@property (nonatomic, weak) UIImageView *backgroundImageView; // 当imageURLs为空时的背景图
@end

@implementation JZGoodScrollView{
    NSArray <NSURL *> *_urls;
    UICollectionView *_jzCollectionView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    JZGoodScrollViewLayout *_jzLayout;
}

- (instancetype)initWithFrame:(CGRect)frame urls:(NSArray *)urls  placeHolderImage:(UIImage *)placeHolderImage
{
    self = [super initWithFrame:frame];
    if (self) { 
        _urls = urls.count ? urls : @[];
        if (_urls.count>0)
        {
            // 设置collectionview
            [self setupCollectionView];
            // 打开定时器
            [self sutupTimer];
            // 设置pageControl
            [self setupPageControl];
        }
        if (placeHolderImage) {
            self.placeholderImage = placeHolderImage;
        }
    }
    return self;
}


- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    
    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:bgImageView belowSubview:_jzCollectionView];
        self.backgroundImageView = bgImageView;
    }
    
    self.backgroundImageView.image = placeholderImage;
}


// collectionView
-(void)setupCollectionView
{
    // 定时器的时间 默认3s
    self.autoScrollTimeInterval = 3.0;
    _jzLayout = [[JZGoodScrollViewLayout alloc]init];
    _jzCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_jzLayout];
    _jzCollectionView.dataSource = self;
    _jzCollectionView.delegate = self;
    [_jzCollectionView registerClass:[JZGoodScrollViewCell class] forCellWithReuseIdentifier:JZGoodScrollViewId];
    [self addSubview:_jzCollectionView];
    
    // 主队列
    // 1 安排任务在主线程上执行
    // 2 如果主线程当前有任务，主队列暂时不调度任务
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
        // 滚动位置
        [_jzCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
    });
}


// page Control

-(void)setupPageControl
{
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.numberOfPages = _urls.count;
    [self addSubview:_pageControl];
}


// 定时器方法
-(void)timerAction
{
    int currentIndex = [self currentIndex]%_urls.count;
    int targetIndex = currentIndex + 1;
    _pageControl.currentPage = currentIndex;
    [self scrollToIndex:targetIndex];

}

- (void)scrollToIndex:(int)targetIndex
{
    [_jzCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


- (int)currentIndex
{
    if (_jzCollectionView.bounds.size.width == 0 || _jzCollectionView.bounds.size.height == 0) {
        return 0;
    }
    
    int index = 0;
    if (_jzLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_jzCollectionView.contentOffset.x + _jzLayout.itemSize.width * 0.5) / _jzLayout.itemSize.width;
    } else {
        index = (_jzCollectionView.contentOffset.y + _jzLayout.itemSize.height * 0.5) / _jzLayout.itemSize.height;
    }
    
    return MAX(0, index);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize pageSize = [_pageControl sizeForNumberOfPages:_urls.count];
    
    CGFloat pageControlW = pageSize.width;
    CGFloat pageControlH = pageSize.height;
    CGFloat pageControlX = (self.bounds.size.width - pageControlW)/2;
    CGFloat pageControlY = self.bounds.size.height - pageControlH;
    _pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
}

// pageControl是否显示
-(void)setPageShow:(BOOL)pageShow
{
    _pageShow = pageShow;
    if (pageShow) {
        _pageControl.hidden = NO;
    }
    else{
        _pageControl.hidden = YES;
    }
    
}


// 当前分页控件小圆标颜色

-(void)setCurrentPageColor:(UIColor *)currentPageColor
{
    _currentPageColor = currentPageColor;
    _pageControl.currentPageIndicatorTintColor = currentPageColor;
}

// 其他分页控件小圆标颜色
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
    
}

// 图片的url数组
-(void)setJzUrls:(NSArray *)jzUrls
{
    _jzUrls = jzUrls;

    if (jzUrls.count>0){
        _urls = @[];
        _urls = jzUrls;
        // 设置collectionview
        [self setupCollectionView];
        // 打开定时器
        [self sutupTimer];
        // 设置pageControl
        [self setupPageControl];
    }
    
    
}


#pragma mark - 数据源方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_urls.count>0) {
        return _urls.count * 100;
    }
    else{
        return  0;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JZGoodScrollViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:JZGoodScrollViewId forIndexPath:indexPath];
    if (_urls.count>0) {
        
        if (self.placeholderImage) {
            [cell.m_imageView sd_setImageWithURL:_urls[indexPath.item%_urls.count] placeholderImage:self.placeholderImage];
        }
        else{
            [cell.m_imageView sd_setImageWithURL:_urls[indexPath.item%_urls.count] placeholderImage:nil];
        }
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_didSelectedBlock) {
        _didSelectedBlock([self pageWithNum:indexPath.item]);
    }
}

#pragma mark - 代理方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = [self currentIndex];
    
    // 第0页跳转到最后一页  ，  最好一页跳转到第0页
    if (index == 0 || index == ([_jzCollectionView numberOfItemsInSection:0]-1)) {
        // 第0页
        if (index == 0) {
            index = _urls.count;
        }
        else{
            index = _urls.count - 1;
        }
        // 重新调整 contentoffset
        scrollView.contentOffset = CGPointMake(index*scrollView.bounds.size.width, 0);
    }
    if (_stopBlock) {
        _stopBlock([self pageWithNum:index]);
    }
    _pageControl.currentPage = [self pageWithNum:index];
}


-(NSInteger)pageWithNum:(NSInteger)num
{
    return num%_urls.count;
}

#pragma mark - 点击回调
-(void)goodScrollViewDidSelectedBlock:(JZGoodScrollViewClickBlock)didSelectedBlock
{
    _didSelectedBlock = didSelectedBlock;
}
#pragma mark - 停留回调
-(void)goodScrollViewStopBlock:(JZGoodScrollViewClickBlock)stopBlock
{
    _stopBlock = stopBlock;
}

#pragma mark - 定时器方法

// 设置定时器
- (void)sutupTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}
// 永久关闭定时器
- (void)invalidateTimer
{
    if (_timer.isValid) {
        [_timer invalidate];
    }
    _timer = nil;
    
}

// 暂时关闭定时器
-(void)stopTimer
{
    [_timer setFireDate:[NSDate distantFuture]];
}

// 开启定时器
-(void)startTimer
{
    [_timer setFireDate:[NSDate distantPast]];
}

-(void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    [self stopTimer];
    if (autoScroll) {
        [self startTimer];
        
    }
    else
    {
        [self stopTimer];
        
    }
    [_jzCollectionView reloadData];
    
}


- (void)dealloc
{
    [self invalidateTimer];
}

@end
