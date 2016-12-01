//
//  NSCalendar+YJUint.m
//  时间
//
//  Created by 高方秋 on 2016/10/9.
//  Copyright © 2016年 fangqiu. All rights reserved.
//

#import "NSCalendar+YJUint.h"

@implementation NSCalendar (YJUint)

+ (instancetype)yj_calendar{
    if ([self resolveClassMethod:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        return [NSCalendar currentCalendar];
    }

}



@end
