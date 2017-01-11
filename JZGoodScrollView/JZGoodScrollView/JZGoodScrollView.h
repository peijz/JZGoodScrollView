//
//  JZGoodScrollView.h
//  JZGoodScrollView
//
//  Created by wanhongios on 17/1/9.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import <UIKit/UIKit.h>
// 点击图片的block
typedef void (^JZGoodScrollViewClickBlock)(NSInteger index);
// 停留在第几张图片
typedef void (^JZGoodScrollViewStopBlock)(NSInteger index);
@interface JZGoodScrollView : UIView
- (instancetype)initWithFrame:(CGRect)frame urls:(NSArray *)urls placeHolderImage:(UIImage *)placeHolderImage;

/** * 是否显示pagecontrol  默认是yes */
@property(nonatomic,assign) BOOL pageShow;

/** * 当前分页控件小圆标颜色 默认 white */
@property(nonatomic,strong) UIColor * currentPageColor;
/** 其他分页控件小圆标颜色 默认 lightgray */
@property(nonatomic,strong) UIColor * pageIndicatorTintColor;
/** * 是否自动滚动 默认为yes */
@property(nonatomic,assign) BOOL autoScroll;

/** * 自动滚动的时间间隔 默认3秒 */
@property(nonatomic,assign) NSTimeInterval autoScrollTimeInterval;

/** * 图片的Url数组 */
@property(nonatomic,strong) NSArray * jzUrls;

/** * 占位图 */
@property(nonatomic,strong) UIImage * placeholderImage;


/** * 开启定时器 */
- (void)startTimer;

/** * 暂时定时器 */
-(void)stopTimer;

/** * 彻底关闭定时器 在viewDidDisappear或viewWillDisappear 需要调用此方法 */
- (void)invalidateTimer;




/**
 点击回调

 @param didSelectedBlock 点击了图片 返回一个index
 */
-(void)goodScrollViewDidSelectedBlock:(JZGoodScrollViewClickBlock)didSelectedBlock;



/**
 停留回调

 @param stopBlock 停留在哪张图片 返回一个index
 */
-(void)goodScrollViewStopBlock:(JZGoodScrollViewClickBlock)stopBlock;
@end
