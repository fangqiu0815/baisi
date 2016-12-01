//
//  YJVideoView.h
//  BaiSi
//
//  Created by 高方秋 on 2016/9/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJTopic;

@interface YJVideoView : UIView

/** tableView */
//@property (nonatomic,weak) UITableView *tableView;
/** indexPath */
//@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger index;//方便在滚动时取出对应cell的frame
@property (nonatomic,strong)YJTopic *topic;
+ (instancetype)videoView;



@end
