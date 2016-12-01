//
//  YJRecommendTableViewCell.m
//  BaiSi
//
//  Created by 高方秋 on 16/9/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJRecommendTableViewCell.h"
#import "YJRecommend.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+YJImageExtension.h"

@interface YJRecommendTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@end

@implementation YJRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/*
 "theme_name": "生活百科",
 "image_list": "http:%/%/img.spriteapp.cn%/ugc%/2015%/04%/23%/160559_24190.jpg",
 "sub_number": "36871",
 */
#pragma mark - 设置推荐标签的数据
- (void)setRecommend:(YJRecommend *)recommend{
    _recommend = recommend;
    self.nameLabel.text = recommend.theme_name;
    if (recommend.sub_number < 10000) {
        self.accountLabel.text = [NSString stringWithFormat:@"%zd人关注",recommend.sub_number];
    } else {
        self.accountLabel.text = [NSString stringWithFormat:@"%.1f万人关注",recommend.sub_number / 10000.0];
    }
    // 设置图片数据
    [self.iconImageView setCircleHeader:recommend.image_list];
}

#pragma mark -  设置frame 就是自定义分割线
//- (void)setFrame:(CGRect)frame{
//
//    frame.size.height--;
//    [self setFrame:frame];
//
//}


@end
