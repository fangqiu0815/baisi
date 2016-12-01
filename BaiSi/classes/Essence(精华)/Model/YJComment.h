//
//  YJComment.h
//  BaiSi
//
//  Created by 高方秋 on 2016/10/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJUser;
@interface YJComment : NSObject

/** id*/
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长*/
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径*/
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容*/
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量*/
@property (nonatomic, assign) NSInteger like_count;
/** 用户*/
@property (nonatomic, strong) YJUser *user;

@end
