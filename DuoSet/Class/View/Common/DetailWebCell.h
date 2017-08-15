//
//  DetailWebCell.h
//  BossApp
//
//  Created by fanfans on 5/19/16.
//  Copyright © 2016 ZDJY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DetailWebCellHeightDelegate <NSObject>
@optional

-(void)countWebViewHeight:(CGFloat)height;
-(void)countWebViewNavTitle:(NSString *)titleStr;
-(void)tapWebViewImageProductNum:(NSString *)productNum;

@end

typedef void (^ScrollToTopHandle)();

@interface DetailWebCell : UITableViewCell

@property(nonatomic,copy) ScrollToTopHandle topBlock;
@property (nonatomic, strong) id<DetailWebCellHeightDelegate>delegate;

@property (nonatomic,strong) UIWebView *webView;

-(void)requestDataWithUrl:(NSString *)url;

@end
