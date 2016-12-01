//
//  YJProgressView.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/7.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJProgressView.h"

@implementation YJProgressView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}




@end
