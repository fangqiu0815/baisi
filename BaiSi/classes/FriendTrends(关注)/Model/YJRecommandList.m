//
//  YJRecommandList.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/5.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJRecommandList.h"
#import "MJExtension.h"
@implementation YJRecommandList

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id"
             };
}

-(NSMutableArray *)users{
    if (_users == nil) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}



@end
