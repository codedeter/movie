//
//  HQMovieDetailModel.h
//  movie
//
//  Created by lx on 2016/10/5.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

//----------------影片属性--------------
@interface attrsDic : NSObject<YYModel>

//上映时间、地点
@property(copy, nonatomic)NSArray * pubdate;

//语种
@property(copy, nonatomic)NSArray * language;

//原名
@property(copy, nonatomic)NSArray * title;

//制片国家、地区
@property(copy, nonatomic)NSArray * country;

//编剧
@property(copy, nonatomic)NSArray * writer;

//导演
@property(copy ,nonatomic)NSArray * director;

//演员
@property(copy, nonatomic)NSArray * cast;

//片长
@property(copy, nonatomic)NSArray * movie_duration;

//上映时间
@property(copy, nonatomic)NSArray * year;

//电影类型
@property(copy, nonatomic)NSArray * movie_type;


@end

//----------------评分信息--------------
@interface ratingData : NSObject<YYModel>

//评分
@property(copy, nonatomic)NSString * average;


//评论人数
@property(copy, nonatomic)NSString * numRaters;

@end



@interface HQMovieDetailModel : NSObject<YYModel>

//评分信息
@property(strong, nonatomic)ratingData * rating;

//作者
@property(copy, nonatomic)NSString * author;

//片名
@property(copy, nonatomic)NSString * alt_title;

//英文名
@property(copy, nonatomic)NSString * title;

//影片介绍
@property(copy, nonatomic)NSString * summary;

//影片属性
@property(strong, nonatomic)attrsDic * attrs;


+ (HQMovieDetailModel *)modelWithDic:(NSDictionary *)dic;

@end
