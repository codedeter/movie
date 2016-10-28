//
//  HQCollectData.m
//  movie
//
//  Created by lx on 2016/10/6.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQCollectData.h"

//单例
static HQCollectData *dataBase = nil;

static sqlite3 * movieData = nil;

@implementation HQCollectData

//获取单例
+ (instancetype)getInstance {

    if (dataBase == nil) {
        
        dataBase = [[HQCollectData alloc]init];
        
    }
    
    return dataBase;

}

//打开收藏电影数据库
- (void)openCollectMovieDataBase{
    //如果存在直接跳过
    if (movieData != nil) {
        return;
    }
    //不存在数据库
    //创建存放路径,存储在document文件夹下面
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/movie.sqlite"];
    
    NSLog(@"%@",path);
    
    //打开数据库
    int result = sqlite3_open(path.UTF8String, &movieData);
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"收藏电影数据库打开成功");
        
        char * errmsg = nil;
        
        //创建数据库表
        //创建sql语句
        NSString * sql = @"CREATE TABLE Movie (movie_id TEXT PRIMARY KEY NOT NULL, average TEXT, movie_type TEXT, movie_duration TEXT, alt_title TEXT, medium TEXT, director TEXT, summary TEXT, country TEXT, pubdate TEXT, cast TEXT, writer TEXT)";
        //执行sql语句,创建数据库表
        sqlite3_exec(movieData, sql.UTF8String, nil, nil, &errmsg);
        
//        输出错误原因
        if (errmsg) {
            
            NSLog(@"创建电影数据库失败，原因：%s", errmsg);
        }
        
    }else{
        NSLog(@"收藏电影数据库打开失败");
    }
    
}
//关闭收藏电影数据库
- (void)closeCollectMovieDataBase{
    //关闭数据库
    if (movieData != nil) {
        int result = sqlite3_close(movieData);
        //判断关闭结果
        if (result == SQLITE_OK) {
            NSLog(@"收藏电影数据库关闭成功");
            movieData = nil;
        }else{
            NSLog(@"收藏电影数据库关闭失败");
        }
    }
}
//添加电影收藏记录
- (void)addMovieCollectList:(HQMovieDetailModel *)detailMovie withMovieModel:(HQMovieModel *)movie{
    //1.打开数据库
    [self openCollectMovieDataBase];
    //2.创建伴随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"INSERT INTO Movie VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
    //4.验证sql语句正确性
    int result = sqlite3_prepare(movieData, sql.UTF8String, -1, &stmt, nil);
    
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"添加电影收藏成功");
        //5.开始绑定数据
        sqlite3_bind_text(stmt, 1, [movie.movie_id UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [detailMovie.rating.average UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [[self arrayToString:detailMovie.attrs.movie_type] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [[self arrayToString:detailMovie.attrs.movie_duration] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [detailMovie.alt_title UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 6, [movie.images.medium UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 7, [[self arrayToString:detailMovie.attrs.director] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 8, [detailMovie.summary UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 9, [[self arrayToString:detailMovie.attrs.country] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 10, [[self arrayToString:detailMovie.attrs.pubdate] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 11, [[self arrayToString:detailMovie.attrs.cast] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 12, [[self arrayToString:detailMovie.attrs.writer] UTF8String], -1, nil);
//        6.单步执行
        sqlite3_step(stmt);
    }else{
        NSLog(@"添加电影收藏失败");
         NSLog(@"Error:%s",sqlite3_errmsg(movieData));
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
}
//删除电影收藏记录
- (void)deleteMovieCollectList:(HQMovieModel *)movie{
    //1.打开数据库
    [self openCollectMovieDataBase];
    //2.创建跟随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"DELETE FROM Movie WHERE movieid = ?";
    //4.验证sql语句
    int result = sqlite3_prepare_v2(movieData, sql.UTF8String, -1, &stmt, nil);
    //结果
    if (result == SQLITE_OK) {
        NSLog(@"取消收藏电影成功");
        //5.绑定数据
        sqlite3_bind_text(stmt, 1, movie.movie_id.UTF8String, -1, nil);
        //6.单步执行
        sqlite3_step(stmt);
    }else{
        NSLog(@"取消收藏电影失败");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
}
//返回收藏的所有电影
- (NSArray *)selectAllCollectMovie{
    //1.打开数据库
    [self openCollectMovieDataBase];
    //2.创建跟随指针
    sqlite3_stmt * stmt;
    //3.准备sql语句
    NSString * sql = @"SELECT *FROM Movie";
    //4.验证sql语句
    int result = sqlite3_prepare_v2(movieData, sql.UTF8String, -1, &stmt, nil);
    //创建可变数组
    NSMutableArray * array = [NSMutableArray array];
    
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"查询所有收藏电影成功");
        //5.获取数据
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //6.添加到数组
            NSString * movie_id = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSString * rating = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString * movie_type = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString * movie_duration = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString * alt_title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            NSString * poster = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            NSString * director = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            NSString * summary = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            NSString * country = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
            NSString * pubdate = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 9)];
            NSString * cast = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 10)];
            NSString * writer = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 11)];
            
            NSLog(@"%@",poster);
            
//            创建movieDetailmodel
            HQCollectDataModel * collectDataModel = [[HQCollectDataModel alloc]init];
            
            collectDataModel.movie_id = movie_id;
            collectDataModel.rating = rating;
            collectDataModel.movie_type = movie_type;
            collectDataModel.movie_duration = movie_duration;
            collectDataModel.alt_title = alt_title;
            collectDataModel.poster = poster;
            collectDataModel.director = director;
            collectDataModel.summary = summary;
            collectDataModel.country = country;
            collectDataModel.pubdate = pubdate;
            collectDataModel.cast = cast;
            collectDataModel.writer = writer;
            
//            添加到数组
            [array addObject:collectDataModel];

        }
    }else{
        NSLog(@"查询所有收藏电影失败");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);

    //8.返回数组
    return array;
}
//根据id查询是否已经收藏
- (BOOL)selectMovieWithId:(NSString *)movieid{
    BOOL state = NO;
    //1.打开数据库
    [self openCollectMovieDataBase];
    //2.创建跟随指针
    sqlite3_stmt *stmt = nil;
    //3.准备sql语句
    NSString *sql = @"SELECT *FROM Movie WHERE movieid = ?";
    //4.验证sql语句
    int result = sqlite3_prepare(movieData, sql.UTF8String, -1, &stmt, nil);
    //判断结果
    if (result == SQLITE_OK) {
        NSLog(@"查询电影是否收藏成功");
        //5.绑定数据
        sqlite3_bind_text(stmt, 1, [movieid UTF8String], -1, nil);
        //判断
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            state = YES;
        }
    }else{
        NSLog(@"查询电影是否收藏成功");
    }
    //7.释放跟随指针
    sqlite3_finalize(stmt);
    //8.返回数组
    return state;
}


//数组转字符串
- (NSString *)arrayToString:(NSArray *)array{
    
    NSMutableString * mutableStr = [NSMutableString string];
    
    for (NSString * str in array) {
        
        [mutableStr appendString:str];
    }
    
    return mutableStr;
}

@end
