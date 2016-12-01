//
//  YJRecommandUser.h
//  BaiSi
//
//  Created by 高方秋 on 2016/10/5.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJRecommandUser : NSObject
/**  头像 **/
@property (nonatomic, copy) NSString *header;
/**  粉丝数 **/
@property (nonatomic, assign) NSInteger fans_count;
/**  昵称  **/
@property (nonatomic, copy) NSString *screen_name;

/** 用来保存关注用户模型的数组 **/
@property (nonatomic,strong)NSArray *followUser;


@end
