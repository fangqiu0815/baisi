//
//  YJRecommend.h
//  BaiSi
//
//  Created by 高方秋 on 16/9/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "theme_id": "163",
 "theme_name": "生活百科",
 "image_list": "http:%/%/img.spriteapp.cn%/ugc%/2015%/04%/23%/160559_24190.jpg",
 "sub_number": "36871",
 "is_sub": 0,
 "is_default": 0
 */


@interface YJRecommend : NSObject

/** name */
@property (nonatomic,copy) NSString * theme_name;
/** image_list */
@property (nonatomic,copy) NSString * image_list;
/** sub_number */
@property (nonatomic,assign) NSInteger sub_number;
/** id */
@property (nonatomic,assign) NSInteger theme_id;
/** is_sub */
@property (nonatomic,assign) BOOL is_sub;
/** is_default */
@property (nonatomic,assign) BOOL is_default;


@end
