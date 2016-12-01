//
//  YJTopicCell.h
//  BaiSi
//
//  Created by 高方秋 on 2016/9/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJVideoView,YJVoiceView;
@class YJTopic;
@interface YJTopicCell : UITableViewCell

@property (nonatomic,strong)YJVideoView *videoView;
@property (nonatomic,strong)YJVoiceView *voiceView;

@property (nonatomic,strong)YJTopic *topic;

- (void)setContentWithButton:(UIButton *)button num:(NSInteger )num placeholder:(NSString *)placeholder;

+(instancetype)cell;

@end
