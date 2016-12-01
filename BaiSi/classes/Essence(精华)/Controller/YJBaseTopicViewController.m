//
//  YJBaseTopicViewController.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/7.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJBaseTopicViewController.h"
#import "AFNetworking.h"
#import "YJTopic.h"
#import "MJExtension.h"
#import "YJTopicCell.h"
#import "MJRefresh.h"
#import "YJCommendViewController.h"
#import "YJVideoView.h"
#import "YJNewViewController.h"
#import "YJGlobel.h"
#import "YJBannerView.h"
#import "YJCacheData.h"


@interface YJBaseTopicViewController ()<YJBannerViewDelegate>

/** topic数组 **/
@property (nonatomic,strong)NSMutableArray *topicArr;
/** mgr **/
@property (nonatomic,strong)AFHTTPSessionManager *mgr;
@property (nonatomic,strong)NSDictionary *params;
/** 页码*/
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数*/
@property (nonatomic, copy) NSString *maxtime;
/** 上一次选中 tabBar 的索引*/
@property (nonatomic, assign) NSInteger lastSelectedIndex;
/** 广告轮播图 **/
@property (nonatomic,strong) YJBannerView *bannerView;
/** 网络管理者 */
@property (nonatomic,strong) AFNetworkReachabilityManager *networkMgr;
// 返回a参数的值
- (NSString *)aParam;
@property (nonatomic,strong)YJVideoView *videoView;


@end

static NSString *cellId = @"topicCell";

@implementation YJBaseTopicViewController

#pragma mark - lazy

- (AFHTTPSessionManager *)mgr{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

- (AFNetworkReachabilityManager *)networkMgr
{
    if (!_networkMgr) {
        _networkMgr = [AFNetworkReachabilityManager manager];
    }
    return _networkMgr;
}


-(NSMutableArray *)topicArr{
    if (_topicArr == nil) {
        _topicArr = [[NSMutableArray alloc] init];
    }
    return _topicArr;
}

// 返回请求数据的类型
- (YJTopicTypeAll)type
{
    // 基类里随便返回一个值
    return 0;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [YJTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    //设置tableview
    [self setUpTableView];
    //通知方式去监测点击tabbar
    // 监听 tabBar 点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:YJTabBarDidSelectedNotification object:nil];
    
}

- (void)addAdView{
    //设置广告轮播
        // 创建自定义广告轮播view
    YJBannerView *bannerView = [[YJBannerView alloc] init];
    bannerView.yj_width = YJScreenW;
    bannerView.yj_height = 120;
            // 设置广告图片
    bannerView.imageNames = @[@"01",@"02",@"03",@"04",@"05",@"06"];
    bannerView.delegate = self;
    self.tableView.tableHeaderView = bannerView;

}
//点击广告的代理事件
- (void)bannerViewClick:(NSInteger)index{
    
    NSLog(@"%ld",index);
}

- (void)setUpTableView{
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJTopicCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.rowHeight = 350;
    //添加刷新控件
    [self setupRefresh];
    
    //自定义cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = YJBgColor;

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);
    //设置添加广告view
    [self addAdView];
    
}

//接收到标题按钮重复点击发送的通知的时候调用
- (void)tabBarSelected{
    //[self.tableView.mj_header beginRefreshing];
    //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
    if (self.lastSelectedIndex != self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
        NSLog(@"%@--%@",self,self.parentViewController);
    };

    self.lastSelectedIndex = self.tabBarController.selectedIndex;

}



#pragma mark 添加刷新控件
-(void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}
#pragma mark - aParam 参数
- (NSString *)aParam {
    return [self.parentViewController isKindOfClass:[YJNewViewController class]] ? @"newlist" : @"list";
}


- (void)loadData{
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    YJWeakSelf;
    //请求参数
    NSDictionary *params = @{
                             @"a":self.aParam,
                             @"c":@"data",
                             @"type":@(self.type),
                             };
    
    [self.mgr GET:YJHostUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject);
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        weakSelf.topicArr = [YJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error -- %@",error);
        // 如果没有网络从本地数据获取数据(离线数据)
        // 从数据库获取帖子数据
        self.topicArr = [YJCacheData topicsWithType:self.type];
        NSLog(@"topicArr---%@",self.topicArr);
        self.page = 1;
        // 刷新tableView
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        self.page--;
        
    }];
    
}

#pragma mark 加载更多数据
-(void)loadMoreTopics {
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    
    YJWeakSelf;
    if (self.maxtime == nil) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        // 如果没有网络从本地数据获取数据(离线数据)
        NSArray *moreTopics = [YJCacheData topicsWithPage:self.page type:self.type];
        [self.topicArr addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        
        self.page ++;
        return;
    }
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    // 发送请求给服务器
    [self.mgr GET:YJHostUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        
        NSArray *newTopics = [YJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicArr addObjectsFromArray:newTopics];
        //刷新表格
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        // 如果没有网络从本地数据获取数据(离线数据)
        NSArray *moreTopics = [YJCacheData topicsWithPage:self.page type:self.type];
        [self.topicArr addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        
        self.page ++;
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    self.tableView.mj_footer.hidden = (self.topicArr.count == 0);
    return self.topicArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    YJTopic *topic = self.topicArr[indexPath.row];
    cell.topic = topic;
//    if (topic.type == YJTopicTypeVideo) {
//        cell.videoView.tableView = tableView;
//        cell.videoView.indexPath = indexPath;
//        
//    }
    // 设置cell的选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取模型
    YJTopic *topic = self.topicArr[indexPath.row];
    return topic.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YJCommendViewController *commentVC = [[YJCommendViewController alloc] init];
    commentVC.topic = self.topicArr[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 在控制器的view将要消失的是时候保存数据
- (void)viewWillDisappear:(BOOL)animated
{
    // 将帖子模型数据全部保存到数据库
    for (YJTopic *topic in self.topicArr) {
        [YJCacheData saveTopic:topic];
    }
}


#pragma mark -- 已经结束显示的cell进行的操作
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissCellViewVC" object:cell];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.videoView removeFromSuperview];
    
}





@end
