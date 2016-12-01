//
//  YJCommentHeaderView.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJCommentHeaderView.h"

@interface YJCommentHeaderView ()

/** 文字*/
@property (nonatomic, weak) UILabel *label;

@end


@implementation YJCommentHeaderView

+ (instancetype)headerViewTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    YJCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[self alloc] initWithReuseIdentifier:ID];
        
    }
    
    return header;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = YJColor(233, 233, 233);
        UILabel *label = [[UILabel alloc] init];
        label.yj_x = 10;
        label.yj_width = 200;
        label.frame = CGRectMake(10, 10, label.yj_width, label.yj_height);
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.textColor = YJColor(67, 67, 67);
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

@end
