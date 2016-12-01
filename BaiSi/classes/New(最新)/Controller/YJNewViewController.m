
#import "YJNewViewController.h"
#import "UIBarButtonItem+Item.h"
#import "YJSubTagTableViewController.h"

@interface YJNewViewController ()

@end

@implementation YJNewViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置随机颜色
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256)/255.0) green:(arc4random_uniform(256)/255.0) blue:(arc4random_uniform(256)/255.0) alpha:1.0];
    
    // 设置导航条左侧的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] addTarget:self action:@selector(leftClick)];
//    // 设置导航条的标题图片
//    UIImage *image = [UIImage imageNamed:@"MainTitle"];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    
}

// 导航条左侧按钮点击调用
- (void)leftClick
{
    YJSubTagTableViewController *subTagVc = [[YJSubTagTableViewController alloc] init];
    subTagVc.title = @"推荐";
    //recommendVc.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController pushViewController:subTagVc animated:YES];
        
}


//#pragma mark 底部的scrollview
//-(void)setupContentView {
//    //不要自动调整inset
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    
//    UIScrollView *contentView = [[UIScrollView alloc] init];
//    contentView.frame = self.view.bounds;
//    contentView.delegate = self;
//    contentView.contentSize = CGSizeMake(contentView.yj_width * self.childViewControllers.count, 0);
//    contentView.pagingEnabled = YES;
//    [self.view insertSubview:contentView atIndex:0];
//    self.contentView1 = contentView;
//    //添加第一个控制器的view
//    [self scrollViewDidEndScrollingAnimation:contentView];
//}
//
//
//#pragma mark  初始化子控制器
//-(void)setupChildViewControllers {
//    YJNewTopViewController *allVc = [[YJNewTopViewController alloc]init];
//    allVc.title = @"全部";
//    [self addChildViewController:allVc];
//    YJNewTopViewController *videoVc = [[YJNewTopViewController alloc]init];
//    videoVc.title = @"视频";
//    [self addChildViewController:videoVc];
//    YJNewTopViewController *picVc = [[YJNewTopViewController alloc]init];
//    picVc.title = @"图片";
//    [self addChildViewController:picVc];
//    YJNewTopViewController *voiceVc = [[YJNewTopViewController alloc]init];
//    voiceVc.title = @"声音";
//    [self addChildViewController:voiceVc];
//    YJNewTopViewController *talkVc = [[YJNewTopViewController alloc]init];
//    talkVc.title = @"段子";
//    [self addChildViewController:talkVc];
//}
//
//#pragma mark 设置顶部标签栏
//-(void)setupTitlesView {
//    //标签栏
//    UIView *titlesView = [[UIView alloc] init];
//    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
//    titlesView.frame = CGRectMake(0, 64, YJScreenW, 35);
//    [self.view addSubview:titlesView];
//    self.titlesView = titlesView;
//    
//    //底部红色指示器
//    UIView *indicatorView = [[UIView alloc] init];
//    indicatorView.backgroundColor = [UIColor redColor];
//    indicatorView.yj_height = 2;
//    indicatorView.tag = -1;
//    indicatorView.yj_y = titlesView.yj_height - indicatorView.yj_height;
//    self.indicatorView1 = indicatorView;
//    
//    //内部子标签
//    NSInteger count = self.childViewControllers.count;
//    CGFloat width = titlesView.yj_width / count;
//    CGFloat height = titlesView.yj_height;
//    for (int i = 0; i < count; i++) {
//        UIButton *button = [[UIButton alloc] init];
//        button.yj_height = height;
//        button.yj_width = width;
//        button.yj_x = i * width;
//        button.tag = i;
//        UIViewController *vc = self.childViewControllers[i];
//        [button setTitle:vc.title forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
//        button.titleLabel.font = [UIFont systemFontOfSize:14];
//        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
//        [titlesView addSubview:button];
//        
//        //默认点击了第一个按钮
//        if (i == 0) {
//            button.enabled = NO;
//            self.selectedButton1 = button;
//            //让按钮内部的Label根据文字来计算内容
//            [button.titleLabel sizeToFit];
//            self.indicatorView1.yj_width = button.titleLabel.yj_width;
//            self.indicatorView1.yj_centerX = button.yj_centerX;
//        }
//    }
//    [titlesView addSubview:indicatorView];
//}
//
//#pragma mark 便签栏按钮点击
//-(void)titleClick:(UIButton *)button {
//    //修改按钮状态
//    self.selectedButton1.enabled = YES;
//    button.enabled = NO;
//    self.selectedButton1 = button;
//    //让标签执行动画
//    [UIView animateWithDuration:0.25 animations:^{
//        self.indicatorView1.yj_width = self.selectedButton1.titleLabel.yj_width;
//        self.indicatorView1.yj_centerX = self.selectedButton1.yj_centerX;
//    }];
//    //滚动,切换子控制器
//    CGPoint offset = self.contentView1.contentOffset;
//    offset.x = button.tag * self.contentView1.yj_width;
//    [self.contentView1 setContentOffset:offset animated:YES];
//}
//
//
//#pragma mark -UIScrollViewDelegate
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    //添加子控制器的view
//    //当前索引
//    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
//    //取出子控制器
//    UIViewController *vc = self.childViewControllers[index];
//    vc.view.yj_x = scrollView.contentOffset.x;
//    vc.view.yj_y = 0;//设置控制器的y值为0(默认为20)
//    vc.view.yj_height = scrollView.yj_height;//设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
//    [scrollView addSubview:vc.view];
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self scrollViewDidEndScrollingAnimation:scrollView];
//    //当前索引
//    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
//    //点击button
//    [self titleClick:self.titlesView.subviews[index]];
//}










@end
