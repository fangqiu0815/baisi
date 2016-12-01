//
//  YJTopic.h
//  BaiSi
//
//  Created by 高方秋 on 2016/9/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJComment.h"
//1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
typedef enum {
    YJTopicTypePic = 10,
    YJTopicTypeVideo = 41,
    YJTopicTypeTalk = 29,
    YJTopicTypeVoice = 31,
    YJTopicTypeAllItems = 1
} YJTopicTypeAll;



@interface YJTopic : NSObject
/**  id **/
@property (nonatomic,assign)NSInteger ID;
/**  帖子类型 **/
@property (nonatomic,assign)NSInteger type;
/**  名称 **/
@property (nonatomic,strong)NSString *name;
/**  头像 **/
@property (nonatomic,strong)NSString *profile_image;
/** 发帖时间*/
@property (nonatomic, strong) NSString *create_time;
/**  帖子内容 **/
@property (nonatomic,strong)NSString *text;
/**  点赞数量 **/
@property (nonatomic,assign)NSInteger love;
/**  踩得数量 **/
@property (nonatomic,assign)NSInteger hate;
/**  发帖人的昵称 **/
@property (nonatomic,strong)NSString *screen_name;
/** 转发的数量*/
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量*/
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 **/
@property (nonatomic,strong)YJComment *top_cmt;

/** cell的高度*/
@property (nonatomic, assign) CGFloat cellHeight;

/** 声音是否在播放 */
@property (nonatomic, assign,getter=is_voicePlaying) BOOL voicePlaying;
@property(nonatomic,strong)NSString *voiceuri;
/** 图片宽度 **/
@property (nonatomic,assign)NSInteger width;
/** 图片高度 **/
@property (nonatomic,assign)NSInteger height;
/** 小图 **/
@property (nonatomic,strong)NSString *image0;
/** 大图 **/
@property (nonatomic,strong)NSString *image1;
/** 中图 **/
@property (nonatomic,strong)NSString *image2;
/** 中间view的frame **/
@property (nonatomic,assign)CGRect centerFrame;
/** 是否是gif图片 */
@property (nonatomic,assign) BOOL is_gif;

/** 是否是新浪加v用户*/
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 小图片路径*/
@property (nonatomic, copy) NSString *small_image;
/** 大图片路径*/
@property (nonatomic, copy) NSString *large_image;
/** 中图片路径*/
@property (nonatomic, copy) NSString *middle_image;
/** 音频时长*/
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长*/
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数*/
@property (nonatomic, assign) NSInteger playfcount;
/** 视频路径*/
@property (nonatomic, copy) NSString *videouri;
/** ctime*/
@property (nonatomic, copy) NSString *qzone_uid;


/******** 额外属性 *********/

/** 图片控件的frame*/
@property (nonatomic, assign, readonly) CGRect pictureF;
/** 声音控件的frame*/
@property (nonatomic, assign, readonly) CGRect voiceF;
/** 视频控件的frame*/
@property (nonatomic, assign, readonly) CGRect videoF;
/** 图片控件的frame*/
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 图片下载进度*/
@property (nonatomic, assign) CGFloat pictureProgress;

@end
