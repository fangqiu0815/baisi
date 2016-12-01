//
//  YJTabBar.m
//  BaiSi
//
//  Created by Apple on 16/9/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJTabBar.h"
#import "YJGlobel.h"
#import "YJPublishViewController.h"
#import "YJSquareButton.h"
@interface YJTabBar()
/** 发布按钮 */
@property (nonatomic,strong) UIButton *publishBtn;
//上一次点击的按钮
@property (nonatomic,strong) UIButton *preBtn;
@end
@implementation YJTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        // 创建发布按钮
        UIButton *publishBtn = [[UIButton alloc] init];
        self.publishBtn = publishBtn;
        // 设置按钮图片
        [publishBtn setImage:[UIImage imageNamed:@"duanzi"] forState:UIControlStateNormal];
        //[publishBtn setImage:[UIImage imageNamed:@"段"] forState:UIControlStateSelected];
        //[publishBtn setTitle:@"发布" forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(publisc:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:publishBtn];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    NSLog(@"YJTabBar---%@",self.subviews);
    // UITabBarButton就是tabBar里的按钮
    // 重新修改UITabBarButton的frame
    // self.items:保存tabBarItem的数组
    CGFloat btnW = YJScreenW / (self.items.count + 1);
    CGFloat btnH = self.yj_height;
    int i = 0;
    for (UIButton *view in self.subviews) {
        NSLog(@"view = %@",view);
        // 判断子控件是否是UITabBarButton
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if(i == 2){
                i++;
            }
            // 是UITabBarButton就修改frame
            view.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            i++;
            //给UITarBarButton 添加点击事件
            [view addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
            if (i == 0) {
                self.preBtn = view;
            }
        }
    }
    
    // 设置发布按钮的center
    self.publishBtn.yj_height = btnH;
    self.publishBtn.yj_width = btnW;
    self.publishBtn.yj_centerX = self.yj_width * 0.5;
    self.publishBtn.yj_centerY = self.yj_height *0.5 ;
   
}


- (void)titleBtnClick:(UIButton *)titleBtn{

    if (titleBtn == self.preBtn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:YJTabBarDidSelectedNotification object:nil];
    }
    self.preBtn = titleBtn;
}

#pragma mark -- 中间的+的按键的功能点击事件
- (void)publisc:(UIButton *)btn{
    //    NSLog(@"中间");
    YJPublishViewController *middleView = [[YJPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:middleView animated:YES completion:nil];
}











@end
