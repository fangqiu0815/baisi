

#import "YJEssenceViewController.h"
#import "UIBarButtonItem+Item.h"
#import "YJAllTableViewController.h"
#import "YJVideoTableViewController.h"
#import "YJPictureTableViewController.h"
#import "YJVoiceTableViewController.h"
#import "YJTalkTableViewController.h"
#import "UIView+Frame.h"
#import "YJShowTopicPicViewController.h"
#import "YJGlobel.h"

@interface YJEssenceViewController ()<UIScrollViewDelegate>

/** 标签栏底部指示器*/
@property (nonatomic, weak) UIView *indicatorView;

/** 当前选中的按钮*/
@property (nonatomic, weak) UIButton *selectedButton;

/** 顶部的标签*/
@property (nonatomic, weak) UIView *titlesView;
/** UIScrollView*/
@property (nonatomic, weak) UIScrollView *contentView;
//
@property (nonatomic,strong) UIButton *preBtn ;
@end


@implementation YJEssenceViewController
- (void)viewDidLoad
{
    // 设置随机颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条的内容
    // 设置导航条左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"game"] highImage:[UIImage imageNamed:@"game1"] addTarget:self action:@selector(gameClick)];
    // 设置导航条右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"other"] highImage:[UIImage imageNamed:@"other1"] addTarget:self action:@selector(randomClick)];
    //45 130 211
//    // 设置导航条的标题图片
//    UIButton *baisiBtn = [[UIButton alloc]init];
//    [baisiBtn setImage:[UIImage imageNamed:@"丑丑段子手"] forState:UIControlStateNormal];
//    //[baisiBtn setImage:[UIImage imageNamed:@"丑丑段子手1"] forState:UIControlStateHighlighted];
//    [baisiBtn sizeToFit];
//   // UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.title = @"天天段子手";
    //设置顶部标签
    [self setupChildViewControllers];
    //设置顶部标签栏
    [self setupTitlesView];
    //底部的scrollview
    [self setupContentView];
   // YJLog(@"自定义log");
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}



// 导航条左侧按钮点击事件
- (void)gameClick
{
    NSLog(@"%s",__func__);
}

// 导航条右侧按钮点击事件
- (void)randomClick
{
    NSLog(@"%s",__func__);
}

#pragma mark 底部的scrollview
-(void)setupContentView {
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(contentView.yj_width * self.childViewControllers.count, 0);
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}


#pragma mark  初始化子控制器
-(void)setupChildViewControllers {
    YJAllTableViewController *allVc = [[YJAllTableViewController alloc]init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    YJVideoTableViewController *videoVc = [[YJVideoTableViewController alloc]init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    YJShowTopicPicViewController *picVc = [[YJShowTopicPicViewController alloc]init];
    picVc.title = @"图片";
    [self addChildViewController:picVc];
    YJVoiceTableViewController *voiceVc = [[YJVoiceTableViewController alloc]init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    YJTalkTableViewController *talkVc = [[YJTalkTableViewController alloc]init];
    talkVc.title = @"段子";
    [self addChildViewController:talkVc];
    
    
}

#pragma mark 设置顶部标签栏
-(void)setupTitlesView {
    //标签栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    titlesView.frame = CGRectMake(0, 64, YJScreenW, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = YJColor(45, 130, 211);
    //45 130 211
    indicatorView.yj_height = 2;
    indicatorView.tag = -1;
    indicatorView.yj_y = titlesView.yj_height - indicatorView.yj_height;
    self.indicatorView = indicatorView;
    
    //内部子标签
    NSInteger count = self.childViewControllers.count;
    CGFloat width = titlesView.yj_width / count;
    CGFloat height = titlesView.yj_height;
    for (int i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.yj_height = height;
        button.yj_width = width;
        button.yj_x = i * width;
        button.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:YJColor(45, 130, 211) forState:UIControlStateDisabled];
       // YJColor(45, 130, 211)
         button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            //让按钮内部的Label根据文字来计算内容
            [button.titleLabel sizeToFit];
            self.indicatorView.yj_width = button.titleLabel.yj_width;
            self.indicatorView.yj_centerX = button.yj_centerX;
        }
        
//        //给UITarBarButton 添加点击事件
//        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
//        if (i == 0) {
//            self.preBtn = button;
//        }
        
    }
    [titlesView addSubview:indicatorView];
}

#pragma mark 便签栏按钮点击
-(void)titleClick:(UIButton *)button {
//    //修改按钮状态
//    if (button == self.preBtn) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:YJTabBarDidSelectedNotification object:nil];
//    }
//    self.preBtn = button;
    
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    //让标签执行动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.yj_width = self.selectedButton.titleLabel.yj_width;
        self.indicatorView.yj_centerX = self.selectedButton.yj_centerX;
    }];
    //滚动,切换子控制器
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.yj_width;
    [self.contentView setContentOffset:offset animated:YES];
}


#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //添加子控制器的view
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
    //取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.yj_x = scrollView.contentOffset.x;
    vc.view.yj_y = 0;//设置控制器的y值为0(默认为20)
    vc.view.yj_height = scrollView.yj_height;//设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
    [scrollView addSubview:vc.view];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
    //点击button
    [self titleClick:self.titlesView.subviews[index]];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//计算拖拽比例
    CGFloat ratio = scrollView.contentOffset.x/scrollView.yj_width;
    //将整数部分减掉，保留小数部分的比例
    ratio = ratio - self.selectedButton.tag;
    //设置下划线的centerX
    self.indicatorView.yj_centerX = self.selectedButton.yj_centerX + ratio*self.selectedButton.yj_width;
    
}







@end
