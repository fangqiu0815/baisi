//
//  YJRecommandUserCell.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/5.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJRecommandUserCell.h"
#import "YJRecommandUser.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+YJImageExtension.h"

@interface YJRecommandUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation YJRecommandUserCell
//关注事件的点击方法
- (IBAction)attentionClick:(UIButton *)sender {

    NSLog(@"已关注");
}

- (void)setRecommandUser:(YJRecommandUser *)recommandUser{
    _recommandUser = recommandUser;
    //设置关注用户的名字
    self.nameLabel.text = recommandUser.screen_name;
    //设置粉丝数的处理方法
    if (recommandUser.fans_count < 10000) {
        self.detailLabel.text = [NSString stringWithFormat:@"%zd人关注",recommandUser.fans_count];
    } else {
        self.detailLabel.text = [NSString stringWithFormat:@"%.1f万人关注",recommandUser.fans_count / 10000.0];
    }
    //设置用户头像的圆角图片
    [self.iconImageView setCircleHeader:recommandUser.header];

}


@end
