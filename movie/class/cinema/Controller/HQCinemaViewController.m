//
//  HQCinemaViewController.m
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQCinemaViewController.h"
#import "HQDetailViewController.h"
#import "HQNetWorkingTool.h"
#import "HQMovieModel.h"
#import "HQMovieTableViewCell.h"

@interface HQCinemaViewController ()

@property(strong, nonatomic)NSMutableArray * recentlyMovieModelArr;

@end

static NSString * reusedNewMovieId = @"newMovie";

@implementation HQCinemaViewController

- (NSMutableArray *)nestMovieModelArr{

    if (!_recentlyMovieModelArr) {
        _recentlyMovieModelArr = [NSMutableArray array];
    }

    return _recentlyMovieModelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"最新上映";
    
//    注册单元格
    UINib * movieCellNib = [UINib nibWithNibName:@"HQMovieTableViewCell" bundle:nil];
    
    [self.tableView registerNib:movieCellNib forCellReuseIdentifier:reusedNewMovieId];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    加载数据
    [self _loadData];
    
}

#pragma mark load data

- (void)_loadData{
    
    NSString * url = @"in_theaters";
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[HQNetWorkingTool shareTool] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * dataArr = [NSMutableArray array];
        
        NSArray * movieArr = responseObject[@"subjects"];
        
        for (NSDictionary * dic in movieArr) {
            
            HQMovieModel * model = [HQMovieModel modelWithDic:dic];
            
            [dataArr addObject:model];
        }
        
        self.recentlyMovieModelArr = dataArr;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
}

#pragma mark tabView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.recentlyMovieModelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    HQMovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reusedNewMovieId forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.recentlyMovieModelArr.count != 0) {
        cell.cellModel = self.recentlyMovieModelArr[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        return cell;
    }else{
        
        return cell;
        
    }


}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 240;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HQDetailViewController * movieDetailVC = [[HQDetailViewController alloc]init];
    
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:movieDetailVC];
    
    HQMovieModel * model = self.recentlyMovieModelArr[indexPath.row];
    
    movieDetailVC.movieData = model;
    
    [self presentViewController:navi animated:YES completion:^{
        
    }];
    
}


@end
