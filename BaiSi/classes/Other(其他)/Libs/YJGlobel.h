//
//  YJGlobel.h
//  BaiSi
//
//  Created by Apple on 16/10/7.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJGlobel : NSObject
/** 常量类  */
/** 导航条最大的Y值 */
UIKIT_EXTERN const NSInteger YJMaxNavY;
/** 标题栏的高度 */
UIKIT_EXTERN const NSInteger YJTitleViewH;
/** tabBar的高度 */
UIKIT_EXTERN const NSInteger YJTabBarH;

/** 通用间隔 */
UIKIT_EXTERN const NSInteger YJMargin;

/** tabBar 被点击的通知 */
UIKIT_EXTERN NSString *const YJTabBarDidSelectedNotification;
/** tabBar 被点击的通知 - 被点击的控制器的 index key */
UIKIT_EXTERN  NSString *const YJSelectedControllerIndexKey;
/** tabBar 被点击的通知 - 被点击的控制器 key */
UIKIT_EXTERN  NSString *const YJSelectedControllerKey;






@end
