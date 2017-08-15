//
//  PiazzaWebViewCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol webHeightDelegate <NSObject>
@optional

-(void)countWebViewHeight:(CGFloat)height;
-(void)countWebViewNavTitle:(NSString *)titleStr;
-(void)tapWebViewImageProductNum:(NSString *)productNum;

@end

@interface PiazzaWebViewCell : UITableViewCell
@property (nonatomic, strong) id<webHeightDelegate>delegate;
@property (nonatomic,strong) WKWebView *webView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andwebUrl:(NSString *)webUrlStr;

-(void)setupInfoWithUrlStr:(NSString *)urlStr;

@end
