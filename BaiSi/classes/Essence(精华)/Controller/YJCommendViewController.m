#import "YJCommendViewController.h"
#import "UIBarButtonItem+Item.h"
#import "YJTopicCell.h"
#import "YJTopic.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "YJComment.h"
#import "MJExtension.h"
#import "YJCommentHeaderView.h"
#import "YJCommentCell.h"
#import "SVProgressHUD.h"
#import "YJUser.h"

static NSString *const commentID = @"comment";

@interface YJCommendViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 工具条底部间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论*/
@property (nonatomic, strong) NSArray *hotComments;

/** 最新评论*/
@property (nonatomic, strong) NSMutableArray *lastestComments;

/** 保存top_cmt*/
@property (nonatomic, strong) YJComment *saved_top_cmt;
/** 保存当前页码*/
@property (nonatomic, assign) NSInteger page;
/** 请求管理者*/
@property (nonatomic, strong) AFHTTPSessionManager *manager;



@end

@implementation YJCommendViewController

#pragma mark lazy
-(AFHTTPSessionManager *)manager{
    if (!_manager ) {
        _manager = [[AFHTTPSessionManager alloc] init];
    }
    return _manager;
}

-(NSMutableArray *)lastestComments{
    if (_lastestComments == nil) {
        _lastestComments = [[NSMutableArray alloc] init];
    }
    return _lastestComments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
    //监听键盘frame变化(通知的方式)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

#pragma mark - 当键盘frame改变的时候调用
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    YJLogFunc
    
    //键盘显示/隐藏完毕的frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = YJScreenH - frame.origin.y;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 设置基础
-(void)setupBasic {
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"comment_nav_item_share_icon"] highImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click" ] addTarget:self action:@selector(actionSheet)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJCommentCell class]) bundle:nil] forCellReuseIdentifier:commentID];
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}




- (void)actionSheet{
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle: nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil];
    [sheet addAction:cancelAction];
    [sheet addAction:shareAction];
    [sheet addAction:okAction];
    
    [self presentViewController:sheet animated:YES completion:nil];

}


-(void)setupHeader {
    UIView *header = [[UIView alloc] init];
    
    //清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    YJTopicCell *cell = [YJTopicCell cell];
    cell.topic = self.topic;;
    cell.yj_height = self.topic.cellHeight;
    cell.yj_width = YJScreenW;
    [header addSubview:cell];
    header.yj_height = self.topic.cellHeight + 10;
    self.tableView.tableHeaderView = header;
    self.tableView.backgroundColor = YJColor(233, 233, 233);
}




-(void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    //    self.tableView.mj_footer.hidden = YES;
}

-(void)loadNewComments {
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"hot"] = @"1";
    params[@"data_id"] = @(self.topic.ID);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //页码
        self.page = 1;
        //说明没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        //最热评论
        self.hotComments = [YJComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.lastestComments = [YJComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        //控制footer的状态 判断最新评论是否全部显示
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastestComments.count > total) { //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!"];
    }];
}

-(void)loadMoreComments {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = @(self.topic.ID);
    YJComment *comment = [self.lastestComments lastObject];
    params[@"lastid"] = comment.ID;
    params[@"page"] = @(page);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //说明没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return ;
        }

        //最新评论
        NSArray *newComments = [YJComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.lastestComments addObjectsFromArray:newComments];
        
        [self.tableView reloadData];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastestComments.count > total) { //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else { //数据满了，结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!"];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastestCount = self.lastestComments.count;
    if (hotCount) return 2; //有最热评论+最新评论  2组
    if (lastestCount) return 1; //最新评论  1组
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastestCount = self.lastestComments.count;
    
    tableView.mj_footer.hidden = (lastestCount == 0);
    if (section == 0) {
        return hotCount ? hotCount : self.lastestComments.count;
    }
    return self.lastestComments.count;
}

 //  header如果是个view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //先从缓存池中找
    YJCommentHeaderView *header = [YJCommentHeaderView headerViewTableView:tableView];
    
    if (section == 0) {
        header.title = self.hotComments.count?@"最热评论":@"最新评论";
    } else {
        header.title = @"评论";
    }
    return header;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section == 0&&self.hotComments.count) {
//        return @"最热评论";
//    } else {
//        return @"最新评论";
//    }
//}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}

/**
 *  返回第section组的所有评论
 */
-(NSArray *)commentInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.lastestComments;
    }
    return self.lastestComments;
}

-(YJComment *)commentInIndexPath:(NSIndexPath *)indexPath {
    return [self commentInSection:indexPath.section][indexPath.row];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //回复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    //取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取当前的cell
    YJCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //设置菜单控制器
    UIMenuController *menuC = [UIMenuController sharedMenuController];
    menuC.menuItems = @[
                        [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(dingClick)],
                        [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replyClick)],
                        [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(warnClick)]
                        ];
    //设置菜单显示的位置
    CGRect rect = CGRectMake(0, cell.yj_height * 0.5, cell.yj_width, 1);
    [menuC setTargetRect:rect inView:cell];
    //显示菜单
    [menuC setMenuVisible:YES animated:YES];
}
//是否可以获得到焦点
- (BOOL)canBecomeFirstResponder{
    return YES;
}

//是否显示添加的菜单选项
//YES 显示菜单 NO 不显示菜单
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (!self.isFirstResponder) {
        //控制器不是第一响应者就不要显示添加的菜单选项
        //判断是不是系统自带的menu的action
        if (action == @selector(dingClick)||action == @selector(replyClick)||action == @selector(warnClick)) {
            return NO;
        }
        
    }
    //返回值不能是yes 应该是系统自带的完整的方法名
    return [super canPerformAction:action withSender:sender];
}

- (YJComment *)selectedcomment{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    YJComment *comment = nil;
    if (self.hotComments.count && indexPath.section == 0) {
        comment = self.hotComments[indexPath.row ];
    }else{
        comment = self.lastestComments[indexPath.row];
    }
    return comment;

}

#pragma mark - 顶操作
- (void)dingClick{
    YJLogFunc
    YJComment *comment = [self selectedcomment];
    NSLog( @"顶-------%@--%@",comment.user.username,comment.content);
    
}

#pragma mark - 回复操作
- (void)replyClick{
    YJLogFunc
    YJComment *comment = [self selectedcomment];
    NSLog( @"回复-------%@--%@",comment.user.username,comment.content);
}

#pragma mark - 举报操作
- (void)warnClick{
    YJLogFunc
    YJComment *comment = [self selectedcomment];
    NSLog( @"举报-------%@--%@",comment.user.username,comment.content);
}



@end
