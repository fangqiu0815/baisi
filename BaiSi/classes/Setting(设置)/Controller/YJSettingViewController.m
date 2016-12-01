//
//  YJSettingViewController.m
//  BaiSi
//
//  Created by mac on 16/6/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJSettingViewController.h"
#import "UIBarButtonItem+Item.h"
#import "YJShareViewController.h"
#import "YJOtherViewController.h"
#import "YJClearCacheCell.h"
#import "YJCollectionViewController.h"

@interface YJSettingViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

static NSString *settingID = @"SettingCell";
static NSString * const YJClearCacheCellId = @"YJClearCacheCell";
static NSString * const YJSettingCellId = @"YJSettingCellId";



@implementation YJSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor greenColor];
    
    self.title = @"设置";
        // 当push的时候隐藏tabBar
    // 在这里写没有效果，要在上一个界面设置
//    self.hidesBottomBarWhenPushed = YES;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一个界面" style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    
    //注册cellID
    [self.tableView registerClass:[YJClearCacheCell class] forCellReuseIdentifier:YJClearCacheCellId];
    
    
}




//// 跳转到下一个界面
//- (void)jump
//{
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.title = @"下一个界面";
//    vc.view.backgroundColor = [UIColor orangeColor];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else{
        return 7;
    }
    /**
     添加注释
     **/
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingID];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"字体大小";
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            YJClearCacheCell *cell1 = [tableView dequeueReusableCellWithIdentifier:YJClearCacheCellId];
            return cell1;
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"推荐给朋友";
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"收藏";
            
        }
        else if (indexPath.row == 3)
        {
            cell.textLabel.text = @"当前版本：4.4";
        }
        else if (indexPath.row == 4)
        {
            cell.textLabel.text = @"关于我们";
            

        }
        else if (indexPath.row == 5)
        {
            cell.textLabel.text = @"隐私政策";
            

        }
        else if (indexPath.row == 6)
        {
            cell.textLabel.text = @"打分支持不得姐！";

        }
    }
    
    //设置右边辅助按钮的样式
    if (indexPath.section == 0 )
    {
        NSArray *arrayData = [[NSArray alloc]initWithObjects:@"小",@"中",@"大", nil];
        UISegmentedControl *segControl = [[UISegmentedControl alloc]initWithItems:arrayData];
        segControl.selectedSegmentIndex = 1;
        cell.accessoryView = segControl;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"功能设置";
    }else{
        return @"其他";
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 30;
    }else{
        return 20;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            YJLogFunc
        }
        else if (indexPath.row == 1)
        {
           
            YJShareViewController *shareVC = [[YJShareViewController alloc] init];
            shareVC.title = @"推荐给朋友";
            
            //取出当前导航控制器
            UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
            [nav pushViewController:shareVC animated:YES];
        }
        else if (indexPath.row == 2)
        {
           
            YJCollectionViewController *otherVC = [[YJCollectionViewController alloc] init];
            otherVC.title = @"收藏";
            
            //取出当前导航控制器
            UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
            [nav pushViewController:otherVC animated:YES];
        }
        else if (indexPath.row == 3)
        {
           // cell.textLabel.text = @"当前版本：4.4";
            YJOtherViewController *otherVC = [[YJOtherViewController alloc] init];
            otherVC.title = @"当前版本";
            
            //取出当前导航控制器
            UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
            [nav pushViewController:otherVC animated:YES];
        }
        else if (indexPath.row == 4)
        {
           // cell.textLabel.text = @"关于我们";
            YJOtherViewController *otherVC = [[YJOtherViewController alloc] init];
            otherVC.title = @"关于我们";
            
            //取出当前导航控制器
            UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
            [nav pushViewController:otherVC animated:YES];
            
        }
        else if (indexPath.row == 5)
        {
           // cell.textLabel.text = @"隐私政策";
            YJOtherViewController *otherVC = [[YJOtherViewController alloc] init];
            otherVC.title = @"隐私政策";
            
            //取出当前导航控制器
            UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
            [nav pushViewController:otherVC animated:YES];
            
            
        }
        else if (indexPath.row == 6)
        {
          //  cell.textLabel.text = @"打分支持不得姐！";
            YJOtherViewController *otherVC = [[YJOtherViewController alloc] init];
            otherVC.title = @"打分支持不得姐！";
            
            //取出当前导航控制器
            UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
            [nav pushViewController:otherVC animated:YES];
        }

    }
}





@end
