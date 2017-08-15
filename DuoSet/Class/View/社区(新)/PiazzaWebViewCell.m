//
//  PiazzaWebViewCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaWebViewCell.h"


@interface PiazzaWebViewCell()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,copy) NSString *webUrlStr;
@property (strong, nonatomic) UIProgressView *progressView;
@property (nonatomic,strong) NSURLRequest *request;

@end

@implementation PiazzaWebViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andwebUrl:(NSString *)webUrlStr{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _webUrlStr = webUrlStr;
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 1000)];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView.scrollView setAlwaysBounceVertical:YES];
        [_webView setAllowsBackForwardNavigationGestures:true];
        _webView.scrollView.scrollEnabled = false;
        [self addSubview:_webView];
        
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame),2)];
        _progressView.trackTintColor = [UIColor colorFromHex:0xf7f7f7];
        _progressView.progressTintColor = [UIColor mainColor];
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
        [self addSubview:_progressView];
        
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
        
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        
        [_webView loadRequest:_request];
    }
    return self;
}


-(void)setupInfoWithUrlStr:(NSString *)urlStr{
    if (_request == nil) {
        _request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
        [_webView loadRequest:_request];
    }
}

//进度条
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
            if (_delegate && [_delegate respondsToSelector:@selector(countWebViewNavTitle:)]) {
                [_delegate countWebViewNavTitle:self.webView.title];
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    } else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
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
        if (_delegate && [_delegate respondsToSelector:@selector(tapWebViewImageProductNum:)]) {
            [_delegate tapWebViewImageProductNum:str];
        }
        return;
    }
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSURL *url = webView.URL;
    NSLog(@"url.absoluteString : %@",url.absoluteString);
}


// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id Result, NSError * error) {
        NSNumber *num = Result;
        CGFloat height = num.floatValue + 20;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(countWebViewHeight:)]) {
                [_delegate countWebViewHeight:height];
            }
            CGRect frame = webView.frame;
            frame.size.height = height;
            _webView.frame = frame;
        });
    }];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}


@end
