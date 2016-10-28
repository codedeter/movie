//
//  HQDetailViewController.m
//  movie
//
//  Created by lx on 2016/10/4.
//  Copyright © 2016年 yuhuiqiang. All rights reserved.
//

#import "HQDetailViewController.h"
#import "HQNetWorkingTool.h"
#import "HQMovieDetailModel.h"
#import "HQMovieDetailView.h"
#import "HQCollectData.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialUIManager.h"

@interface HQDetailViewController ()

@property(strong, nonatomic)HQMovieDetailModel * movieDetailModel;
@property(assign, nonatomic) BOOL isCollectState;
@property(strong, nonatomic) NSMutableString * url;

@end

@implementation HQDetailViewController

- (HQMovieDetailModel *)movieDetailModel{

    if (!_movieDetailModel) {
        _movieDetailModel = [[HQMovieDetailModel alloc]init];
    }

    return _movieDetailModel;
}

- (NSMutableString *)url{

    if (!_url) {
        _url = [NSMutableString string];
    }

    return _url;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //设置左按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(UIBarButtonItemAction:)];
        //设置右按钮
        UIBarButtonItem * conllectItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"star_unfav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickConllec:)];
        
        UIBarButtonItem * shareItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
        
        self.navigationItem.rightBarButtonItems = @[conllectItem,shareItem];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    NSLog(@"收藏状态%d",_isCollectState);
    
    
        //设置收藏状态
        [self setCollectState];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.movieData) {
        
        self.title = self.movieData.title;
        
        self.url = [self.movieData.movie_id mutableCopy];
        
        //    加载数据
        [self _loadData];
        
    }else{
    
        self.title = self.collectdata.alt_title;
        
        self.url = [self.collectdata.movie_id mutableCopy];
        
        [self _loadData];
    
    }

}


//导航栏按钮返回事件
- (void)UIBarButtonItemAction:(UIBarButtonItem *)sender{

    [self dismissViewControllerAnimated:YES completion:nil];

}

//收藏事件
- (void)clickConllec:(UIBarButtonItem *)sender {

    NSString *str = _isCollectState ? @"取消收藏" : @"确认收藏";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //点击确认按钮
    if (buttonIndex == 0) {
        if (_isCollectState) {
            _isCollectState = NO;
            //取消收藏
            [[HQCollectData getInstance] deleteMovieCollectList:self.movieData];
        }else{
            _isCollectState = YES;
            
            //确认收藏
            [[HQCollectData getInstance] addMovieCollectList:self.movieDetailModel withMovieModel:self.movieData];
        }
        //设置状态
        [self setCollectState];
    }
}

//设置收藏状态
- (void)setCollectState{
    if (_isCollectState) {
        //已经收藏过
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"star_faved"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        //未收藏
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"star_unfav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

//加载数据
- (void)_loadData{
    
    self.url = [self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[HQNetWorkingTool shareTool] GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.movieDetailModel = [HQMovieDetailModel modelWithDic:responseObject];
        
        //    加载子视图
        [self _loadSubView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


- (void)_loadSubView{

    HQMovieDetailView * movieDetailView = [HQMovieDetailView viewFromNib];
    
    movieDetailView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 200);
    
    movieDetailView.movieDetailModel = self.movieDetailModel;
    movieDetailView.movieModel = self.movieData;
    
    [self.view addSubview:movieDetailView];

}

#pragma mark - share

//第三方授权
-(void)authWithPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager]  authWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
//        [self.tableView reloadData];
        UMSocialAuthResponse *authresponse = result;
        NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}


//获取用户信息
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        NSString *message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",userinfo.name,userinfo.iconurl,userinfo.gender];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

//分享按钮事件
- (void)share:(UIBarButtonItem *)sender {
    __weak typeof(self) weakSelf = self;
    //显示分享面板
    
        
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMShareMenuSelectionView *shareSelectionView, UMSocialPlatformType UMSocialPlatformType_Sina) {
        
        [weakSelf shareDataWithPlatform:UMSocialPlatformType_Sina];
    
        
    }];
}


- (void)shareDataWithPlatform:(UMSocialPlatformType)platformType
{
    // 创建UMSocialMessageObject实例进行分享
    // 分享数据对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString *title = @"友盟social";
    //  NSString *url = @"http://ios9quan.9quan.com.cn/www/wine/show/70488/37961/9502";//@"http://wsq.umeng.com";
    NSString *text = @"分享好电影，分享好心情";
    UIImage *image = [UIImage imageNamed:@"logo"];
    
    /* 以下分享类型，开发者可根据需求调用 */
    // 1、纯文本分享
    messageObject.text = text;
    
    // 2、 图片或图文分享
    // 图片分享参数可设置URL、NSData类型
    // 注意：由于iOS系统限制(iOS9+)，非HTTPS的URL图片可能会分享失败
    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:image];
    [shareObject setShareImage:image];
    
    // 3、视频分享
    //  UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:text thumImage:[UIImage imageNamed:@"icon"]];
    //  [shareObject setVideoUrl:@"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html"];
    //  messageObject.shareObject = shareObject;
    
    // 4、 音乐分享
    //   UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:text thumImage:[UIImage imageNamed:@"icon"]];
    //  [shareObject setMusicUrl:@"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3"];
    //  messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}



@end
