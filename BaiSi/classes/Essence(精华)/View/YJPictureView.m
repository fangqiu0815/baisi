

#import "YJPictureView.h"
#import "UIImageView+WebCache.h"
#import "YJTopic.h"
#import "YJPictureTableViewController.h"


@interface YJPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIButton *bigBtn;



@end

@implementation YJPictureView

- (void)setTopic:(YJTopic *)topic{
    _topic = topic;
    self.iconImageView.layer.masksToBounds = YES;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        //下载进度
//        
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //判断是否是大图
//        if (topic.isBigPicture == NO) return ;
//        
//        [self.iconImageView setNeedsDisplay];
//    }];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1]];
    
    //判断是否为gif
    self.gifImageView.hidden = !topic.is_gif;
    //是否显示按钮"点击查看全图"
    if (topic.isBigPicture) { //大图
        self.bigBtn.hidden = NO;
    } else { //非大图
        self.bigBtn.hidden = YES;
    }

}


+ (instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    //如果发现控件的位置和尺寸不是自己设置的，那么有可能是自动伸缩属性导致
    self.autoresizingMask = UIViewAutoresizingNone;
    self.iconImageView.userInteractionEnabled = YES;
    [self.iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)] ];
}

-(void)showPicture {
    YJPictureTableViewController *showPictureVC = [[YJPictureTableViewController alloc] init];
    showPictureVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
}

@end
