//
//  HQMovieModel.h
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>



//----------------图片信息---------------castsDic avatarsDic directorsDic ratingDic

@interface avatarsDic : NSObject<YYModel>

//图片（大）
@property(copy, nonatomic)NSString * large;

//图片（中）
@property(copy, nonatomic)NSString * medium;

//图片（小）
@property(copy, nonatomic)NSString * small;

//图片字典
@property(copy, nonatomic)NSDictionary * avatars;

@end


//----------------导演信息------------------
@interface directorsArr : NSObject<YYModel>

//导演名字
@property(copy, nonatomic)NSString * name;

//导演信息
@property(copy, nonatomic)NSArray * director;

//导演图片信息
@property(strong, nonatomic)avatarsDic * avatars;

@end

//----------------演员信息------------------
@interface castsArr : NSObject<YYModel>

//演员ID
@property(copy, nonatomic)NSString * casts_id;

//演员名字
@property(copy, nonatomic)NSString * name;

//演员信息
@property(strong, nonatomic)castsArr * casts;

//演员图片信息
@property(strong, nonatomic)avatarsDic * avatars;

@end



//----------------评分信息------------------
@interface ratingDic : NSObject<YYModel>

//评分分值
@property(copy, nonatomic)NSString * average;

//评分信息
@property(copy, nonatomic)NSDictionary * rating;

@end



@interface HQMovieModel : NSObject<YYModel>

//电影ID
@property(copy, nonatomic)NSString * movie_id;

//评分信息
@property(strong, nonatomic)ratingDic * rating;

//电影类型
@property(copy, nonatomic)NSDictionary * genres;

//电影名字
@property(copy, nonatomic)NSString * title;

//演员信息
@property(copy, nonatomic)NSArray * casts;

//看过数量
@property(copy, nonatomic)NSString * collect_count;

//官方名字
@property(copy, nonatomic)NSString * original_title;

//导演信息
@property(strong, nonatomic)NSArray * directors;

//电影上线时间
@property(copy, nonatomic)NSString * year;

//电影海报信息
@property(strong, nonatomic)avatarsDic * images;


+ (HQMovieModel *)modelWithDic:(NSDictionary *)dic;


@end
