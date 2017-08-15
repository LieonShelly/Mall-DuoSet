//
//  DetailWebCell.m
//  BossApp
//
//  Created by fanfans on 5/19/16.
//  Copyright © 2016 ZDJY. All rights reserved.
//

#import "DetailWebCell.h"

@interface DetailWebCell()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) NSString *urlStr;
@property (nonatomic,strong) NSURLRequest *request;
@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,assign) BOOL IsSend;

@end

@implementation DetailWebCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];;
    if (self) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0)];
        _webView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        _webView.delegate = self;
        _webView.userInteractionEnabled = true;
        _webView.scrollView.delegate = self;
        [self.contentView addSubview:_webView];
        
//        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

//- (void)updateConstraints{
//    if (!_didUpdateConstraints) {
//        [_webView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//        [_webView autoPinEdgeToSuperviewEdge:ALEdgeRight];
//        [_webView autoPinEdgeToSuperviewEdge:ALEdgeTop];
//        [_webView autoSetDimension:ALDimensionHeight toSize:mainScreenHeight - 50 - 64];
//        
//        _didUpdateConstraints = YES;
//    }
//    [super updateConstraints];
//}

-(void)requestDataWithUrl:(NSString *)url{
    if (_request == nil) {
        _request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [_webView loadRequest:_request];
    }
}

#pragma mark - UIWebViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= -20) {
        if (!_IsSend) {
            ScrollToTopHandle  block = _topBlock;
            if (block) {
                block();
            }
        }
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    _IsSend = false;
//    VBossLog(@"webViewDidStartLoad");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    if (_delegate && [_delegate respondsToSelector:@selector(countWebViewHeight:)]) {
        [_delegate countWebViewHeight:height];
    }
    _webView.scrollView.contentSize = CGSizeMake(mainScreenWidth,height);
    CGRect frame = webView.frame;
    frame.size.height = height;
    _webView.frame = frame;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
//    VBossLog(@"didFailLoadWithError");
}

@end
