

#import "YJPictureTableViewController.h"
#import "YJPictureView.h"
#import "YJProgressView.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "YJTopic.h"
#import "YJSaveImageTools.h"
#import <Photos/Photos.h>

@interface YJPictureTableViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet YJProgressView *progressView;


@end

@implementation YJPictureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view insertSubview:self.scrollView atIndex:0];
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick:)]];
    self.scrollView.delegate = self;
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //图片尺寸
    CGFloat pictureW = YJScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > YJScreenH) {
        //图片显示高度超过一个屏幕,屏幕需要滚动查看
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(pictureW, pictureH);
    } else {
        self.imageView.yj_size = CGSizeMake(pictureW, pictureH);
        self.imageView.yj_centerY = YJScreenH * 0.5;
    }
    //马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    
    //图片解析
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    //设置图片的缩放比例
    if (self.topic.width >imageView.yj_width) {
        self.scrollView.maximumZoomScale = self.topic.width/imageView.yj_width * 1.0;
        
    }
    self.scrollView.minimumZoomScale = 1.0;
    
}

//- (YJTopicTypeAll)type{
//    return YJTopicTypePic;
//}

- (IBAction)backClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)saveClick:(UIButton *)sender {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:{
            NSLog(@"未授权");
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusDenied){
                    NSLog(@"打开访问相册的开关：设置-隐私-相册-当前应用的名称");
                } else {
                    [YJSaveImageTools saveImageToCustomCollection:self.imageView.image title:@"" success:^{
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    } failure:^{
                        [SVProgressHUD showErrorWithStatus:@"保存失败"];
                    }];
                    NSLog(@"允许访问相册");
                }
            }];
        }
            break;
        case PHAuthorizationStatusRestricted:
            NSLog(@"受限制");
            break;
        case PHAuthorizationStatusDenied:
            NSLog(@"拒绝");
            NSLog(@"打开访问相册的开关：设置-隐私-相册-当前应用的名称");
            break;
        case PHAuthorizationStatusAuthorized:
            NSLog(@"允许");
            [YJSaveImageTools saveImageToCustomCollection:self.imageView.image title:@"" success:^{
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            } failure:^{
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            }];
            break;
        default:
            break;
    }
}

+(instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}









@end
