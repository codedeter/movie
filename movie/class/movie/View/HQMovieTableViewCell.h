//
//  HQMovieTableViewCell.h
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQMovieModel.h"

@interface HQMovieTableViewCell : UITableViewCell

//电影海报
@property (weak, nonatomic) IBOutlet UIImageView *MovieIcon;

//电影名字
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//导演名字
@property (weak, nonatomic) IBOutlet UILabel *directorsName;

//演员名字
@property (weak, nonatomic) IBOutlet UILabel *actorsName;

//上映时间
@property (weak, nonatomic) IBOutlet UILabel *palyYear;

//评分
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

//数据模型
@property(strong, nonatomic)HQMovieModel * cellModel;

@end
