//
//  HQCinemaDetailViewController.m
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQCinemaDetailViewController.h"
#import "HQNetWorkingTool.h"
#import "HQMovieDetailModel.h"
#import "HQMovieDetailView.h"

@interface HQCinemaDetailViewController ()

@property(strong, nonatomic)HQMovieDetailModel * recentlyMovieDetailModel;

@end

@implementation HQCinemaDetailViewController

- (HQMovieDetailModel *)recentlyMovieDetailModel{

    if (!_recentlyMovieDetailModel) {
        _recentlyMovieDetailModel = [[HQMovieDetailModel alloc]init];
    }

    return _recentlyMovieDetailModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(navigationItemAction:)];
    
//    加载数据
    [self _loadData];
    
}


- (void)navigationItemAction: (UIBarButtonItem *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

}

//加载数据
- (void)_loadData{
    
    NSLog(@"%@", self.recentlyMovieData.movie_id);
    
    NSString * url = self.recentlyMovieData.movie_id;
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[HQNetWorkingTool shareTool] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.recentlyMovieDetailModel = [HQMovieDetailModel modelWithDic:responseObject];
        
        //    加载子视图
        [self _loadSubView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


- (void)_loadSubView{
    
    HQMovieDetailView * movieDetailView = [HQMovieDetailView viewFromNib];
    
    movieDetailView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 200);
    
    movieDetailView.movieDetailModel = self.recentlyMovieDetailModel;
    movieDetailView.movieModel = self.recentlyMovieData;
    
    [self.view addSubview:movieDetailView];
    
}

@end
