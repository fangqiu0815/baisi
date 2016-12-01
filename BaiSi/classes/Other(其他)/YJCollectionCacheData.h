//
//  YJCollectionCacheData.h
//  BaiSi
//
//  Created by 高方秋 on 2016/10/20.
//
//

#import <Foundation/Foundation.h>
#import "YJTopic.h"
@interface YJCollectionCacheData : NSObject

// 保存帖子模型对象到数据库
+ (void)saveTopic:(YJTopic *)topic;

//// 获取数据库里的所有帖子模型
//+ (NSMutableArray *)topicsWithType:(NSInteger)type;

// 根据sql语句获取帖子模型
+ (NSMutableArray *)topicsWithSql:(NSString *)sql;

// 根据页码帖子模型
+ (NSMutableArray *)topicsWithPage:(NSInteger)page type:(NSInteger)type;

+ (NSMutableArray *)topics;


@end
