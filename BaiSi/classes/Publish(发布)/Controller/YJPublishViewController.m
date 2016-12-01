//
//  YJPublishViewController.m
//  BaiSi
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJPublishViewController.h"
#import "YJSquareButton.h"
#import <POP.h>
#import "YJSquareButton.h"



@interface YJPublishViewController ()

//自定义的uibutton
@property (nonatomic,strong)YJSquareButton *loginbtn;
//图片
@property (nonatomic,weak)UIImageView *imageview;
//时间的数组
@property (nonatomic,strong)NSArray *times;
//用来保存按键的数组
@property (nonatomic,strong)NSMutableArray *titleBtns;

@end

@implementation YJPublishViewController

/**
// pop和Core Animation的区别
// 1.Core Animation的动画只能添加到layer上
// 2.pop的动画能添加到任何对象
// 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
// 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
// 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */
- (NSArray *)times{
    if (_times == nil) {
        _times = @[@(0.5),@(0.4),@(0.3),@(0.2),@(0),@(0.1),@(0.6)];
    }
    return _times;
    
    
}
- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //添加按键的动画
    [self addAllTitleBtn];
    //添加图片的动画
    [self addImage];

    
}
#pragma mark -- 添加所有的按钮
- (void)addAllTitleBtn{
    NSArray *titleImage = @[@"mine_icon_nearby",@"mine_icon_random",@"mine-icon-activity",@"mine-icon-feedback",@"mine-icon-manhua",@"mine-icon-nearby"];
    NSArray *titleTitle = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"发链接"];
    for (int i = 0; i < titleImage.count; i++) {
        YJSquareButton *loginbtn = [[YJSquareButton alloc]init];
        self.loginbtn = loginbtn;
        [loginbtn setImage:[UIImage imageNamed:titleImage[i] ] forState:UIControlStateNormal];
        [loginbtn setTitle:titleTitle[i] forState:UIControlStateNormal];
        [loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginbtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchDown];
        //行数
        NSInteger row = 2;
        //列数
        NSInteger colom = 3;
        CGFloat titlebtnW = YJScreenW/colom;
        CGFloat titlebtnH = titlebtnW;
        CGFloat startY = YJScreenH * 0.5 - titlebtnH;
        CGFloat x = i%colom * titlebtnW;
        CGFloat y = startY + i  / colom *titlebtnH;
        loginbtn.frame = CGRectMake(x,  y- YJScreenH, titlebtnW, titlebtnH);
        [self.view addSubview:loginbtn];
        [self.titleBtns addObject:loginbtn];
        //给titlebtn添加动画
        POPSpringAnimation *anmi = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anmi.fromValue = [NSValue valueWithCGRect:loginbtn.frame];
        anmi.toValue = [NSValue valueWithCGRect:CGRectMake(x, y, titlebtnW, titlebtnH)];
        anmi.springBounciness = 10;
        anmi.springSpeed = 10;
        anmi.beginTime = CACurrentMediaTime() + [self.times[i] floatValue];
        [loginbtn pop_addAnimation:anmi forKey:nil];
        
    }
    
}
#pragma mark -- 添加图片和动画
- (void)addImage{
    //添加图片和动画
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@""];
    self.imageview = imageview;
    imageview.yj_width = 202;
    imageview.yj_height = 20;
    imageview.yj_y = 0.2 * YJScreenH - YJScreenH;
    imageview.yj_centerX = YJScreenW * 0.5;
    [self.view addSubview:imageview];
    
    POPSpringAnimation *anmi = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anmi.springBounciness = 10;
    anmi.springSpeed = 10;
    anmi.beginTime =  CACurrentMediaTime() + [self.times.lastObject floatValue];;
    anmi.fromValue = @(0.2 * YJScreenH - YJScreenH);
    anmi.toValue = @(0.2 * YJScreenH);
    [imageview pop_addAnimation:anmi forKey:nil];
}

#pragma mark -- 点击每一个按键 并退出动画
- (void)loginBtnClick:(UIButton *)btn{
    
    [self exit:^{
        NSLog(@"btn = %@",btn.titleLabel.text);
    }];
}

#pragma mark -- 点击取消的功能
- (IBAction)chanle:(UIButton *)sender {
    [self exit:nil];
}


- (void)exit:(void(^)())task{
    for (int i = 0; i < self.titleBtns.count; i++) {
        YJSquareButton *loginbtn = self.titleBtns[i];
        //取消6个按键
        POPSpringAnimation *anmi = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anmi.fromValue = [NSValue valueWithCGRect:loginbtn.frame] ;
        anmi.toValue = [NSValue valueWithCGRect:CGRectMake(loginbtn.yj_x, loginbtn.yj_y + YJScreenH, loginbtn.yj_width, loginbtn.yj_height)];
        anmi.springBounciness = 10;
        anmi.springSpeed = 10;
        anmi.beginTime =CACurrentMediaTime() + [self.times[i] floatValue] ;
        [loginbtn pop_addAnimation:anmi forKey:nil];
    }
    
    //取消图片
    POPSpringAnimation *anmi1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anmi1.springBounciness = 10;
    anmi1.springSpeed = 10;
    anmi1.beginTime = 1;
    anmi1.fromValue = @(self.imageview.yj_y);
    anmi1.toValue = @(self.imageview.yj_height + YJScreenH);
    anmi1.beginTime = CACurrentMediaTime() + [self.times.lastObject floatValue];
    
    
    //当执行取消了6个按键的功能之后的取消该控制器
    [anmi1 setCompletionBlock:^(POPAnimation * anmi, BOOL iscomplection) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if (task) {
            task();
        }
    }];
    [self.imageview pop_addAnimation:anmi1 forKey:nil];
}



@end
