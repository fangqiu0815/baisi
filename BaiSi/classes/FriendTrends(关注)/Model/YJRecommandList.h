//
//  YJRecommandList.h
//  BaiSi
//
//  Created by 高方秋 on 2016/10/5.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJRecommandList : NSObject

/*
   id
 */
@property (nonatomic, copy) NSString *ID;
/*
  名字
 */
@property (nonatomic, copy) NSString *name;
/*
   总数
 */
@property (nonatomic, assign) NSNumber *count;

/*
   这个类别对应的数据
 */
@property (nonatomic, strong) NSMutableArray *users;
/*
   总数
 */
@property (nonatomic, assign) NSNumber *total;
/*
  总页数
 */
@property (nonatomic, assign) NSNumber *total_page;
/*
   当前页码
 */
@property (nonatomic, assign) NSInteger currentPage;


@end
