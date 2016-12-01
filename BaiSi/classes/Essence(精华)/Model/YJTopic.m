//
//  YJTopic.m
//  BaiSi
//
//  Created by 高方秋 on 2016/9/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJTopic.h"
#import "YJComment.h"
#import "YJUser.h"

@implementation YJTopic


- (CGFloat)cellHeight{
    if (_cellHeight) {
        return _cellHeight;
    }
    // 设置间距
    CGFloat margin = 10;
    //计算cell的高度
    CGFloat cellH = 0;
    //累加帖子的文本的y值
    cellH += 60;
    //maxSize
    CGSize maxSize = CGSizeMake(YJScreenW - 2*margin, MAXFLOAT);
    CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size.height;
//    //计算中间view的高度
//    if (self.type != YJTopicTypeTalk) {
//        CGFloat w = YJScreenW - 2 * margin;
//        CGFloat h = w * self.height/self.width * 1.0;
//        // 判断是否是大图
//        if (h > YJScreenH) { // 如果图片的高度大于屏幕的高度，就是大图
//            self.bigPicture = YES;
//            // 如果是大图，高度就固定为200
//            h = 200;
//        }
//        self.centerFrame = CGRectMake(margin, cellH, w, h);
//        cellH += h + 2 * margin;
//    
//    }
    //加上文本高度
    cellH += textH + 2 * margin;
//    //加上间距
    cellH += margin;
    
    if (self.type == YJTopicTypePic) { //图片帖子
        //图片显示出来的宽度
        CGFloat pictureW = YJScreenW - 2 *margin;
        //图片显示出来的高度
        CGFloat pictureH = pictureW * self.height / self.width;
        if (pictureH >= 1000) { //图片高度过长
            pictureH = 250;
            self.bigPicture = YES;
        }
        self.centerFrame = CGRectMake(margin, cellH, pictureW, pictureH);
        //图片的高度
        cellH += pictureH + 25;
    } else if (self.type == YJTopicTypeVoice) { //声音帖子
        
        CGFloat voiceW = YJScreenW - 2 *margin;
        CGFloat voiceH = voiceW * self.height / self.width;
        self.centerFrame = CGRectMake(margin, cellH, voiceW, voiceH);
        
        cellH += voiceH + 25;
    } else if (self.type == YJTopicTypeVideo) { //视频帖子
        
        CGFloat videoW = YJScreenW - 2 *margin;
        CGFloat videoH = videoW * self.height / self.width;
        self.centerFrame = CGRectMake(margin, cellH, videoW, videoH);
        
        cellH += videoH + 25;
    }
    //最热评论的高度
    if (self.top_cmt.content) {
        cellH += 20;
//        NSString *userName = self.top_cmt[0][@"user"][@"username"];
//        NSString *content = self.top_cmt[0][@"content"];
        NSString *hotcontent = [NSString stringWithFormat:@"%@:%@",self.top_cmt.user.username, self.top_cmt];
        CGFloat hotcontentH = [hotcontent boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size.height;
        cellH += hotcontentH;
    }

    //加上工具栏高度
    cellH += 40;
    _cellHeight = cellH;
    return _cellHeight;
}






@end
