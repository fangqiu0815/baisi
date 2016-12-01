//
//  UIBarButtonItem+Item.h
//  BaiSi
//
//  Created by mac on 16/6/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

/**
 *  高亮按钮
 *
 *  @param image     普通图片
 *  @param highImage 高亮图片
 *  @param target    目标对象
 *  @param action    点击的方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action;

/**
 *  选中按钮
 *
 *  @param image     普通图片
 *  @param selImage  选中图片
 *  @param target    目标对象
 *  @param action    点击的方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image selImage:(UIImage *)selImage addTarget:(id)target action:(SEL)action;

/**
 *  返回按钮
 *
 *  @param image     普通图片
 *  @param selImage  选中图片
 *  @param target    目标对象
 *  @param action    点击的方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage title:(NSString *)title addTarget:(id)target action:(SEL)action;













@end
