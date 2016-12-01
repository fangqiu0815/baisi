//
//  YJShareViewController.m
//  BaiSi
//
//  Created by 高方秋 on 2016/9/26.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJShareViewController.h"
//#import "UMSocialData.h"
//#import "UMSocialSnsService.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocialConfig.h"
//#import "UMSocialSnsPlatformManager.h"

@interface YJShareViewController ()//<UMSocialUIDelegate>

@end

@implementation YJShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpButton];
    
}

- (void)setUpButton{
    //QQ
    UIButton *QQbtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 80, 60, 60)];
    [QQbtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [QQbtn setTitle:@"QQ分享" forState:UIControlStateNormal];
    [QQbtn addTarget:self action:@selector(QQClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQbtn];
    
}
//
//- (void)QQClick{
//    //分享内嵌文字
//    NSString *shareText = @"百思不得姐。 http://www.baisi.com/";
//    //分享内嵌图片
//    UIImage *shareImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UMS_social_demo" ofType:@"png"]];
//    //调用快速分享接口
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"57dfaa6ae0f55a6f9700115c"
//                                      shareText:shareText
//                                     shareImage:shareImage
//                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
//                                       delegate:self];
//    
//
//
//}
//
//
//
////下面完成
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
