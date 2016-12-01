//
//  YBAVPlayViewController.m
//  百思不得姐项目
//
//  Created by mac on 16/10/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YBAVPlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface YBAVPlayViewController ()


@end

@implementation YBAVPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:_model.videouri];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    self.player = player;
    [self.player play];
    
}

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
