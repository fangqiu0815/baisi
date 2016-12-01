


#import "YJMeViewController.h"
#import "UIBarButtonItem+Item.h"
#import "YJSettingViewController.h"
#import "YJMineFooterView.h"
#import "YJMineTableViewCell.h"

static NSString *mineID = @"mine";

@implementation YJMeViewController
- (void)viewDidLoad
{
//    // 设置随机颜色
//    self.view.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256)/255.0) green:(arc4random_uniform(256)/255.0) blue:(arc4random_uniform(256)/255.0) alpha:1.0];
    
    // 设置导航条内容
    [self setupNavBar];
    
    [self setupTableView];
}

#pragma mark - 设置导航条内容
- (void)setupNavBar
{
    
    // 设置导航条右侧的按钮
    // 创建夜间模式按钮
    UIBarButtonItem *nigthItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(nigthClick:)];
    
    // 创建设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] addTarget:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nigthItem];
    
    // 设置导航条的标题
    self.navigationItem.title = @"我的";
    
    
    // 设置下一个控制器的返回按钮
    // 注意:设置返回按钮在上一个界面设置才有效果，在当前控制器是没有效果
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
   
}

// 导航条夜间模式按钮点击事件
- (void)nigthClick:(UIButton *)btn
{
    NSLog(@"%s",__func__);
    btn.selected = !btn.selected;
}

// 导航条设置按钮点击事件
- (void)settingClick
{
    // 创建设置控制器
    YJSettingViewController *settingVc = [[YJSettingViewController alloc] init];
    
        
    // 点击设置按钮跳转到设置控制器
    [self.navigationController pushViewController:settingVc animated:YES];
}


-(void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YJMineTableViewCell class] forCellReuseIdentifier:mineID];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    //设置footerView
    self.tableView.tableFooterView = [[YJMineFooterView alloc] initWithFrame:CGRectMake(0, 0, YJScreenW, YJScreenH + 200)];
    //self.tableView.bounces = NO;
}

#pragma mark 导航栏左边的按钮点击
-(void)coinButtonClick {
    YJLogFunc;
}

#pragma mark 导航栏夜间模式按钮点击
-(void)moonButtonClick {
    YJLogFunc;
}

#pragma mark 导航栏右边设置的按钮点击
-(void)settingButtonClick {
    YJLogFunc;
}

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineID];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 1) {
//        YJMineFooterView *mineView = [[YJMineFooterView alloc]initWithFrame:CGRectMake(0, 0, YJScreenW, YJScreenH)];
//    }
//    return mineView;
//}










@end
