//
//  WebPageController.m
//  BossApp
//
//  Created by fanfans on 5/9/16.
//  Copyright © 2016 ZDJY. All rights reserved.
//

#import "WebPageController.h"
#import <WebKit/WebKit.h>
#import "SingleProductNewController.h"
#import "CommentDetailsController.h"
#import "NewProductCommentController.h"
#import "NewReturnAndChangeController.h"
#import "ShareView.h"
#import "OrderDetailViewController.h"

@interface WebPageController()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (nonatomic,strong) NSString *urlStr;
@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic,strong) NSURLRequest *request;
@property (nonatomic,assign) BOOL showRight;
@property (nonatomic,assign) BOOL isInviteUser;

//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *leftCloseBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UIView *shareMarkView;
@property(nonatomic,strong) ShareView *shareView;
@property(nonatomic,assign) NSInteger requestCount;

@property(nonatomic,strong) WKNavigation *backNavigation;

@end

@implementation WebPageController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(instancetype)initWithUrlStr:(NSString *)url NavTitle:(NSString *)navTilte ShowRightBtn:(BOOL)showRight{
    self.urlStr = url;
    self.showRight = showRight;
    self.navTitle = navTilte;
    return [self init];
}

-(instancetype)initWithUrlStr:(NSString *)url NavTitle:(NSString *)navTilte{
    self.urlStr = url;
    self.navTitle = navTilte;
    return [self init];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = _navTitle;
    _requestCount = 0;
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 44, mainScreenWidth, mainScreenHeight - 44)];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.scrollView.scrollEnabled = true;
    _request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [_webView loadRequest:_request];
    [_webView.scrollView setAlwaysBounceVertical:YES];
    [_webView setAllowsBackForwardNavigationGestures:true];
    _webView.scrollView.showsVerticalScrollIndicator = false;
    _webView.scrollView.showsHorizontalScrollIndicator = false;
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.view addSubview:_webView];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame),2)];
    _progressView.trackTintColor = [UIColor colorFromHex:0xf7f7f7];
    _progressView.progressTintColor = [UIColor mainColor];
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    [self.view addSubview:_progressView];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self configNav];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftItemHandle) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:_leftBtn];
    
    _leftCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(44, 20, 44, 44)];
    [_leftCloseBtn setImage:[UIImage imageNamed:@"web_nav_close"] forState:UIControlStateNormal];
    [_leftCloseBtn addTarget:self action:@selector(close_coupons) forControlEvents:UIControlEventTouchUpInside];
    _leftCloseBtn.contentMode = UIViewContentModeCenter;
    _leftCloseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _leftCloseBtn.hidden = true;
    [_navView addSubview:_leftCloseBtn];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(88, 20, mainScreenWidth - 176, 44)];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [_navView addSubview:_titleLable];
    
    _rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [_rightBtn setImage:[UIImage imageNamed:@"nav_black_share"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightItemHandle) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.contentMode = UIViewContentModeCenter;
    _rightBtn.hidden = !_showRight;
    [_navView addSubview:_rightBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == _webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:_webView.estimatedProgress animated:YES];
            
            if(_webView.estimatedProgress >= 1.0f) {
                
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView) {
            self.titleLable.text = self.webView.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSURL *url = webView.URL;
    NSLog(@"url.absoluteString : %@",url.absoluteString);
    if ([url.absoluteString hasPrefix:@"https://cn.hlhdj.duoji/product/"]) {//单品详情
        NSString *str = [url.absoluteString stringByReplacingOccurrencesOfString:@"https://cn.hlhdj.duoji/product/" withString:@""];
        SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:str];
        singleItemVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:singleItemVC animated:true];
        return;
    }
    if ([url.absoluteString hasPrefix:@"https://cn.hlhdj.duoji/activity/new-user-invite"]) {
        _isInviteUser = true;
        [self rightItemHandle];
        return;
    }
    if ([url.absoluteString hasPrefix:@"https://cn.hlhdj.duoji/comment/detail/"]) {//跳转评价详情
        NSString *str = [url.absoluteString stringByReplacingOccurrencesOfString:@"https://cn.hlhdj.duoji/comment/detail/" withString:@""];
        NSArray *array = [str componentsSeparatedByString:@"/"];
        NSString *orderNo = @"";
        if (array.count > 0) {
            orderNo = array[0];
        }
        NSString *orderDetailId = @"";
        if (array.count > 1) {
            orderDetailId = array[1];
        }
        if (orderNo.length == 0 || orderDetailId.length == 0) {
            return;
        }
        CommentDetailsController *detailVC = [[CommentDetailsController alloc]initWithOrderNum:orderNo detailId:orderDetailId];
        detailVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:detailVC animated:true];
    }
    if ([url.absoluteString hasPrefix:@"https://cn.hlhdj.duoji/comment/post/"]) {//提交评论
        NSString *str = [url.absoluteString stringByReplacingOccurrencesOfString:@"https://cn.hlhdj.duoji/comment/post/" withString:@""];
        NSArray *array = [str componentsSeparatedByString:@"/"];
        NSString *orderNo = @"";
        if (array.count > 0) {
            orderNo = array[0];
        }
        NSString *orderDetailId = @"";
        if (array.count > 1) {
            orderDetailId = array[1];
        }
        if (orderNo.length == 0 || orderDetailId.length == 0) {
            return;
        }
        //跳转到新的评价界面
        NewProductCommentController *commentVC = [[NewProductCommentController alloc]initWithDetailId:orderDetailId];
        commentVC.hidesBottomBarWhenPushed = true;
        commentVC.commentedHanld = ^{
            UserInfo *info = [Utils getUserInfo];
            NSString *urlStr = [NSString stringWithFormat:@"%@user/order/commentPage?userId=%@&orderNo=%@",BaseUrl,info.userId,orderNo];
            _request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
            [_webView loadRequest:_request];
        };
        [self.navigationController pushViewController:commentVC animated:true];
        return;
    }
    if ([url.absoluteString hasPrefix:@"https://cn.hlhdj.duoji/user/order/applyReturn/"]) {
        NSString *str = [url.absoluteString stringByReplacingOccurrencesOfString:@"https://cn.hlhdj.duoji/user/order/applyReturn/" withString:@""];
        NewReturnAndChangeController *returnAndChangeVC = [[NewReturnAndChangeController alloc]initWithOrderDetailId:str];
        returnAndChangeVC.hidesBottomBarWhenPushed = true;
        returnAndChangeVC.succeedHandle = ^(NSString *orderNo){
            UserInfo *info = [Utils getUserInfo];
            NSString *urlStr = [NSString stringWithFormat:@"%@user/order/changePage?userId=%@",BaseUrl,info.userId];
            _request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
            [_webView loadRequest:_request];
        };
        [self.navigationController pushViewController:returnAndChangeVC animated:true];
        return;
    }
    
    _requestCount += 1;
    if (_requestCount > 1) {
        _leftCloseBtn.hidden = false;
    }
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    _backNavigation = [webView goBack];
//    if ([_backNavigation isEqual:navigation]) {
//        [_webView reload];
//        _backNavigation = nil;
//    }
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

-(void)leftItemHandle{
    if (_isFromRefund) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[OrderDetailViewController class]]) {
                [self.navigationController popToViewController:vc animated:true];
            }
        }
        return;
    }
    if (_isFromReturnAndChange) {
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *vc = vcArr[vcArr.count - 4];
        if (vc) {
            [self.navigationController popToViewController:vc animated:true];
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
        return;
    }
    if([self.webView canGoBack]){
        [self.webView goBack];
        [self.webView.scrollView setContentOffset:CGPointMake(0, -40) animated:true];
    }else{
        _leftCloseBtn.hidden = true;
        [self.navigationController popViewControllerAnimated:true];
    }
}

-(void)rightItemHandle{
    if ( _shareMarkView != nil) {
        _shareMarkView.hidden = false;
    }else{
        self.view.userInteractionEnabled = true;
        self.webView.userInteractionEnabled = true;
        _shareMarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
        _shareMarkView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.45];
        [self.view addSubview:_shareMarkView];
        
        _shareMarkView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenShareMarkView)];
        [_shareMarkView addGestureRecognizer:tap];
        
        [self.view bringSubviewToFront:_shareMarkView];
    }
    
    if (_shareView != nil) {
        _shareView.hidden = false;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _shareView.frame;
            frame.origin.y -= FitHeight(600.0);
            _shareView.frame = frame;
        }];
    }else{
        _shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(600.0))];
        __weak typeof(self) weakSelf = self;
        _shareView.cancelHandle = ^(){
            [weakSelf hiddenShareMarkView];
        };
        _shareView.shareHandle = ^(NSInteger index){
            [weakSelf shareCotentWithIndex:index];
        };
        [self.view addSubview:_shareView];
        UITapGestureRecognizer *singinVieTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareViewTap)];
        [_shareView addGestureRecognizer:singinVieTap];
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _shareView.frame;
            frame.origin.y -= FitHeight(600.0);
            _shareView.frame = frame;
        }];
    }
}

-(void)hiddenShareMarkView{
    _shareMarkView.hidden = true;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _shareView.frame;
        frame.origin.y = mainScreenHeight;
        _shareView.frame = frame;
    }];
}

-(void)shareViewTap{
    
}

-(void)close_coupons{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)shareCotentWithIndex:(NSInteger)index{
    //必买清单
    if (_isFromMustBuy) {
        NSArray *imgArr = [NSArray arrayWithObjects:_mustBuyData.cover, nil];
        NSString *url = [NSString stringWithFormat:@"%@product/buy-list/%@?_share=true",BaseUrl,_mustBuyData.list_id];
        if (index == 5) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = url;
            [self.view makeToast:@"已复制到剪贴板,快去分享给您的朋友吧"];
            return;
        }
        NSString *title =_mustBuyData.title;
        NSString *contenText = _mustBuyData.summary;
        SSDKPlatformType PlatformType = SSDKPlatformSubTypeWechatSession;
        if (index == 0) {
            PlatformType = SSDKPlatformSubTypeWechatSession;
        }
        if (index == 1) {
            PlatformType = SSDKPlatformSubTypeWechatTimeline;
        }
        if (index == 2) {
            PlatformType = SSDKPlatformTypeSinaWeibo;
        }
        if (index == 3) {
            PlatformType = SSDKPlatformSubTypeQQFriend;
        }
        if (index == 4) {
            PlatformType = SSDKPlatformSubTypeQZone;
        }
        if (PlatformType == SSDKPlatformTypeSinaWeibo) {
            contenText = [NSString stringWithFormat:@"%@\n%@",title,url];
        }
        [Utils sharePlateType:PlatformType ImageArray:imgArr contentText:contenText shareURL:url shareTitle:title andViewController:self success:^(SSDKPlatformType plateType) {
            NSString *urlStr = [NSString stringWithFormat:@"product/buy-list/share-success?id=%@",_mustBuyData.list_id];
            [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
                NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                if ([resultCode isEqualToString:@"ok"]) {
                    ShareSuccessBlock block = _shareSuccessHandle;
                    if (block) {
                        block();
                    }
                }
            } fail:^(NSError *error) {
                //
            }];
        }];
    }
    //设计师详情
    if (_isFromDesignerDetails) {
        NSArray *imgArr = [NSArray arrayWithObjects:_designerProductData.cover, nil];
        NSString *url = [NSString stringWithFormat:@"%@designer/works/%@?_share=true",BaseUrl,_designerProductData.obj_id];
        if (index == 5) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = url;
            [self.view makeToast:@"已复制到剪贴板,快去分享给您的朋友吧"];
            return;
        }
        NSString *title =_designerProductData.name;
        NSString *contenText = _designerProductData.descr;
        SSDKPlatformType PlatformType = SSDKPlatformSubTypeWechatSession;
        if (index == 0) {
            PlatformType = SSDKPlatformSubTypeWechatSession;
        }
        if (index == 1) {
            PlatformType = SSDKPlatformSubTypeWechatTimeline;
        }
        if (index == 2) {
            PlatformType = SSDKPlatformTypeSinaWeibo;
        }
        if (index == 3) {
            PlatformType = SSDKPlatformSubTypeQQFriend;
        }
        if (index == 4) {
            PlatformType = SSDKPlatformSubTypeQZone;
        }
        if (PlatformType == SSDKPlatformTypeSinaWeibo) {// @哆集官微
            contenText = [NSString stringWithFormat:@"%@\n%@",title,url];
        }
        [Utils sharePlateType:PlatformType ImageArray:imgArr contentText:contenText shareURL:url shareTitle:title andViewController:self success:^(SSDKPlatformType plateType) {
            //
        }];
    }
    //邀请注册
    if (_isInviteUser) {
        NSArray *imgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"share_icon"], nil];
        NSString *url = [NSString stringWithFormat:@"%@user/reg?inviteUserId=%@",BaseUrl,[Utils getUserInfo].userId];
        if (index == 5) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = url;
            [self.view makeToast:@"已复制到剪贴板,快去分享给您的朋友吧"];
            return;
        }
        NSString *title = @"Hi,朋友，送你5元现金券";
        NSString *contenText = @"我在哆集买到了许多时尚好看的衣服，你也来逛逛呗";
        SSDKPlatformType PlatformType = SSDKPlatformSubTypeWechatSession;
        if (index == 0) {
            PlatformType = SSDKPlatformSubTypeWechatSession;
        }
        if (index == 1) {
            PlatformType = SSDKPlatformSubTypeWechatTimeline;
        }
        if (index == 2) {
            PlatformType = SSDKPlatformTypeSinaWeibo;
        }
        if (index == 3) {
            PlatformType = SSDKPlatformSubTypeQQFriend;
        }
        if (index == 4) {
            PlatformType = SSDKPlatformSubTypeQZone;
        }
        if (PlatformType == SSDKPlatformTypeSinaWeibo) {
            contenText = [NSString stringWithFormat:@"%@\n%@",title,url];
        }
        [Utils sharePlateType:PlatformType ImageArray:imgArr contentText:contenText shareURL:url shareTitle:title andViewController:self success:^(SSDKPlatformType plateType) {
            //
        }];
    }
}

@end
