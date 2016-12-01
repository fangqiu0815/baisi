//
//  YJBannerView.m
//  04-封装广告轮播view
//
//  Created by Apple on 16/10/17.
//  Copyright © 2016年 yunjia. All rights reserved.
//

#import "YJBannerView.h"

@interface YJBannerView()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageC;
}
@end
@implementation YJBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 初始化子控件
        // 添加scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        _scrollView = scrollView;
        // 设置scrollView的属性
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        
        // 添加imageView
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [scrollView addSubview:imageView];
            imageView.userInteractionEnabled = YES;
           //添加点击事件的手势操作
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AdClick)];
            [imageView addGestureRecognizer:tap];
        }
        
        // 设置页码
        UIPageControl *pageC = [[UIPageControl alloc] init];
        _pageC = pageC;
        pageC.pageIndicatorTintColor = [UIColor grayColor];
        pageC.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:pageC];
    }
    return self;
}

- (void)AdClick{
    //调用点击事件的代理
    if ([self.delegate respondsToSelector:@selector(bannerViewClick:)]) {
        [self.delegate bannerViewClick:_pageC.currentPage];
    }

}




- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置scrollView的frame
    _scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    // 设置pageControl的frame
    _pageC.frame = CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20);
    _pageC.currentPage = 0;
    // 设置center值
    CGPoint center = _pageC.center;
    center.x = _scrollView.center.x;
    _pageC.center = center;
    
    // 设置图片的frame
    for (int i = 0; i < _scrollView.subviews.count; i++) {
        UIImageView *imageView = _scrollView.subviews[i];
        imageView.frame = CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    }
}


// 设置imageView的图片
- (void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    // 设置scrollView的内容尺寸
    _scrollView.contentSize = CGSizeMake(imageNames.count * self.bounds.size.width, 0);
    
    // 设置总页码
    _pageC.numberOfPages = imageNames.count;
    [self setContent];
    
}

// 设置imageView的图片
- (void)setContent
{
    // 设置imageView的图片，图片的下标和当前页面的下标是一样的
    NSInteger curPage = _pageC.currentPage;
    NSInteger index = 0;
    for (int i = 0; i < 3; i++) {
        // 计算图片的下标
        if (i == 0) { // 左边的图片
            index = curPage -1;
        }else if(i == 1){// 中间图片
            index = curPage;
        }else if ( i == 2){ // 右边的图片
            index = curPage + 1;
        }
        // 特殊情况的处理
        if (index == -1) { // 要设置最后一张图片
            // 赋值最后一张图片的下标
            index = self.imageNames.count - 1;
        }else if(index == self.imageNames.count){
            // 将右边的图片设置为下标0的图片
            index = 0;
        }
        // 设置图片
        UIImageView *imageView = _scrollView.subviews[i];
        imageView.image = [UIImage imageNamed:self.imageNames[index]];
        imageView.tag = index;
    }
    
    // 设置scollView的偏移量
    // 让scollView永远显示的是中间的imageView
    // 显示的是中间的imageView contentOffset.X = 1倍的scrollView的宽度
    _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 找出中间的imageView，中间imageView的tag就是当前的页码
    // 如果找出中间的imageView?
    // 解决：规律 偏移量的x - imageView.x得到的值取绝对值，值最小的就是中间的imageView;
    // 定义差值为最大值
    CGFloat minDelta = MAXFLOAT;
    UIImageView *middleImageView = nil;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = _scrollView.subviews[i];
        // 差值的绝对值
        CGFloat delta = ABS(scrollView.contentOffset.x - imageView.frame.origin.x);
        if (delta < minDelta) {
            // 如果差值小于最小的差值
            minDelta = delta;
            middleImageView = imageView;
        }
    }
    // 设置当前的页码
    _pageC.currentPage = middleImageView.tag;

}

- (void)nextPage{

    [_scrollView setContentOffset:CGPointMake(2 * self.bounds.size.width, 0) animated:YES];
    [self setContent];
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setContent];
}















@end
