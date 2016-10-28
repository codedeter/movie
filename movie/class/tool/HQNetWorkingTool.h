//
//  HQNetWorkingTool.h
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface HQNetWorkingTool : AFHTTPSessionManager

+ (HQNetWorkingTool *)shareTool;

@end
