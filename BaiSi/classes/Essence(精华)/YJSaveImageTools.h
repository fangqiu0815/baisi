//
//  YJSaveImageTools.h
//  自定义相册
//
//  Created by 高方秋 on 2016/10/8.
//  Copyright © 2016年 fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface YJSaveImageTools : NSObject

/*
 
 image    要保存的图片
 title    保存到文件名
 success  保存图片成功的block
 failure  保存图片失败的block
 
 */

+(void)saveImageToCustomCollection:(UIImage *)image title:(NSString *)title success:(void (^)())success failure:(void (^)())failure;


@end
