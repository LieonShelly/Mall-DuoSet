//
//  SingleProductWebView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SingleProductWebView.h"
#import <WebKit/WebKit.h>

@interface SingleProductWebView()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>

@property(nonatomic,copy) NSString *productNum;
@property (nonatomic,strong) WKWebView *webView;
//@property (strong, nonatomic) UIProgressView *progressView;
@property (nonatomic,strong) NSURLRequest *request;

@end

@implementation SingleProductWebView

-(instancetype)initWithFrame:(CGRect)frame andProductNum:(NSString *)productNum{
    self = [super initWithFrame:frame];
    if (self) {
        
        _productNum = productNum;
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight - 64 - 50)];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        NSString *str = [NSString stringWithFormat:@"%@product/%@/detail-pic",BaseUrl,_productNum];
        _request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
        [_webView loadRequest:_request];
        [_webView.scrollView setAlwaysBounceVertical:YES];
        _webView.scrollView.showsVerticalScrollIndicator = false;
        _webView.scrollView.showsHorizontalScrollIndicator = false;
        _webView.scrollView.delegate = self;
        _webView.userInteractionEnabled = true;
        self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        
        
//        [_webView setAllowsBackForwardNavigationGestures:true];
        [self addSubview:_webView];
        
    }
    return self;
}

- (void)dealloc {
    NSLog(@"dealloc - SingleProductWebView");
    _webView.navigationDelegate = nil;
    _webView.UIDelegate = nil;
    _webView.scrollView.delegate = nil;
}

#pragma mark - WKNavigationDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSURL *url = webView.URL;
    NSLog(@"url.absoluteString : %@",url.absoluteString);
    if ([url.absoluteString hasPrefix:@"https://cn.hlhdj.duoji/callPhone/"]) {//拨打电话
        NSString *str = [url.absoluteString stringByReplacingOccurrencesOfString:@"https://cn.hlhdj.duoji/callPhone/" withString:@""];
        WebViewPhoneCallBlock block = _webCallHandle;
        if (block) {
            block(str);
        }
        return;
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *jsMeta = [NSString stringWithFormat:@"var meta = document.createElement('meta');meta.content='width=device-width,initial-scale=1.0,minimum-scale=.5,maximum-scale=3';meta.name='viewport';document.getElementsByTagName('head')[0].appendChild(meta);"];
    [webView evaluateJavaScript:jsMeta completionHandler:^(id _Nullable objerct, NSError * _Nullable error) {
        //
    }];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

@end
