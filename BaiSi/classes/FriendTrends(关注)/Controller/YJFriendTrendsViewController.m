//
//  YJFriendTrendsViewController.m
//  BaiSi
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJFriendTrendsViewController.h"
#import "UIBarButtonItem+Item.h"
#import "YJLoginRegisterController.h"
#import "YJRecommandViewController.h"


@implementation YJFriendTrendsViewController

- (void)viewDidLoad
{
    // 设置随机颜色
    self.view.backgroundColor = YJRandomColor;
    
    // 设置导航条内容
    [self setupNavBar];
}

#pragma mark - 设置导航条内容
- (void)setupNavBar
{
    
    self.view.backgroundColor = YJColor(233, 233, 233);
    // 设置导航条左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] addTarget:self action:@selector(leftClick)];
    // 设置导航条的标题
    self.navigationItem.title = @"我的关注";
    // 如果是在UITabBarController里,不要使用这种方式设置标题，会出问题
    // 如果不在UITabBarControlle主框架中是可以这么设置
//    self.title = @"我的关注";
}

// 导航条左侧按钮点击事件
- (void)leftClick
{
    YJRecommandViewController *recommandVc = [[YJRecommandViewController alloc]init];
    [self.navigationController pushViewController:recommandVc animated:YES];
    
}

//立即登录和注册的点击事件
- (IBAction)loginRegisterClick:(UIButton *)sender {
    //点击登录和注册按钮转到登录控制器
    YJLoginRegisterController *loginVc = [[YJLoginRegisterController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
    

}











@end
