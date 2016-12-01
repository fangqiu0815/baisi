//
//  YJGlobel.m
//  BaiSi
//
//  Created by Apple on 16/10/7.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJGlobel.h"

@implementation YJGlobel
/** 导航条最大的Y值 */
const NSInteger YJMaxNavY = 64;
/** 标题栏的高度 */
const NSInteger YJTitleViewH = 35;
/** tabBar的高度 */
const NSInteger YJTabBarH = 49;
/** 通用间隔 */
const NSInteger YJMargin = 10;

/** tabBar 被点击的通知 */
 NSString *const YJTabBarDidSelectedNotification = @"YJTabBarDidSelectedNotification";
/** tabBar 被点击的通知 - 被点击的控制器的 index key */
 NSString *const YJSelectedControllerIndexKey = @"YJSelectedControllerIndexKey";
/** tabBar 被点击的通知 - 被点击的控制器 key */
 NSString *const YJSelectedControllerKey = @"YJSelectedControllerKey";

///** tabBar 被点击的通知*/
//NSString *const YJTabBarDidSelectedNotification = @"YJTabBarDidSelectedNotification";
///** tabBar 被点击的通知 - 被点击的控制器的 index key*/
//NSString *const YJSelectedControllerIndexKey = @"YJSelectedControllerIndexKey";
///** tabBar 被点击的通知 - 被点击的控制器 key*/
//NSString *const YJSelectedControllerKey = @"YJSelectedControllerKey";





@end
