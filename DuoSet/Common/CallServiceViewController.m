//
//  CallServiceViewController.m
//  DuoSet
//
//  Created by lieon on 2017/6/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CallServiceViewController.h"

@interface CallServiceViewController ()
@property(nonatomic, strong) UILabel * subTielabel;
@property(nonatomic, strong) UIButton *enterBtn;
@property(nonatomic, strong) UIButton *cancelBtn;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, assign) BOOL didUpdateContranits;

@end

@implementation CallServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.enterBtn];
    [self.view addSubview:self.subTielabel];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.line];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.enterBtn.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width * 0.5, 44);
    self.cancelBtn.frame = CGRectMake(self.view.bounds.size.width - self.view.bounds.size.width * 0.5, self.view.bounds.size.height - 44, self.view.bounds.size.width * 0.5, 44);
    self.line.frame = CGRectMake(0, self.view.bounds.size.height - 44 - 0.5, self.view.bounds.size.width, 0.5);
    self.subTielabel.frame = CGRectMake(12, 0, self.view.bounds.size.width - 24, self.view.bounds.size.height - 44 - 0.5);
}

- (void)updateViewConstraints {
    if (!_didUpdateContranits) {
//        [self.enterBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
//        [self.enterBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
//        [self.enterBtn autoSetDimension:ALDimensionHeight toSize:44];
//         [self.enterBtn autoSetDimension:ALDimensionWidth toSize:self.view.bounds.size.width * 0.5];
        
//        [self.cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//        [self.cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
//        [self.cancelBtn autoSetDimension:ALDimensionHeight toSize:44];
//        [self.cancelBtn autoSetDimension:ALDimensionWidth toSize:self.view.bounds.size.width * 0.5];
//        
//        [self.line autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//        [self.line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
//        [self.line autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.enterBtn];
//        [self.line autoSetDimension:ALDimensionHeight toSize:0.5];
//        
//        [self.subTielabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//        [self.subTielabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
//        [self.subTielabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
//        [self.subTielabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.line];
        _didUpdateContranits = true;
    }
}

#pragma mark - lazy load
- (UIButton *)enterBtn {
    if (_enterBtn == nil) {
        _enterBtn = [UIButton newAutoLayoutView];
        _enterBtn.backgroundColor = [UIColor redColor];
        _enterBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_enterBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [_enterBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        _enterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_enterBtn addTarget:self action:@selector(enterTapAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton newAutoLayoutView];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_cancelBtn setTitleColor: [UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        _cancelBtn.font = [UIFont systemFontOfSize:15];
        [_cancelBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
    }
    return _line;
}

- (UILabel *)subTielabel {
    if (_subTielabel == nil) {
        _subTielabel = [UILabel new];
        _subTielabel.backgroundColor = [UIColor whiteColor];
        _subTielabel.font =  [UIFont systemFontOfSize:15];
        _subTielabel.numberOfLines = 0;
        _subTielabel.textAlignment = NSTextAlignmentCenter;
        _subTielabel.textColor = [UIColor blackColor];
    }
    return _subTielabel;
}

#pragma mark - action

- (void)configMsg: (NSString*)msg WithEnterTitle: (NSString*)enterTitle {
    [self.enterBtn setTitle:enterTitle forState:UIControlStateNormal];
    self.subTielabel.text = msg;
}

- (void)configMsg: (NSString*)msg WithEnterTitle: (NSString*)enterTitle CancelTitle: (NSString*)cancelTitle {
    [self.enterBtn setTitle:enterTitle forState:UIControlStateNormal];
    [self.cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
    self.subTielabel.text = msg;
}

- (void)cancleAction {
    [self dismissViewControllerAnimated:true completion:nil];
    if (self.cancelAction) {
        self.cancelAction();
    }
}

- (void)enterTapAction {
    [self dismissViewControllerAnimated:true completion:nil];
    if (self.enterAction) {
        self.enterAction();
    }
}

@end
