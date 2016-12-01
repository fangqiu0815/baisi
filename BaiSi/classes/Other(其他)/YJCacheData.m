//
//  YJCacheData.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/18.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJCacheData.h"
#import "FMDB.h"
static FMDatabase *db;
@interface YJCacheData ()
/** 线程安全的数据库队列对象 */
@property (nonatomic,strong) FMDatabaseQueue *dbQueue;

///**  id **/
//@property (nonatomic,strong)NSString *ID;
///**  帖子类型 **/
//@property (nonatomic,assign)NSInteger type;
///**  名称 **/
//@property (nonatomic,strong)NSString *name;
///**  头像 **/
//@property (nonatomic,strong)NSString *profile_image;
///** 发帖时间*/
//@property (nonatomic, strong) NSString *create_time;
///**  帖子内容 **/
//@property (nonatomic,strong)NSString *text;
///**  点赞数量 **/
//@property (nonatomic,assign)NSInteger love;
///**  踩得数量 **/
//@property (nonatomic,assign)NSInteger hate;
///**  发帖人的昵称 **/
//@property (nonatomic,strong)NSString *screen_name;
///** 转发的数量*/
//@property (nonatomic, assign) NSInteger repost;
///** 评论的数量*/
//@property (nonatomic, assign) NSInteger comment;
//
///** 图片宽度 **/
//@property (nonatomic,assign)NSInteger width;
///** 图片高度 **/
//@property (nonatomic,assign)NSInteger height;
///** 小图 **/
//@property (nonatomic,strong)NSString *image0;
///** 大图 **/
//@property (nonatomic,strong)NSString *image1;
///** 中图 **/
//@property (nonatomic,strong)NSString *image2;
///** 是否是gif图片 */
//@property (nonatomic,assign) BOOL is_gif;
//
//
///** 音频时长*/
//@property (nonatomic, assign) NSInteger voicetime;
///** 视频时长*/
//@property (nonatomic, assign) NSInteger videotime;
///** 播放次数*/
//@property (nonatomic, assign) NSInteger playfcount;
///** 视频路径*/
//@property (nonatomic, copy) NSString *videouri;


@end

@implementation YJCacheData

+ (void)initialize{

    // 数据库文件路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filename = [path stringByAppendingPathComponent:@"baisi.sqlite"];
    // 打开数据库
    db = [FMDatabase databaseWithPath:filename];
    if ([db open]) {
        YJLog(@"打开数据库成功");
        // 创建帖子表
        NSString *sql = @"create table if not exists t_topic(id integer primary key,type integer,_text text,created_at text,name text,profile_image text,love integer,hate integer,repost integer,comment integer,width integer,height integer,is_gif integer,image0 text,image1 text, image2 text,videotime integer,playfcount integer,videouri text,voicetime integer,voiceuri text);";
        if([db executeUpdate:sql]){
            NSLog(@"创建表成功");
            NSLog(@"%@",NSHomeDirectory());
        }else{
            NSLog(@"创建表失败");
        }
    }else{
        YJLog(@"打开数据库失败");
    }

}






// 保存帖子模型对象到数据库
+ (void)saveTopic:(YJTopic *)topic{
    NSString *sql = @"insert into t_topic(id,type ,_text ,created_at ,name ,profile_image ,love ,hate ,repost ,comment ,width ,height ,is_gif ,image0 ,image1 , image2 ,videotime ,playfcount ,videouri ,voicetime ,voiceuri) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
    // 注意：?填补的值一定要是对象类型
    BOOL success = [db executeUpdate:sql,@(topic.ID),@(topic.type),topic.text,topic.create_time,topic.name,topic.profile_image,@(topic.love),@(topic.hate),@(topic.repost),@(topic.comment),@(topic.width),@(topic.height),@(topic.is_gif),topic.image0,topic.image1,topic.image2,@(topic.videotime),@(topic.playfcount),topic.videouri,@(topic.voicetime),topic.voiceuri];
    if (success) {
        NSLog(@"保存帖子到数据库成功");
    }else{
        NSLog(@"保存帖子到数据库失败");
    }



}

// 获取数据库里的所有帖子模型
+ (NSMutableArray *)topicsWithType:(NSInteger)type{
    NSString *sql;
    if (type == 1) {
        sql = @"select * from t_topic limit 0 ,20;";
    }else{
        sql = [NSString stringWithFormat:@"select * from t_topic where type = %ld limit 0 ,20;",type];
    }
    
    NSMutableArray *datas = [self topicsWithSql:sql];
    NSLog(@"datas---%@",datas);
    return datas;


}

// 根据sql语句获取帖子模型
+ (NSMutableArray *)topicsWithSql:(NSString *)sql{

    NSMutableArray *topics = [NSMutableArray array];
    FMResultSet *result = [db executeQuery:sql];
    while ([result next]) { // 是否有下一条记录
        NSInteger ID = [result intForColumn:@"id"];
        NSInteger type = [result intForColumn:@"type"];
        NSString *_text = [result stringForColumn:@"_text"];
        NSString *created_at = [result stringForColumn:@"created_time"];
        NSString *name = [result stringForColumn:@"name"];
        NSString *profile_image = [result stringForColumn:@"profile_image"];
        NSInteger love = [result intForColumn:@"love"];
        NSInteger hate = [result intForColumn:@"hate"];
        NSInteger repost = [result intForColumn:@"repost"];
        NSInteger comment = [result intForColumn:@"comment"];
        NSInteger width = [result intForColumn:@"width"];
        NSInteger height = [result intForColumn:@"height"];
        NSInteger is_gif = [result intForColumn:@"is_gif"];
        NSString *image0 = [result stringForColumn:@"image0"];
        NSString *image1 = [result stringForColumn:@"image1"];
        NSString *image2 = [result stringForColumn:@"image2"];
        NSInteger videotime = [result intForColumn:@"videotime"];
        NSInteger playfcount = [result intForColumn:@"playfcount"];
        NSString *videouri = [result stringForColumn:@"videouri"];
        NSInteger voicetime = [result intForColumn:@"voicetime"];
        NSString *voiceuri = [result stringForColumn:@"voiceuri"];
        
        YJTopic *topic = [[YJTopic alloc] init];
        topic.ID = ID;
        topic.type = type;
        topic.text = _text;
        topic.create_time = created_at;
        topic.name = name;
        topic.profile_image = profile_image;
        topic.love = love;
        topic.hate = hate;
        topic.repost = repost;
        topic.comment = comment;
        topic.width = width;
        topic.height = height;
        topic.is_gif = is_gif;
        topic.image0 = image0;
        topic.image1 = image1;
        topic.image2 = image2;
        topic.videotime = videotime;
        topic.playfcount = playfcount;
        topic.videouri = videouri;
        topic.voicetime = voicetime;
        topic.voiceuri = voiceuri;
        [topics addObject:topic];
    }
    return topics;


}

// 根据页码帖子模型
+ (NSMutableArray *)topicsWithPage:(NSInteger)page type:(NSInteger)type{

    NSString *sql = nil;
    if (type == 1) {
        sql=[NSString stringWithFormat:@"select * from t_topic limit %ld,20;",page * 20];
    }else{
        sql =  [NSString stringWithFormat:@"select * from t_topic where type = %ld limit %ld,20;",type,page * 20];
    }
    
    return [self topicsWithSql:sql];

}












@end
