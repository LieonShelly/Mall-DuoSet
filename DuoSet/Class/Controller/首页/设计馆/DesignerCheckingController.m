//
//  DesignerCheckingController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerCheckingController.h"
#import "CustomAlert.h"

@interface DesignerCheckingController ()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *infoLable;
@property(nonatomic,strong) UILabel *phoneLable;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) CustomAlert *alertView;

@end

@implementation DesignerCheckingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审核中";
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    
    _imageView = [UIImageView newAutoLayoutView];
    _imageView.image = [UIImage imageNamed:@"designer_checking"];
    [self.view addSubview:_imageView];
    
    _infoLable = [UILabel newAutoLayoutView];
    _infoLable.font = [UIFont systemFontOfSize:14];
    _infoLable.textAlignment = NSTextAlignmentCenter;
    _infoLable.textColor = [UIColor colorFromHex:0x222222];
    NSString *str = @"5个工作日之后还未收到相关回复短信";
    _infoLable.text = str;
    [self.view addSubview:_infoLable];
    
    _phoneLable = [UILabel newAutoLayoutView];
    _phoneLable.font = [UIFont systemFontOfSize:14];
    NSString *phoneStr = @"请致电400-189-0090";
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:phoneStr];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(3, phoneStr.length - 3)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(3, phoneStr.length - 3)];
    self.phoneLable.attributedText = attributeString;
    _phoneLable.textAlignment = NSTextAlignmentCenter;
    _phoneLable.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contactAction)];
    [_phoneLable addGestureRecognizer:tap];
    [self.view addSubview:_phoneLable];
    
    [self updateViewConstraints];
}

- (void)contactAction {
    [self showAlertView:true];
}

#pragma mark - showAlertView
-(void)showAlertView:(BOOL)show{
    if (show) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.markView];
        [self.markView addSubview:self.alertView];
        self.markView.alpha = 0.f;
        self.alertView.alpha = 0.f;
        self.alertView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        [UIView animateWithDuration:0.25f animations:^{
            self.markView.alpha = 1;
            self.alertView.alpha = 1;
            self.alertView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            //
        }];
    }else{
        [UIView animateWithDuration:0.25f animations:^{
            self.markView.alpha = 0.f;
            self.alertView.alpha = 0.f;
            self.alertView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        } completion:^(BOOL finished) {
            [self.alertView removeFromSuperview];
            self.alertView = nil;
            [self.markView removeFromSuperview];
            self.markView = nil;
        }];
    }
}

-(CustomAlert *)alertView{
    if (_alertView == nil) {
        CGFloat width = self.view.bounds.size.width - 30 * 2;
        CGFloat height = 135;
        _alertView = [[CustomAlert alloc]initWithFrame:CGRectMake(0, 0, width, height) title:@"致电人工客服" message:@"400-189-0090" leftTitle:@"拨打" leftColor:[UIColor mainColor] leftTextColor:[UIColor whiteColor] rightTitle:@"取消" rightColor:[UIColor whiteColor] rightTextColor:[UIColor colorFromHex:0x222222]];
        _alertView.alertActionHandle = ^(NSInteger index) {
            if (index == 0) {
                [self showAlertView:false];
                NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-189-0090"];
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
            }
            if (index == 1) {
                [self showAlertView:false];
            }
        };
        _alertView.center = _markView.center;
    }
    return _alertView;
}

-(UIView *)markView{
    if (_markView == nil) {
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return _markView;
}

-(void)updateViewConstraints{
    if (!_didUpdateConstraints) {
        
        [_imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50 + 64];
        [_imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_infoLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageView withOffset:20];
        
        [_phoneLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_infoLable withOffset:5];
        [_phoneLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        _didUpdateConstraints = true;
    }
    [super updateViewConstraints];
}
@end
