//
//  HQMovieTableViewCell.m
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQMovieTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "HQDetailViewController.h"

@implementation HQMovieTableViewCell

- (void)setCellModel:(HQMovieModel *)cellModel{

    [self.MovieIcon sd_setImageWithURL:[NSURL URLWithString:cellModel.images.small]];
    
    self.titleLabel.text = cellModel.title;
    
//    拿到导演列表中的第0个元素
    directorsArr * arr1 = cellModel.directors[0];
    
    self.directorsName.text = arr1.name;
    
//    拿到演员列表中的第0个元素
    castsArr * arr = cellModel.casts[0];
    
    self.actorsName.text = arr.name;

    self.palyYear.text = cellModel.year;
    
    CGFloat rating = [cellModel.rating.average floatValue];
    
    self.ratingLabel.text = [NSString stringWithFormat:@"%.2f", rating];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
//    movieDetailVC.moviewID = self.cellModel.movie_id;
    
}

@end
