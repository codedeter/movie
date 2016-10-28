//
//  HQMovieViewController.m
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQMovieViewController.h"
#import "HQDetailViewController.h"
#import "HQNetWorkingTool.h"
#import "HQMovieModel.h"
#import "HQMovieTableViewCell.h"

@interface HQMovieViewController ()

//存储电影模型的数组
@property(strong, nonatomic)NSMutableArray * movieModelArr;

@end

@implementation HQMovieViewController

//设置复用id
static NSString * reusedMovieID = @"resedMovieID";

- (NSMutableArray *)movieModelArr{

    if (_movieModelArr == nil) {
        _movieModelArr = [NSMutableArray array];
    }

    return _movieModelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"经典影片";
    
//    注册单元格
    UINib * movieCellNib = [UINib nibWithNibName:@"HQMovieTableViewCell" bundle:nil];
    
    [self.tableView registerNib:movieCellNib forCellReuseIdentifier:reusedMovieID];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    加载数据
    [self _loadData];

}

#pragma mark load data

- (void)_loadData{

    NSString * url = @"top250";
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[HQNetWorkingTool shareTool] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * dataArr = [NSMutableArray array];

        NSArray * movieArr = responseObject[@"subjects"];
        
        for (NSDictionary * dic in movieArr) {
            
            HQMovieModel * model = [HQMovieModel modelWithDic:dic];
            
            [dataArr addObject:model];
        }
        
        self.movieModelArr = dataArr;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];

    
    
}

#pragma mark tabView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.movieModelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HQMovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reusedMovieID forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.movieModelArr.count != 0) {
        cell.cellModel = self.movieModelArr[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        return cell;
    }else{
        
    return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    创建一个导航控制器，并设置它的根视图
    
    HQDetailViewController * movieDetailVC = [[HQDetailViewController alloc]init];
    
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:movieDetailVC];
    
    HQMovieModel * model = self.movieModelArr[indexPath.row];

    
    movieDetailVC.movieData = model;
    
    [self presentViewController:navi animated:YES completion:^{
        
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 170;
}


@end
