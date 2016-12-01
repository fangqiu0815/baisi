
#import "YJSubTagTableViewController.h"
#import "YJRecommend.h"
#import "YJRecommendTableViewCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"

@interface YJSubTagTableViewController ()

@property (nonatomic,strong) NSArray *recommendArr;
/** 会话管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *mgr;

@end

static NSString *ID = @"cell";
@implementation YJSubTagTableViewController

#pragma mark - lazy
- (AFHTTPSessionManager *)mgr
{
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 向服务器请求添加关注数据
    [self loadRecommendDatas];
    self.tableView.rowHeight = 80;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJRecommendTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //自定义分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = YJColor(182, 182, 182);
    
    
}
#pragma mark - 加载推荐数据
- (void)loadRecommendDatas{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //字典解析数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.recommendArr = [YJRecommend mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新表格
        [self.tableView reloadData];
        //隐藏指示器
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.recommend = self.recommendArr[indexPath.row];
    
    return cell;
}



@end
