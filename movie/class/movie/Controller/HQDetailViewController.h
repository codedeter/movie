//
//  HQDetailViewController.h
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQMovieModel.h"
#import "HQMovieDetailModel.h"
#import "HQCollectDataModel.h"

@interface HQDetailViewController : UIViewController

@property(strong, nonatomic)HQMovieModel * movieData;
@property(strong, nonatomic)HQMovieDetailModel *details;
@property(strong, nonatomic)HQCollectDataModel * collectdata;

@end
