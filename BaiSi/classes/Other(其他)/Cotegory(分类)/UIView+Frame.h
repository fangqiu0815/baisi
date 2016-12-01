//
//  UIView+Frame.h
//  BaiSi
//
//  Created by mac on 16/6/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
// 分类的特点：1.声明的属性不会生成成员变量，但是可以有setter和getter方法
@interface UIView (Frame)
// 宽度
@property CGFloat yj_width;
// 高度
@property CGFloat yj_height;
@property CGFloat yj_x;
@property CGFloat yj_y;
@property CGFloat yj_centerX;
@property CGFloat yj_centerY;
@property CGSize yj_size;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;


@end
















