//
//  HQNetWorkingTool.m
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQNetWorkingTool.h"

static HQNetWorkingTool * tool;

@implementation HQNetWorkingTool

+ (HQNetWorkingTool *)shareTool{
    
    NSURL * url = [NSURL URLWithString:@"https://api.douban.com/v2/movie"];

    tool = [[HQNetWorkingTool alloc]initWithBaseURL:url];
    
    return tool;
}

@end
