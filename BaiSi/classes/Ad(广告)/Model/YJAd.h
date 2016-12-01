//
//  YJAd.h
//  BaiSi
//
//  Created by 高方秋 on 16/9/23.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "ori_curl":"http://clickc.admaster.com.cn/c/a73199,b1289739,c3093,i0,m101,8a2,8b2,h",
 "w":768,
 "h":1024,
 "w_picurl":"http://ubmcmm.baidustatic.com/media/v1/0f0005DSCDfbQYPNKT7tS6.jpg",
 */
@interface YJAd : NSObject
@property (nonatomic,strong) NSString *w_picurl;
@property (nonatomic,strong) NSString *ori_curl;
@property (nonatomic,assign) NSInteger w;
@property (nonatomic,assign) NSInteger h;


@end
