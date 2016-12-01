
#import "YJTopicCell.h"
#import "UIImageView+WebCache.h"
#import "YJTopic.h"
#import "UIImageView+YJImageExtension.h"
#import "YJPictureView.h"
#import "YJVideoView.h"
#import "YJVoiceView.h"
#import "YJComment.h"
#import "YJUser.h"
#import "NSString+YJDealDate.h"
#import "NSDate+YJInterval.h"
#import "NSCalendar+YJUint.h"
#import "YJCollectionCacheData.h"


@interface YJTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@property (weak, nonatomic) IBOutlet UILabel *hotCommandLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commandBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;

@property (weak, nonatomic) IBOutlet UIView *hotCommendView;

@property (nonatomic,strong) YJPictureView *pictureView;

@end


@implementation YJTopicCell

+(instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}


-(YJVideoView *)videoView{
    if (_videoView  == nil) {
        YJVideoView *videoView = [YJVideoView videoView];
        [self addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

-(YJVoiceView *)voiceView{
    if (_voiceView == nil) {
        YJVoiceView *voiceView = [YJVoiceView voiceView];
        [self addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

-(YJPictureView *)pictureView{
    if (_pictureView == nil) {
        YJPictureView *pictureView = [YJPictureView pictureView];
        [self addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}


- (void)setTopic:(YJTopic *)topic{
    _topic = topic;
    //设置头像
    [self.iconImageView setCircleHeader:topic.profile_image];
    //设置昵称
    self.nameLabel.text = topic.name;
    //设置发帖时间
    self.timeLabel.text = [topic.create_time dealDate];
    //设置帖子内容
    self.titleTextLabel.text = topic.text;
    //设置顶 踩 分享 评论 的数量
    //设置按钮的文字
    [self setContentWithButton:self.dingBtn num:topic.love placeholder:@"ding"];
    [self setContentWithButton:self.caiBtn num:topic.hate placeholder:@"cai"];
    [self setContentWithButton:self.shareBtn num:topic.repost placeholder:@"share"];
    [self setContentWithButton:self.commandBtn num:topic.comment placeholder:@"comment"];
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == YJTopicTypePic) { // 图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.pictureF;
        self.pictureView.topic = topic;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == YJTopicTypeVoice) { // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        self.voiceView.frame = topic.pictureF;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == YJTopicTypeVideo) { // 视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        self.videoView.frame = topic.pictureF;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else { // 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }

    //设置最热评论的数据
    //判断是否有最热评论，有就显示 无就隐藏
    if(topic.top_cmt){
        self.hotCommendView.hidden = NO;
//        NSString *userName = topic.top_cmt[0][@"user"][@"username"];
//        NSString *content = topic.top_cmt[0][@"content"];
        self.hotCommandLabel.text = [NSString stringWithFormat:@"%@:%@",topic.top_cmt.user.username, topic.top_cmt];
    }else{
        
        self.hotCommendView.hidden = YES;
    }
    
}

- (void)setContentWithButton:(UIButton *)button num:(NSInteger )num placeholder:(NSString *)placeholder{
    if (num) {
        if (num>10000) {
            placeholder = [NSString stringWithFormat:@"%0.1f",num/10000.0];
        }else if (num > 0){
            placeholder = [NSString stringWithFormat:@"%zd",num];
        }
    [button setTitle:placeholder forState:UIControlStateNormal];
    }

}


// 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置中间view的frame
    if (_topic.type == YJTopicTypeVideo) {
        self.videoView.frame = _topic.centerFrame;
    }else if (_topic.type == YJTopicTypeVoice){
        self.voiceView.frame = _topic.centerFrame;
    }else if (_topic.type == YJTopicTypePic){
        self.pictureView.frame = _topic.centerFrame;
    }
}

-(void)setFrame:(CGRect)frame {
    //frame.origin.x = 10;
    //frame.size.width -= 2 * 10;
    frame.size.height -= 10 ;
    //frame.origin.y += 10;
    [super setFrame:frame];
}

- (IBAction)moreClick:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];
    
}





@end
