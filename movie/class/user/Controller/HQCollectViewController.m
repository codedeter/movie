//
//  HQCollectViewController.m
//  movie
//
//  Created by lx on 2016/10/14.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQCollectViewController.h"
#import "HQMovieDetailModel.h"
#import "HQCollectData.h"
#import "HQDetailViewController.h"
#import "HQMovieModel.h"

@interface HQCollectViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,retain) NSArray *array;

@end

@implementation HQCollectViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        //设置标题
        self.navigationItem.title = @"我的电影";
        //获取数据
        self.array = [[HQCollectData getInstance] selectAllCollectMovie];
        
        [self.tableView reloadData];
        
        NSLog(@"电影数据库%@",_array);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    注册单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"movieCollectCellReuse"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCollectCellReuse" forIndexPath:indexPath];
    
    HQMovieDetailModel *details = _array[indexPath.row];
    //设置标题
    cell.textLabel.text = details.alt_title;
    //设置辅助视图
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //row点击事件
    HQCollectDataModel * movie = _array[indexPath.row];
    
    //跳转到详细页面
    HQDetailViewController *detailsVC = [[HQDetailViewController alloc] init];
    
    detailsVC.collectdata = movie;
    
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:detailsVC];
    
    [self presentViewController:navi animated:YES completion:^{
        
    }];

}

//当返回时,如果数据发生变化,需要重新加载
- (void)viewWillAppear:(BOOL)animated{
    //取消选中状态
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    NSArray * arr = [[HQCollectData getInstance] selectAllCollectMovie];
    
    NSLog(@"%@",arr);
    //如果数据发生变化
    if (arr.count != self.array.count) {
        self.array = arr;
        [self.tableView reloadData];
    }
}


@end
