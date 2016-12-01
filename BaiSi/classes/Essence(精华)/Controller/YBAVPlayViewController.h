//
//  YBAVPlayViewController.h
//  百思不得姐项目
//
//  Created by mac on 16/10/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "YJTopic.h"
@interface YBAVPlayViewController : AVPlayerViewController

@property (nonatomic,strong)YJTopic *model;

@end
