//
//  YJVoiceView.m
//  BaiSi
//
//  Created by 高方秋 on 2016/9/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJVoiceView.h"
#import "UIImageView+WebCache.h"
#import "YJTopic.h"
#import <AVFoundation/AVFoundation.h>

static AVPlayer *_player;
static UIButton *_lastPlayBtn;
static YJTopic *_lastTopic;

@interface YJVoiceView ()
//声音背景图片
@property (weak, nonatomic) IBOutlet UIImageView *voiceView;
//声音播放按钮
@property (weak, nonatomic) IBOutlet UIButton *listenBtn;
//声音播放时间
@property (weak, nonatomic) IBOutlet UILabel *listenTimeLabel;
//声音播放数量
@property (weak, nonatomic) IBOutlet UILabel *listenCountLabel;




@end

@implementation YJVoiceView

- (void)setTopic:(YJTopic *)topic{
    _topic = topic;
    
    //图片
    [self.voiceView sd_setImageWithURL:[NSURL URLWithString:topic.image1]];
    // 设置播放次数
    NSString *playCountStr = [NSString stringWithFormat:@"%ld播放",topic.playfcount];
    if (topic.playfcount > 10000) {
        playCountStr = [NSString stringWithFormat:@"%0.1f万播放",topic.playfcount / 10000.0];
    }
    //播放次数
    self.listenCountLabel.text = playCountStr;
   
    self.listenTimeLabel.text = [self stringWithTime:topic.voicetime];
    
    //按钮是否在播放?  播放状态和为播放状态设置不一样的图片
    [self.listenBtn setImage:[UIImage imageNamed:topic.voicePlaying ? @"playButtonPause":@"playButtonPlay"] forState:UIControlStateNormal];
    
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
        //保存
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        
    });
}


+ (instancetype)voiceView{

     return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];

}

// 将时间转化成字符串
- (NSString *)stringWithTime:(NSInteger)time
{
    // 分钟
    NSInteger min = time / 60;
    // 秒
    NSInteger sec = time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", min,sec];
}

//
//-(void)setListenBtn:(UIButton *)listenBtn{
//    _listenBtn = listenBtn;
//    [self.listenBtn setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
//    [self.listenBtn setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateSelected];
//}

- (IBAction)playClick:(UIButton *)sender {
    //修改按钮的状态
    _listenBtn.selected = !_listenBtn.isSelected;
    _lastPlayBtn.selected = !_lastPlayBtn.isSelected;
    
    
    if (_lastTopic != self.topic) {
        
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
        //取代播放
        [_player replaceCurrentItemWithPlayerItem:playerItem];
        [_player play];
        //上一个没有播放
        _lastTopic.voicePlaying = NO;
        //当前的正在播放
        self.topic.voicePlaying = YES;
        
        [_lastPlayBtn setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        [_listenBtn setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
        
    }else
    {
        if (_lastTopic.voicePlaying) { // 上一个如果正在播放
            //停止播放
            [_player pause];
            self.topic.voicePlaying = NO;
            [_listenBtn setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        }else
        {
            [_player play];
            self.topic.voicePlaying = YES;
            [_listenBtn setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
        }
    }
    _lastPlayBtn = _listenBtn;
    _lastTopic = self.topic;
    
}












@end
