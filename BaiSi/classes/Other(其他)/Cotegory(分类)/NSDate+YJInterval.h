//
//  NSDate+YJInterval.h
//  时间
//
//  Created by 高方秋 on 2016/10/9.
//  Copyright © 2016年 fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YJInterval)

/**
 *  判断某个时间是否为今年
 */
-(BOOL)isThisYear;
/**
 *  判断是否为昨天
 */
-(BOOL)isYesterday;
/**
 *  判断是否为今天
 */
-(BOOL)isToday;







@end
