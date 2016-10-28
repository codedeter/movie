//
//  HQUserViewController.m
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQUserViewController.h"
#import <UIImageView+WebCache.h>
#import "HQCollectViewController.h"

@interface HQUserViewController ()

@property (nonatomic,retain) NSMutableArray *array;

@end

@implementation HQUserViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        //设置标题
        self.navigationItem.title = @"我的";
        //设置tabBar
        self.tabBarItem.image = [UIImage imageNamed:@"user"];
        self.tabBarItem.title = @"我的";
        //初始化数组
        self.array = [NSMutableArray arrayWithObjects:@"清除缓存", @"我的电影",nil];
//        //设置右按钮
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:                                                 UIBarButtonItemStylePlain target:self action:@selector(loginOrExit:)];
        //设置标题属性
        NSDictionary *attribute = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]};
        //设置属性
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
        //设置登录状态
        [self viewWillAppear:YES];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    注册单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"userListCellReuse"];

}

#pragma mark - Table view data source
//设置分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _array.count;
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userListCellReuse" forIndexPath:indexPath];
    // Configure the cell...
    //设置辅助样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //设置标题
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}
//设置cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.row == 1){
        [self gotoMyMovieView];
    }else{
        [self clearImageCache];
    }
    //清除tableview选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//进入我的电影页面
- (void)gotoMyMovieView{

        HQCollectViewController *movie = [[HQCollectViewController alloc] init];
        //设置push隐藏tabbar
        movie.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:movie animated:YES];
    
}
//清除缓存
- (void)clearImageCache{
    //计算缓存大小
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    CGFloat cache = size / 1024.0 / 1024.0;
    //字符串
    NSString *str = [NSString stringWithFormat:@"%.2fM",cache];
    //初始化弹窗
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = 102;
    //显示弹框
    [alertView show];
    
}
//alertview点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //确认清除
    if (alertView.tag == 102 && buttonIndex == 1) {
        //清除缓存
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
    }
}





@end