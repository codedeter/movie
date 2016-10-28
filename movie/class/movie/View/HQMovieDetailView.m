//
//  HQMovieDetailView.m
//  movie
//
//  Created by lx on 2016/10/5.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQMovieDetailView.h"
#import <UIImageView+WebCache.h>

//@interface HQMovieDetailView ()<UITableViewDelegate, UITableViewDataSource>
//
//@end

@implementation HQMovieDetailView

- (void)layoutSubviews{
    
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:self.movieModel.images.medium]];
    
//    self.movieName.text = self.movieDetailModel.alt_title;
    
    self.directorName.text = [self arrayToString:self.movieDetailModel.attrs.director];
    
    self.writerName.text = [self arrayToString:self.movieDetailModel.attrs.writer];
    
    self.castName.text = [self arrayToString:self.movieDetailModel.attrs.cast];
    
    self.movie_type.text = [self arrayToString:self.movieDetailModel.attrs.movie_type];

    self.country.text = [self arrayToString:self.movieDetailModel.attrs.country];
    
    self.pubdata.text = [self arrayToString:self.movieDetailModel.attrs.pubdate];
    
    self.language.text = [self arrayToString:self.movieDetailModel.attrs.language];
    
    self.movie_duration.text = [self arrayToString:self.movieDetailModel.attrs.movie_duration];
    
    self.movieTitle.text = self.movieDetailModel.title;
    
    self.summary.text = self.movieDetailModel.summary;

    self.labelWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width - 70;

}


//将数组转换为字符串
- (NSString *)arrayToString:(NSArray *)array{

    NSMutableString * mutableStr = [NSMutableString string];
    
    for (NSString * str in array) {
        
        [mutableStr appendString:str];
    }

    return mutableStr;
}

+ (id)viewFromNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] objectAtIndex:0];
    
}

//#pragma mark - tableView delegate
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return 1;
//
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
//    
//    
//    return cell;
//
//}

@end
