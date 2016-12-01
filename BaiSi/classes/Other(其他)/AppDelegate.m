//
//  AppDelegate.m
//  BaiSi
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "AppDelegate.h"
#import "YJAdViewController.h"
#import "YJTabBarController.h"
//#import "UMSocial.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocialSinaSSOHandler.h"
//#import "UMSocialWechatHandler.h"
//#import "UMSocialSnsPlatformManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
/*
 项目分析：
 1.项目环境搭建(设置应用图标，启动图片，划分项目文件夹目录)
 2.搭建主流框架 -> 应用已启动显示的就是tabBarControl -> 先有tabbarController，再有导航条
 2.1开发方式:1.stroryboard 2.纯代码 √ 怎么设置tabBarController？
 2.2 启动原理：执行main -> 执行UIApplicationMain -> 创建UIApplication -> 设置AppDelegate代理 -> 启动完成 -> 设置主窗口 ->设置主窗口根控制器 -> 显示主窗口的根控制器的view
 2.3 UITabBarController切换view的原理：将上一个子控制的view移除,将当前子控制器的view添加到UITabBarController的view上
 2.4 添加子控制器，添加几个子控制？有几个tabbarButton就添加几个子控制器，自定义子控制器(来处理业务逻辑)，5个按钮，创建5个子控制器
 
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
//    //设置友盟社会化组件appkey
//    //    [UMSocialData setAppKey:UmengAppkey];
//    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    
//    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
//    //设置友盟社会化组件appkey
//    //    [UMSocialData setAppKey:UmengAppkey];
//    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//    
//    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    // 2.创建创建窗口的根控制器
    YJAdViewController *adVc = [[YJAdViewController alloc] init];
    //YJTabBarController *adVc = [[YJTabBarController alloc]init];
    self.window.rootViewController = adVc;
    
    
    // 3.成为窗口的根控制器，并显示出来
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
