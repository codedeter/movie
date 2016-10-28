//
//  HQMovieModel.m
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQMovieModel.h"

//castsDic avatarsDic directorsDic ratingDic

@implementation castsArr

@end

@implementation directorsArr


@end

@implementation avatarsDic

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{

    return @{@"avatar" : [avatarsDic class]};

}

@end

@implementation ratingDic

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{

    return @{@"rating" : [ratingDic class]};

}

@end


@implementation HQMovieModel

+(HQMovieModel *)modelWithDic:(NSDictionary *)dic{

    HQMovieModel * model = [HQMovieModel yy_modelWithDictionary:dic];
    
    return model;
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    
    return @{@"casts" : [castsArr class], @"directors" : [directorsArr class]};

}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{

    return @{@"movie_id" : @"id"};

}

@end
