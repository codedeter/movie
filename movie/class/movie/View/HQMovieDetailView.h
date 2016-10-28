//
//  HQMovieDetailView.h
//  movie
//
//  Created by lx on 2016/10/5.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQMovieModel.h"
#import "HQMovieDetailModel.h"

@interface HQMovieDetailView : UIView

@property(strong, nonatomic)HQMovieModel * movieModel;
@property(strong, nonatomic)HQMovieDetailModel * movieDetailModel;

//@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet UILabel *directorName;
@property (weak, nonatomic) IBOutlet UILabel *writerName;
@property (weak, nonatomic) IBOutlet UILabel *castName;
@property (weak, nonatomic) IBOutlet UILabel *movie_type;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *pubdata;
@property (weak, nonatomic) IBOutlet UILabel *language;
@property (weak, nonatomic) IBOutlet UILabel *movie_duration;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidthConstraint;


+ (id)viewFromNib;

@end
