//
//  YJBannerView.h
//  04-封装广告轮播view
//
//  Created by Apple on 16/10/17.
//  Copyright © 2016年 yunjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  YJBannerViewDelegate<NSObject>
/*** 点击广告轮播图的代理点击事件  **/
- (void)bannerViewClick:(NSInteger)index;

@end


@interface YJBannerView : UIView

/** 图片名称数组 */
@property (nonatomic,strong) NSArray *imageNames;
/***  daili **/
@property (nonatomic,weak)id<YJBannerViewDelegate>delegate;

@end



















