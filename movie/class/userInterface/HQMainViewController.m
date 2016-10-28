//
//  HQMainViewController.m
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQMainViewController.h"
#import "HQMovieViewController.h"
#import "HQCinemaViewController.h"
#import "HQUserViewController.h"
#import "HQNaviViewController.h"



@interface HQMainViewController ()

@end

@implementation HQMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    加载子视图
    [self loadSubview];
    
//    配置标签栏
    [self configureTabbar];
    
}

- (void)loadSubview {


    HQMovieViewController * movieController = [[HQMovieViewController alloc]init];
    
    HQCinemaViewController * cinemaController = [[HQCinemaViewController alloc]init];
    
    HQUserViewController * userController = [[HQUserViewController alloc]init];
    
    NSArray * VCArr = @[movieController, cinemaController, userController];
    
    NSMutableArray * naviArr = [NSMutableArray array];
    
    for (UIViewController * controller in VCArr) {
        
        HQNaviViewController * navi = [[HQNaviViewController alloc]initWithRootViewController:controller];
        
        [naviArr addObject:navi];
    }
    
    self.viewControllers = naviArr;
}


- (void)configureTabbar{

    NSArray * naviArr = self.viewControllers;
    for (UINavigationController * navi in naviArr) {
        
        UIViewController * VC = navi.topViewController;
        
        if ([VC isMemberOfClass:[HQMovieViewController class]]) {
            VC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"电影" image:[UIImage imageNamed:@"movie"] selectedImage:[UIImage imageNamed:@"movie"]];
            
        } else if ([VC isMemberOfClass:[HQCinemaViewController class]]) {
            VC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"最近上映" image:[UIImage imageNamed:@"cinema"] selectedImage:[UIImage imageNamed:@"cinema"]];
        } else if ([VC isMemberOfClass:[HQUserViewController class]]) {
            VC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"user"] selectedImage:[UIImage imageNamed:@"user"]];
        }
        
        
    }
    
    	self.tabBar.tintColor = PinkBlue;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
