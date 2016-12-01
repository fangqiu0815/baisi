//
//  NSString+YJDealDate.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/9.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "NSString+YJDealDate.h"

@implementation NSString (YJDealDate)

- (NSString *)dealDate{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [fmt dateFromString:self];
    NSString *resultStr = self;
    if ([date isThisYear]) {
        if ([date isYesterday]) {
            NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
            fmt.dateFormat = @"昨天 HH:mm:ss";
            resultStr = [fmt stringFromDate:date];
        }else if ([date isToday]){
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSCalendarUnit unit = NSCalendarUnitHour|NSCalendarUnitMinute;
            NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:[NSDate date] options:NSCalendarWrapComponents];
            if (cmps.hour >= 1 ) {
                resultStr = [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                resultStr = [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }else{
                resultStr = @"刚刚";
            }
            
        }else{
            NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            resultStr = [fmt stringFromDate:date];
        }
    }else{
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        resultStr = [fmt stringFromDate:date];
    }


    return resultStr;
}

@end
