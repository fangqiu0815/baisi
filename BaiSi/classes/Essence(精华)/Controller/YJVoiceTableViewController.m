//
//  YJVoiceTableViewController.m
//  BaiSi
//
//  Created by 高方秋 on 2016/9/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJVoiceTableViewController.h"
#import "YJVoiceView.h"


@interface YJVoiceTableViewController ()

@end
static NSString *ID = @"cell";
@implementation YJVoiceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);
     
    
}

- (YJTopicTypeAll)type{
    return YJTopicTypeVoice;
}

@end
