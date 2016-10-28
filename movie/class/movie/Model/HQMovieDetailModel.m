//
//  HQMovieDetailModel.m
//  movie
//
//  Created by lx on 2016/10/5.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQMovieDetailModel.h"

@implementation attrsDic

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{

    return @{@"attrs" : [attrsDic class]};

}

@end

@implementation ratingData

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    
    return @{@"rating" : [ratingData class]};

}

@end



@implementation HQMovieDetailModel

+ (HQMovieDetailModel *)modelWithDic:(NSDictionary *)dic{

    HQMovieDetailModel * model = [HQMovieDetailModel yy_modelWithDictionary:dic];
    
    return model;
}

@end
