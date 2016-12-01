//
//  YJTabBarController.m
//  BaiSi
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJTabBarController.h"
#import "YJEssenceViewController.h"
#import "YJFriendTrendsViewController.h"
#import "YJMeViewController.h"
#import "YJNewViewController.h"
#import "YJPublishViewController.h"
#import "UIImage+Original.h"
#import "YJNavigationController.h"
#import "YJTabBar.h"
@implementation YJTabBarController
/*
 自己的事情自己完成
 1.添加子控制器
 2.设置tabbar上都按钮内容
 
 
 问题：
 1.选中按钮的图片被渲染成蓝色(系统自动渲染成蓝色)
    解决方式：
        1.1在assets资源里不让系统去渲染图片(界面)
        1.2使用代码的方式不让系统去渲染图片
 
 2.选中按钮的文字变成蓝色 蓝色->灰色
    解决方式:拿到全局的tabBarItme，修改字体的颜色和大小
 
 3.发布按钮图片显示的位置出现问题
    方案：1.修改发布按钮的位置(拿不到发布按钮)
         2.发布按钮图片尺寸过大，修改发布按钮的尺寸(不可行)
         3.不设置发布按钮的图片，然后在tabBar中间添加一个按钮，自己设置frame和图片(多了一个子控制,不太安全)
 
    终极解决:自定义tabBar
 
 */



// 当类加载进内存的时候调用，只会调用一次
+ (void)load
{
    // 设置UITabBarButton按钮文字的属性需要设置几次？
    // 在整个项目中只需要设置一次就好
    // 1.获取哪个类(或子类)的UITabBarItem全局对象
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    
    // 2.设置选中文字的颜色
    // 设置富文本属性
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    // 设置文字颜色的属性
    attrSelected[NSForegroundColorAttributeName] = YJColor(45, 130, 211);
    
    // 设置富文本(带有属性的字符串)属性
    [tabBarItem setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    // 3.设置按钮文字的大小
    // 设置富文本属性
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    // 设置文字大小的属性
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    // 设置按钮文字的大小属性
    [tabBarItem setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
    
}

- (void)viewDidLoad
{
    // 1.添加子控制器
    [self addChildViewControllers];
    
    // 2.设置tabbar上都按钮内容
    [self setupTabBarButton];
    
    //NSLog(@"self.tabBar.subviews=%@",self.tabBar.subviews);
    // 创建自己的tabBar
    YJTabBar *tabBar = [[YJTabBar alloc] init];
    // 将系统的tabBar替换成自己创建的
    // 系统的tabBar属性是readonly只读，不能够修改
//    self.tabBar = tabBar;
    // 使用kvc可以修改对象的私有属性
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    
    
}


#pragma mark - 添加子控制器
- (void)addChildViewControllers
{
    // 2.2给UITabBarController添加子控制器
    
    // 精华
    // 创建导航控制器的根控制器
    YJEssenceViewController *essenceVc =     [[YJEssenceViewController alloc] init];
    // 2.2.创建导航控制器,添加跟控制器
    YJNavigationController *nav0 = [[YJNavigationController alloc] initWithRootViewController:essenceVc];
    // 添加到UITabBarControllers上
    [self addChildViewController:nav0];
    
    // 最新
    // 创建导航控制器的根控制器
    YJNewViewController *newVc = [[YJNewViewController alloc] init];
    // 2.2.创建导航控制器,添加跟控制器
    YJNavigationController *nav1 = [[YJNavigationController alloc] initWithRootViewController:newVc];
    // 添加到UITabBarControllers上
    [self addChildViewController:nav1];
    
    // 发布
//    // 创建导航控制器的根控制器
//    YJPublishViewController *publishVc = [[YJPublishViewController alloc] init];
//    // 2.2.创建导航控制器,添加跟控制器
//    YJNavigationController *nav2 = [[YJNavigationController alloc] initWithRootViewController:publishVc];
//    // 添加到UITabBarControllers上
//    [self addChildViewController:nav2];

    
    // 关注
    // 创建导航控制器的根控制器
    YJFriendTrendsViewController *friendVc = [[YJFriendTrendsViewController alloc] init];
    // 2.2.创建导航控制器,添加跟控制器
    YJNavigationController *nav3 = [[YJNavigationController alloc] initWithRootViewController:friendVc];
    // 添加到UITabBarControllers上
    [self addChildViewController:nav3];
    
    // 我的
    // 创建导航控制器的根控制器
    YJMeViewController *meVc = [[YJMeViewController alloc] init];
    // 2.2.创建导航控制器,添加跟控制器
    YJNavigationController *nav4 = [[YJNavigationController alloc] initWithRootViewController:meVc];
    // 添加到UITabBarControllers上
    [self addChildViewController:nav4];
}

#pragma mark - 设置tabbar上都按钮内容
- (void)setupTabBarButton
{
    // 设置tabbar的按钮的内容
    // 通过索引获取tabbarController的子控制
    UINavigationController *nav0 = self.childViewControllers[0];
    // 精华
    nav0.tabBarItem.title = @"精华";
    nav0.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav0.tabBarItem.selectedImage = [UIImage imageNamedWithRenderOriginal:@"tabBar_essence_click_icon"];
    
    // 最新
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"最新";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamedWithRenderOriginal:@"tabBar_new_click_icon"];
    
    // 发布
//    UINavigationController *nav2 = self.childViewControllers[2];
//    nav2.tabBarItem.image = [UIImage imageNamedWithRenderOriginal:@"tabBar_publish_icon"];
//    nav2.tabBarItem.selectedImage = [UIImage imageNamedWithRenderOriginal:@"tabBar_publish_click_icon"];

   
    // 关注
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamedWithRenderOriginal:@"tabBar_friendTrends_click_icon"];
    
    // 我的
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我的";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageNamedWithRenderOriginal:@"tabBar_me_click_icon"];
 
}






@end















