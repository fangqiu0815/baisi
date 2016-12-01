//
//  YJPictureTableViewController.h
//  BaiSi
//
//  Created by 高方秋 on 2016/9/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJTopic;
@interface YJPictureTableViewController : UIViewController

/** topic模型 */
@property (nonatomic, strong) YJTopic *topic;

+ (instancetype)pictureView;

@end
