

#import "YJLoginRegisterController.h"
#import "YJLoginRegisterBtn.h"
//#import "UMSocialData.h"
//#import "UMSocialSnsService.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocialConfig.h"
//#import "UMSocialSnsPlatformManager.h"
//#import "UMSocialDataService.h"
//#import "UMSocialAccountManager.h"

@interface YJLoginRegisterController ()//<UMSocialUIDelegate>

/** 登录框距离控制器view左边的距离*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation YJLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.bgView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 当前控制器的状态栏为白色
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)showLoginOrRegister:(UIButton *)sender {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { //显示注册界面
        self.loginViewLeftMargin.constant = -self.view.yj_width;
        sender.selected = YES;
    } else {
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutSubviews];
    }];
}

- (IBAction)exitButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)QQClick:(YJLoginRegisterBtn *)sender {
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
//    
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        
//        //          获取微博用户名、uid、token等
//        
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            
//            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//            
//        }});
//    
//
//    
//    
//    
    
    
}

- (IBAction)WeiBoClick:(YJLoginRegisterBtn *)sender {
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//    
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        
//        //          获取微博用户名、uid、token等
//        
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            
//            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//            
//        }});
//    
//    
//    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
//        NSLog(@"response is %@",response);
//    }];

    
}

- (IBAction)tencentClick:(YJLoginRegisterBtn *)sender {
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//    
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            
//            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//            
//        }
//        
//    });
//
    
    
    
    
    
}







@end
