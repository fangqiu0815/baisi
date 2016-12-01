//
//  NSDate+YJInterval.m
//  时间
//
//  Created by 高方秋 on 2016/10/9.
//  Copyright © 2016年 fangqiu. All rights reserved.
//

#import "NSDate+YJInterval.h"

@implementation NSDate (YJInterval)

/**
 *  判断某个时间是否为今年
 */
-(BOOL)isThisYear {
    NSCalendar *calender = [NSCalendar currentCalendar];
    //获得某个时间的年
    NSDateComponents *yearComps = [calender components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowComps = [calender components:NSCalendarUnitYear fromDate:[NSDate date]];
    return yearComps.year = nowComps.year;
}

/**
 *  判断是否为昨天
 */
-(BOOL)isYesterday {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //取得时间字符串
    NSString *dateStr = [fmt stringFromDate:self];
    //取得现在时间
    NSString *nowStr = [fmt stringFromDate:now];
    //取得的时间
    NSDate *date = [fmt dateFromString:dateStr];
    //现在时间
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calender components:unit fromDate:date toDate:now options:0];
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
}

/**
 *  判断是否为今天
 */
-(BOOL)isToday {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
}

@end
