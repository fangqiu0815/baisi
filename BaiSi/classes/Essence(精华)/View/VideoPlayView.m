//
//  VideoPlayView.m
//  02-远程视频播放(AVPlayer)
//
//  Created by apple on 15/12/18.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import "VideoPlayView.h"
#import "YBAVPlayViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface VideoPlayView()
/**用来放大图的时候调用*/
@property (nonatomic,strong)YBAVPlayViewController *ybAVPlay;

/** 背景图片 */
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
/** 工具栏     */
@property (strong, nonatomic) IBOutlet UIView *toolView;
/** 开始暂停按钮 */
@property (strong, nonatomic) IBOutlet UIButton *playOrPauseBtn;
/** 滑动条 */
@property (strong, nonatomic) IBOutlet UISlider *progressSlider;
/** 时间Label*/
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;



/** 记录当前是否显示了工具栏 */
@property (nonatomic,assign) BOOL isShowToolView;

/* 定时器 */
@property (nonatomic, strong) NSTimer *progressTimer;

/* 工具栏的显示和隐藏 */
@property (nonatomic, strong) NSTimer *showTimer;

/* 工具栏展示的时间 */
@property (assign, nonatomic) NSTimeInterval showTime;

/* 全屏控制器 */



#pragma mark - 监听事件的处理
- (IBAction)playOrPause:(UIButton *)sender;
- (IBAction)switchOrientation:(UIButton *)sender;
- (IBAction)slider;
- (IBAction)startSlider;
- (IBAction)sliderValueChange;

- (IBAction)tapAction:(UITapGestureRecognizer *)sender;
- (IBAction)swipeAction:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender;

@end

@implementation VideoPlayView

// 快速创建View的方法
+ (instancetype)videoPlayView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"VideoPlayView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSURL *url = [NSURL URLWithString:_urlString];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.playerItem = item;
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    
     //初始化Player和Layer
    self.player = [[AVPlayer alloc] init];
   
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    [self.imageView.layer addSublayer:self.playerLayer];
    [self.player play];
    // 设置工具栏的状态
    self.toolView.alpha = 0;
    self.isShowToolView = NO;
    
    
    // 设置进度条的内容
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
    [self.progressSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    
    // 设置按钮的状态
    self.playOrPauseBtn.selected = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissViewvc) name:@"dismissCellViewVC" object:nil];
    
}
#pragma mark -- 移除当前视图
- (void)dismissViewvc{
    [self.player pause];
//    [self removeFromSuperview];

    if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
        [self removeFromSuperview];
    }
}
#pragma mark - 观察者对应的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (AVPlayerItemStatusReadyToPlay == status) {
            [self removeProgressTimer];
            [self addProgressTimer];
        } else {
            [self removeProgressTimer];
        }
    }
}

#pragma mark - 重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
}

#pragma mark - 设置播放的视频
- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    
    NSURL *url = [NSURL URLWithString:urlString];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.playerItem = item;
    
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.player play];
}

// 是否显示工具的View
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self showToolView:!self.isShowToolView];
    
    if (self.isShowToolView) {
        [self addShowTimer];
    }
}

- (IBAction)swipeAction:(UISwipeGestureRecognizer *)sender {
    [self swipeToRight:YES];
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    [self swipeToRight:NO];
}
#pragma mark -- 快进和快退
- (void)swipeToRight:(BOOL)isRight
{
    // 1.获取当前播放的时间
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
    
    if (isRight) {
        currentTime += 10;
    } else {
        currentTime -= 10;
    }
    
    if (currentTime >= CMTimeGetSeconds(self.player.currentItem.duration)) {
        currentTime = CMTimeGetSeconds(self.player.currentItem.duration) - 1;
    } else if (currentTime <= 0) {
        currentTime = 0;
    }
    
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    [self updateProgressInfo];
}
#pragma mark -- 是否要展示工具条
- (void)showToolView:(BOOL)isShow
{
    [UIView animateWithDuration:0.5 animations:^{
        self.toolView.alpha = !self.isShowToolView;
        self.isShowToolView = !self.isShowToolView;
    }];
}

// 暂停按钮的监听
- (IBAction)playOrPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.player play];
        
        [self addProgressTimer];
    } else {
        [self.player pause];
        
        [self removeProgressTimer];
    }
}

#pragma mark - 定时器操作
- (void)addProgressTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}
#pragma mark -- 移除定时器
- (void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}
#pragma mark -- 更新时间
- (void)updateProgressInfo
{
    // 1.更新时间
    self.timeLabel.text = [self timeString];
    
    self.progressSlider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    
}

- (NSString *)timeString
{
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);

    return [self stringWithCurrentTime:currentTime duration:duration];
}

- (void)addShowTimer
{
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateShowTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.showTimer forMode:NSRunLoopCommonModes];
}

- (void)removeShowTimer
{
    [self.showTimer invalidate];
    self.showTimer = nil;
}

- (void)updateShowTime
{
    self.showTime += 1;
    
    if (self.showTime > 2.0) {
        [self tapAction:nil];
        [self removeShowTimer];
        
        self.showTime = 0;
    }
}

#pragma mark - 切换屏幕的方向
- (IBAction)switchOrientation:(UIButton *)sender {
    sender.selected = !sender.selected;
        //创建一个控制器
    [self.player pause];
    [self removeFromSuperview];
    
        self.ybAVPlay = [[YBAVPlayViewController alloc]init];
        //在调整下把视图转化到根视图上面
    self.ybAVPlay.model = _model;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.ybAVPlay  animated:YES completion:nil];
//    [self videoplayViewSwitchOrientation:sender.selected];
}
////没有调用
//- (void)videoplayViewSwitchOrientation:(BOOL)isFull
//{
//    if (isFull) {
//        [self.contrainerViewController presentViewController:self.fullVc animated:NO completion:^{
//            [self.fullVc.view addSubview:self];
//            self.center = self.fullVc.view.center;
//            
//            [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//                self.frame = self.fullVc.view.bounds;
//            } completion:nil];
//        }];
//    } else {
//        [self.fullVc dismissViewControllerAnimated:NO completion:^{
//            [self.contrainerViewController.view addSubview:self];
//            
//            [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//                self.frame = CGRectMake(0, 0, self.contrainerViewController.view.bounds.size.width, self.contrainerViewController.view.bounds.size.width * 9 / 16);
//            } completion:nil];
//        }];
//    }
//}

- (IBAction)slider {
    [self addProgressTimer];
    
    // 设置视频播放进度为slider对应的值
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (IBAction)startSlider {
    [self removeProgressTimer];
}

- (IBAction)sliderValueChange {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    
    self.timeLabel.text = [self stringWithCurrentTime:currentTime duration:duration];
    
}

- (NSString *)stringWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration
{
    NSInteger dMin = duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    
    NSInteger cMin = currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    
    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", dMin, dSec];
    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld", cMin, cSec];
    
    /**自动播放完成之后自动移除*/
    if (currentString == durationString) {
         [self.player pause];
        [self removeFromSuperview];
       
    }
    return [NSString stringWithFormat:@"%@/%@", currentString, durationString];
    
}


#pragma mark -- 长按移除
- (IBAction)longTap:(UILongPressGestureRecognizer *)sender {
    [self.player pause];
    [self removeFromSuperview];
    
    
}

@end
