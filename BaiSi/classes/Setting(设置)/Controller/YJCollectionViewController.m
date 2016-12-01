//
//  YJCollectionViewController.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/20.
//
//

#import "YJCollectionViewController.h"
#import "YJTopicCell.h"
#import "YJTopic.h"
#import "YJCollectionCacheData.h"
#import "YJCommendViewController.h"

@interface YJCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *collectArr;

@end

static NSString *ID = @"cell";

@implementation YJCollectionViewController

#pragma mark - lazy
- (NSArray *)collectArr{
    if (_collectArr == nil) {
        _collectArr = [NSArray array];
    }
    return _collectArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //从数据库的收藏表里面获取收藏帖子的模型数组
    self.collectArr = [YJCollectionCacheData topics];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    //去掉额外的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置tableview的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 50, 0);
    self.tableView.backgroundColor = YJBgColor;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collectArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    YJTopic *topic = self.collectArr[indexPath.row];
    cell.topic = topic;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取模型
    YJTopic *topic = self.collectArr[indexPath.row];
    return topic.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YJCommendViewController *commentVC = [[YJCommendViewController alloc] init];
    commentVC.topic = self.collectArr[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}






@end
