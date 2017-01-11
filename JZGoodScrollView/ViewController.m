//
//  ViewController.m
//  JZGoodScrollView
//
//  Created by wanhongios on 17/1/9.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "ViewController.h"
#import "JZGoodScrollView.h"
@interface ViewController ()

@end

@implementation ViewController{
    NSArray <NSURL *> *_urls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    [self loadData];
    
    if (_urls.count>0)
    {
        JZGoodScrollView * scrollView = [[JZGoodScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 300) urls:_urls placeHolderImage:[UIImage imageNamed:@"seefarmseatpic.png"]];
        scrollView.autoScroll = YES;
        [scrollView goodScrollViewDidSelectedBlock:^(NSInteger index) {

            NSLog(@"点击了第%ld张",index);
        }];
        
        [scrollView goodScrollViewStopBlock:^(NSInteger index) {
//            NSLog(@"停留在第%ld张图片",index);
        }];
        [self.view addSubview:scrollView];
    }
   
}


// 加载数据
-(void)loadData
{
    NSMutableArray * urlArr = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++)
    {
        NSString * fileName = [NSString stringWithFormat:@"%02djz.jpg",i+1];
        NSURL * url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        [urlArr addObject:url];
    }
    
    _urls = urlArr.copy;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
