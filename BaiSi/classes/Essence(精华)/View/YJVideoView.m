

#import "YJVideoView.h"
#import "UIImageView+WebCache.h"
#import "YJTopic.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "YBAVPlayViewController.h"
#import "VideoPlayView.h"
@interface YJVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (nonatomic,strong)AVPlayerViewController *avVc;
@property (nonatomic,strong)YBAVPlayViewController *ybAVPlay;

@property (nonatomic,strong)VideoPlayView *playView;

@end

@implementation YJVideoView

- (VideoPlayView *)playView{
    if (_playView == nil) {
        _playView = [VideoPlayView videoPlayView];
    }
    return _playView;
}

- (AVPlayerViewController *)avVc{
    if (_avVc == nil) {
        _avVc = [[AVPlayerViewController alloc]init];
        NSURL *url = [NSURL URLWithString:_topic.videouri];
        AVPlayer *player = [AVPlayer playerWithURL:url];
        _avVc.player = player;
    }
    return _avVc;
}


- (void)setTopic:(YJTopic *)topic{
    _topic = topic;
    //图片
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1]];
    
    // 设置播放次数
    NSString *playCountStr = [NSString stringWithFormat:@"%ld播放",topic.playfcount];
    if (topic.playfcount > 10000) {
        playCountStr = [NSString stringWithFormat:@"%0.1f万播放",topic.playfcount / 10000.0];
    }
    //播放次数
    self.playCountLabel.text = playCountStr;
    self.videoTimeLabel.text = [self stringWithTime:topic.videotime];
    
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

-(void)setPlayBtn:(UIButton *)playBtn {
    _playBtn = playBtn;
    [self.playBtn setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateSelected];
}

//-(void)showPicture {
//    self.playBtn.selected = !self.playBtn.isSelected;
//}

+ (instancetype)videoView{
      return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self  class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    //如果发现控件的位置和尺寸不是自己设置的，那么有可能是自动伸缩属性导致
    self.autoresizingMask = UIViewAutoresizingNone;
    self.videoImageView.userInteractionEnabled = YES;
//    [self.videoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    UIButton *playBtn = [[UIButton alloc] init];
    [playBtn setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchDown];
    [self.videoImageView addSubview:playBtn];
        // 设置按钮的约束
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.videoImageView);
    }];

    
}

- (IBAction)playButtonClick:(UIButton *)sender {
    sender.hidden = YES;
     //跳转控制器进行播放
    //NSURL *videoPathURL=[[NSURL alloc] initWithString:self.topic.videouri];
    
//    MPMoviePlayerViewController *vc =[[MPMoviePlayerViewController alloc]initWithContentURL:videoPathURL];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    self.playView = [VideoPlayView videoPlayView];
    [self.playView setFrame:self.videoImageView.bounds];
    [self addSubview:self.playView];
    //这步要注意
    //由于这个赋值之后，后面的控制器和之歌对象不一致所以没有内容
    self.playView.model = self.topic;
    [self.playView setUrlString:_topic.videouri];
    
}




@end
