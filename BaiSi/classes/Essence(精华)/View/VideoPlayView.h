//
//  VideoPlayView.h
//  02-远程视频播放(AVPlayer)
//
//  Created by apple on 15/12/18.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "YJTopic.h"
#import "YJBaseTopicViewController.h"
@interface VideoPlayView : UIView
/** 快速创建 */
+ (instancetype)videoPlayView;


@property (nonatomic,strong)YJBaseTopicViewController *basetopicVC;

/** 需要播放的视频资源 */
@property (nonatomic,copy) NSString *urlString;

/* 包含在哪一个控制器中 */
@property (nonatomic, weak) UIViewController *contrainerViewController;

/**模型数据对象*/
@property (nonatomic,strong)YJTopic *model;
/** 播放器 */
@property (nonatomic,strong) AVPlayer *player;

/** 播放器的Layer */
@property (nonatomic,strong) AVPlayerLayer *playerLayer;

/** playItem */
@property (nonatomic,strong) AVPlayerItem *playerItem;






@end
