//
//  YJTalkTableViewController.m
//  BaiSi
//
//  Created by 高方秋 on 2016/9/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJTalkTableViewController.h"

@interface YJTalkTableViewController ()

@end

@implementation YJTalkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);
}

- (YJTopicTypeAll)type{
    return YJTopicTypeTalk;
}

@end
