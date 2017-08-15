//
//  ClassificationWebController.m
//  DuoSet
//
//  Created by fanfans on 2017/6/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ClassificationWebController.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import <WebKit/WebKit.h>
#import "ScreenProductController.h"

@interface ClassificationWebController ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>
//Nav
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIView *navline;
@property (nonatomic,strong) UILabel *hotWordLable;
@property (nonatomic,strong) UIView *unredView;
//Web
@property (nonatomic,strong) WKWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (nonatomic,strong) NSURLRequest *request;

@end

@implementation ClassificationWebController

#pragma mark - viewWillAppear & viewWillDisappear  & viewDidLoad
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if ([self checkLogin]) {
        if ([self checkRefreshToken]) {
            [self getvalidateNewMessage];
        }else{
            [RequestManager refershTokenSuccess:^{
                [self getvalidateNewMessage];
            }];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavView];
    [self getHotWordData];
    [self configWebView];
}

-(void)getHotWordData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/keyword" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] &&[[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]] ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"hot"] && [[objDic objectForKey:@"hot"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *hotDic = [objDic objectForKey:@"hot"];
                    if ([hotDic objectForKey:@"word"]) {
                        _hotWordLable.text = [NSString stringWithFormat:@"%@",[hotDic objectForKey:@"word"]];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configNavView{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navView];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    leftBtn.titleLabel.font = CUSFONT(10);
    [leftBtn setImage:[UIImage imageNamed:@"home_nav_sgin"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(progressClassificationLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:leftBtn];
    
    UIButton *centerSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(44, 26, mainScreenWidth - 44 - 44, 31)];
    centerSearchButton.backgroundColor = [UIColor colorFromHex:0xf5f5f5];
    centerSearchButton.layer.cornerRadius = 16;
    centerSearchButton.layer.masksToBounds = true;
    [centerSearchButton addTarget:self action:@selector(progressClassificationCenterSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:centerSearchButton];
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 9, 13, 13)];
    leftView.image = [UIImage imageNamed:@"home_nav_search"];
    leftView.contentMode = UIViewContentModeScaleAspectFill;
    [centerSearchButton addSubview:leftView];
    
    _hotWordLable = [[UILabel alloc]initWithFrame:CGRectMake(37, 0, FitWith(300.0), 31)];
    _hotWordLable.textColor = [UIColor colorFromHex:0x808080];
    _hotWordLable.font = [UIFont systemFontOfSize:13];
    _hotWordLable.textAlignment = NSTextAlignmentLeft;
    [centerSearchButton addSubview:_hotWordLable];
    
    UIButton *rightMessageCenterButton = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [rightMessageCenterButton setImage:[UIImage imageNamed:@"home_nav_message_01"] forState:UIControlStateNormal];
    [rightMessageCenterButton addTarget:self action:@selector(progressClassificationRightMessageCenterButton) forControlEvents:UIControlEventTouchUpInside];
    rightMessageCenterButton.contentMode = UIViewContentModeCenter;
    [_navView addSubview:rightMessageCenterButton];
    //未读消息提醒标识
    _unredView = [[UIView alloc]initWithFrame:CGRectMake(30, 5, 8, 8)];
    _unredView.backgroundColor = [UIColor mainColor];
    _unredView.layer.masksToBounds = true;
    _unredView.layer.cornerRadius = 4;
    _unredView.hidden = true;
    [rightMessageCenterButton addSubview:_unredView];
    
    _navline = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:1];
    [_navView addSubview:_navline];
    
    [self.view bringSubviewToFront:_navView];
}

-(void)configWebView{
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64 - 50)];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    NSString *str = [NSString stringWithFormat:@"%@product/classify/html",BaseUrl];
    _request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [_webView loadRequest:_request];
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [_webView.scrollView setAlwaysBounceVertical:YES];
    _webView.scrollView.mj_header = [FFGifHeader headerWithRefreshingBlock:^{
        _request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20];
        [_webView loadRequest:_request];
    }];
    _webView.scrollView.showsVerticalScrollIndicator = false;
    _webView.scrollView.showsHorizontalScrollIndicator = false;
    _webView.scrollView.delegate = self;
    [_webView setAllowsBackForwardNavigationGestures:true];
    [self.view addSubview:_webView];
    
    [_webView loadRequest:_request];
}

- (void)dealloc {
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
}

#pragma mark - WKNavigationDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [RequestManager showHud:true showString:@"" enableUserActions:false withViewController:self];
    NSURL *url = webView.URL;
    NSLog(@"url.absoluteString : %@",url.absoluteString);
    if ([url.absoluteString hasPrefix:@"https://cn.hlhdj.duoji/classify/"]) {//分类id
        NSString *str = [url.absoluteString stringByReplacingOccurrencesOfString:@"https://cn.hlhdj.duoji/classify/" withString:@""];
        ScreenProductController *popularVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andItemId:str];
        popularVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:popularVC  animated:YES];
        return;
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [RequestManager showHud:false showString:@"" enableUserActions:false withViewController:self];
    [_webView.scrollView.mj_header endRefreshing];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [RequestManager showHud:false showString:@"" enableUserActions:false withViewController:self];
    [_webView.scrollView.mj_header endRefreshing];
    NSString *str = [NSString stringWithFormat:@"%@product/classify/html",BaseUrl];
    _request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [_webView loadRequest:_request];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}

#pragma mark - Nav btnActionHandle
- (void)progressClassificationCenterSearchButton{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:searchVC animated:true];
}

- (void)progressClassificationLeftSignInButton{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    UserInfo *info = [Utils getUserInfo];
    WebPageController *siginVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@user/sign/html?userId=%@",BaseUrl,info.userId] NavTitle:@""];
    siginVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:siginVC animated:true];
}

- (void)progressClassificationRightMessageCenterButton{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    MessageCenterViewController *messageCenterVC = [[MessageCenterViewController alloc] init];
    messageCenterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageCenterVC animated:true];
}

#pragma mark - 获取未读消息数量
-(void)getvalidateNewMessage{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/message/validateNewMessage" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]){
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"count"]) {//_footView
                    NSString *count = [objDic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[objDic objectForKey:@"count"]] : @"0";
                    _unredView.hidden = count.integerValue == 0;
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 判断登录
-(BOOL)checkLogin{
    UserInfo *info = [Utils getUserInfo];
    return info.token.length > 0;
}

-(void)userlogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    CustomNavController *loginNav = [[CustomNavController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
}

-(BOOL)checkRefreshToken{
    if ([Utils getUserInfo].token.length > 0) {
        UserInfo *info = [Utils getUserInfo];
        NSDate *now = [NSDate date];
        NSInteger tmp = [now timeIntervalSinceDate:info.refreshTokenDate];
        if (tmp < (info.expiresIn.integerValue)/1000) {//还没过期了
            return true;
        }
    }
    return false;
}

-(void)didReceiveMemoryWarning{
    NSLog(@"didReceiveMemoryWarning - ClassificationWebController ");
}

@end
