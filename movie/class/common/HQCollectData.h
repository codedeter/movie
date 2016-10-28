//
//  HQCollectData.h
//  movie
//
//  Created by lx on 2016/10/6.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "HQMovieDetailModel.h"
#import "HQMovieModel.h"
#import "HQCollectDataModel.h"

@interface HQCollectData : NSObject

//获取单例
+ (instancetype)getInstance;
//打开收藏电影数据库
- (void)openCollectMovieDataBase;
//关闭收藏电影数据库
- (void)closeCollectMovieDataBase;
//添加电影收藏记录
- (void)addMovieCollectList:(HQMovieDetailModel *)movie withMovieModel:(HQMovieModel *)movie;
//删除电影收藏记录
- (void)deleteMovieCollectList:(HQMovieModel *)movie;
//返回收藏的所有电影
- (NSArray *)selectAllCollectMovie;
//根据id查询是否已经收藏
- (BOOL)selectMovieWithId:(NSString *)movieid;

@end
