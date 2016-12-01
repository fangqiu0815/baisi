//
//  YJLoginRegisterBtn.m
//  BaiSi
//
//  Created by 高方秋 on 16/9/25.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJLoginRegisterBtn.h"

@implementation YJLoginRegisterBtn

-(void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //调整图片
    self.imageView.yj_x = 0;
    self.imageView.yj_y = 0;
    self.imageView.yj_width = self.yj_width;
    self.imageView.yj_height = self.imageView.yj_width;
    //调整文字
    self.titleLabel.yj_x = 0;
    self.titleLabel.yj_y = self.imageView.yj_height;
    self.titleLabel.yj_width = self.yj_width;
    self.titleLabel.yj_height = self.yj_height - self.titleLabel.yj_y;
}

@end
