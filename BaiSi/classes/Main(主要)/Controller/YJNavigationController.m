//
//  YJNavigationController.m
//  BaiSi
//
//  Created by mac on 16/6/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJNavigationController.h"
#import "UIBarButtonItem+Item.h"
#import "UIColor+Extension.h"
@interface YJNavigationController() <UIGestureRecognizerDelegate>

@end
@implementation YJNavigationController

/*
 导航控制器总结：
 1.导航控制器显示的内容，永远是栈顶控制器的view
 2.导航条内容是由谁来决定：栈顶控制器的navigationItem来决定
 3.导航条的属性:UINavigationBar(修改导航条的富文本属性)
 
 问题：当我们覆盖系统的返回按钮的时候,滑动返回功能失效
 解决：
 分析问题：系统是如何实现滑动返回功能？
    通过手势interactivePopGestureRecognizer实现滑动返回
 猜测：1.手势被干掉了(不成立)
      2.有可能被代理拦截了 验证：把代理干掉
 
 当把interactivePopGestureRecognizer的代理干掉之后，就可以滑动返回了，但是又出现新的问题
 问题:在主界面进行变化滑动的时候，也会触发滑动返回，导致主界面卡主
 解决思路:
    非根控制器的时候就可以滑动返回
    在根控制器的时候,禁止滑动返回功能
    通过代理可以禁止接收用户的手势
 
 */

// 当类加载进内存的时候调用，只会调用一次
+ (void)load
{
    // 只需要设置一次就好了
    // 获取当前类和当前类的子类的UINavigationBar对象(全局)
    //动态更改导航背景 / 样式
    //开启编辑
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    //设置导航条背景颜色
    [navBar setBarTintColor:[UIColor colorWithHexString:@"#1874CD"]];
    //#1874CD
    //设置字体颜色
    [navBar setTintColor:[UIColor whiteColor]];
    //设置样式
    [navBar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSFontAttributeName : [UIFont boldSystemFontOfSize:16]
                                  }];
    
    //设置导航条按钮样式
    //开启编辑
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置样式
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : [UIColor whiteColor],
                                   NSFontAttributeName : [UIFont boldSystemFontOfSize:16]
                                   } forState:UIControlStateNormal];
    
    
    //UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    // 创建富文本属性字典
//    // 描述标题字体大小
//    NSDictionary *attrDict = @{
//                               NSFontAttributeName:[UIFont systemFontOfSize:20]                                };
//    // 设置标题的富文本属性
//    [navBar setTitleTextAttributes:attrDict];
    
    // 设置导航条背景图片
    // 注意：一定要选择UIBarMetricsDefault，否则就会出现问题
    //[navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置手势的代理，
    // 在非根控制器的时候允许接收滑动返回手势
    // 在根控制器不允许接收滑动返回手势
    self.interactivePopGestureRecognizer.delegate = self;
    //self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#1874CD"];
}

/**
 *  更改状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//设置状态栏是否隐藏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

    


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 根控制器不需要设置返回按钮
    // 非跟控制器需要设置返回按钮
    // 如何判断是非跟控制
//    NSLog(@"%ld",self.childViewControllers.count);
    if (self.childViewControllers.count > 0) {
        // 非跟控制器
        // viewController:push的下一个控制器
        // 在这里是不是可以设置返回按钮呢？
        // 设置导航条上的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  title:@"返回" addTarget:self action:@selector(back)];
        // 当push的时候隐藏tabBar
        // 在这里写没有效果，要在上一个界面设置
        viewController.hidesBottomBarWhenPushed = YES;
        
//        NSLog(@"%@",self.interactivePopGestureRecognizer);
        // 屏幕边缘滑动手势,只有在边缘滑动的时候才会触发手势
//        UIScreenEdgePanGestureRecognizer;
        /*<UIScreenEdgePanGestureRecognizer: 0x7fe4f8d84570; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fe4f8d82de0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fe4f8d84450>)>>
         */
        
        /*
        // 如何使用手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)];
        // 添加代理
        pan.delegate =
        [self.view addGestureRecognizer:pan];
         */
        
//        NSLog(@"delegate----%@",self.interactivePopGestureRecognizer.delegate);
        // 打印出来确实有代理
        /* delegate----<_UINavigationInteractiveTransition: 0x7fcf88d8cf10> */
        // 把代理干掉
//        self.interactivePopGestureRecognizer.delegate = nil;

    }
    // 保留系统的功能
    // 这里才是正真的跳转界面,而且会将viewControler添加到childViewControllers数组里来
    [super pushViewController:viewController animated:YES];
    
    //NSLog(@"pushViewController--%ld",self.childViewControllers.count);
}

// 点击返回按钮调用
- (void)back
{
//    NSLog(@"back-----");
    // 返回上一个控制器
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>手势代理
// 是否允许接收手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 返回值 YES：允许接收手势   NO:不允许接收手势
    // 在非根控制器的时候允许接收滑动返回手势
    // 在根控制器不允许接收滑动返回手势
//    NSLog(@"count---%ld",self.childViewControllers.count);
    if (self.childViewControllers.count > 1) {
        // 非跟控制器
        return YES;
    }else{// 根控制
        return NO;
    }
}












@end
