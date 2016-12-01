//
//  YJTextField.m
//  BaiSi
//
//  Created by 高方秋 on 2016/9/26.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJTextField.h"

@implementation YJTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    //设置光标的颜色
    self.tintColor = [UIColor whiteColor];
    //设置编辑状态和费编辑状态文字颜色  占位文本的颜色
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:[UIColor lightGrayColor]
                           };
    //富文本的占位文字
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:dict];
    //监听textfeild的编辑模式
    //方式1.通知 2.代理 3.kvo 4.addTarget
    [self addTarget:self action:@selector(textBeginChange) forControlEvents:UIControlEventEditingDidBegin];
    //监听textfeild的结束编辑模式
    [self addTarget:self action:@selector(textEndChange) forControlEvents:UIControlEventEditingDidEnd];
    
}

- (void)textBeginChange{
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:[UIColor whiteColor]
                           };
    //富文本的占位文字
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:dict];
}

- (void)textEndChange{
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:[UIColor lightGrayColor]
                           };
    //富文本的占位文字
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:dict];

}


@end
