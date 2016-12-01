//
//  NSString+YJExtension.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/13.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "NSString+YJExtension.h"

@implementation NSString (YJExtension)


-(unsigned long long)fileSize
{
    unsigned long long size = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL directory = NO;
    BOOL exists = [manager fileExistsAtPath:self isDirectory:&directory];
    // 如果地址为空
    if (!exists) return size;
    // 如果是文件夹
    if (directory) {
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *path in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:path];
            NSDictionary *attr = [manager attributesOfItemAtPath:fullPath error:nil];
            size += attr.fileSize;
        }
    }else{
        size = [manager attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
}


@end
