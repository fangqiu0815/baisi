//
//  YJAdViewController.m
//  BaiSi
//
//  Created by Apple on 16/9/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJAdViewController.h"
#import "AFNetworking.h"
#import "YJAd.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "YJTabBarController.h"

#define urlStr @"http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface YJAdViewController ()

{
    YJAd *_ad;
    NSTimer *_timer;
}

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIView *adView;

@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;


@end

@implementation YJAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景图片,屏幕适配
    [self setupBgImageView];
    //向服务器请求数据
    //请求地址
    [self loadAdDatas];
    //定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateText) userInfo:nil repeats:YES];
    _timer = timer;
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)updateText{
    static int i = 3;
    if (i < 0) {
        [self jumpClick];
        return;
    }
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal];
    i--;

}


#pragma mark -设置背景图片
- (void)setupBgImageView
{
    // 屏幕适配(判断当前屏幕的尺寸)
//    NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
    // iphone4/4s
    if (iphone4) {
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage"];
    }else if(iphone5){ // iphone5/5s
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage-568h@2x"];
    }else if(iphone6){ // iphone6/6s
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }else if(iphone6p){ // iphone6p/6sp
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }
}

- (void)loadAdDatas{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/json",@"application/html", nil]];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //afn默认解析json数据
        //字典转模型
        YJAd *ad = [YJAd mj_objectWithKeyValues:responseObject[@"ad"][0]];
        _ad = ad;
        //创建广告图片的view
        UIImageView *adImageView = [[UIImageView alloc]init];
        //加载网络图片
        [adImageView sd_setImageWithURL:[NSURL URLWithString:ad.w_picurl]];
        //设置图片的frame
        //计算图片的frame显示高度
        /*
         图片显示的宽高
         */
        CGFloat imageViewH = YJScreenW * ad.h / ad.w;
        adImageView.frame = CGRectMake(0, 0, YJScreenW, imageViewH);
        //将图片添加到view里面
        [self.adView addSubview:adImageView];
        //广告图片的点击事件
        //设置图片可以与用户交互
        adImageView.userInteractionEnabled = YES;
        //给图片添加手势实现点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adImageViewClick)];
        [adImageView addGestureRecognizer:tap];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"error--%@",error);
    }];
}

- (IBAction)jumpClick{
    [_timer invalidate];
    _timer = nil;
    YJTabBarController *tabBarVc = [[YJTabBarController alloc]init];
    //[self showViewController:tabBarVc sender:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
}

#pragma mark - 点按图片手势操作
- (void)adImageViewClick{
   // YJLog(@"adImageViewClick");
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:_ad.ori_curl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_ad.ori_curl]];

    }
}

- (void)dealloc{
    NSLog(@"advc--dealloc");

}


@end
