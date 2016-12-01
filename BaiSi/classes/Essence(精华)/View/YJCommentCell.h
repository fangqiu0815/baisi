//
//  YJCommentCell.h
//  BaiSi
//
//  Created by 高方秋 on 2016/10/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJComment;
@interface YJCommentCell : UITableViewCell

/** 评论的模型 */
@property (nonatomic, strong) YJComment *comment;

@end
