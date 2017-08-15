//
//  FastRegisterViewController.m
//  DuoSet
//
//  Created by lieon on 2017/6/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FastRegisterViewController.h"
#import "FirstStepFastRegisterVC.h"
#import "SecondStepFastRegisterVC.h"
#import "ThirdStepFastRegisterVC.h"


@interface FastRegisterViewController ()<UITextFieldDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIButton * closeBtn;
@property(nonatomic, strong) UIButton * backBtn;
@property(nonatomic, strong) FirstStepFastRegisterVC *fistStepVC;
@property(nonatomic, strong) SecondStepFastRegisterVC *secondVC;
@property(nonatomic, strong) ThirdStepFastRegisterVC *thirdVC;
@property(nonatomic, assign) BOOL isFastLogin;
@property(nonatomic, assign) BOOL isFindPassword;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, copy) NSString * phoneNum;
@property(nonatomic, copy) NSString * code;
@property(nonatomic,assign)ThirdpartyLoginType loginType;
@property(nonatomic,copy) NSString *accessToken;
@property(nonatomic,copy) NSString *openId;
@property(nonatomic,copy) NSString *unionId;
@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,assign) BOOL isthirdParty;
@end

@implementation FastRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self tapAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.fistStepVC.view endEditing:true];
    [super viewWillAppear:animated];
    if (self.isFastLogin) {
        [self.thirdVC configPhoneNum:self.phoneNum Captcha:self.code];
        [self.scrollView setContentOffset:CGPointMake(2 * mainScreenWidth, 0) animated:true];
        self.isFastLogin = false;
    }
    if (self.isFindPassword) {
        [self.fistStepVC configPhonum:self.phoneNum];
        self.isFindPassword = false;
    }
    if (_isthirdParty) {
        [self.thirdVC configWithThirdpartyLoginType:_loginType accessToken:_accessToken openId:_openId unionId:_unionId userInfo:_info];
    }
}

#pragma mark - setupUI

- (void)setupUI{
    self.title = @"手机快速注册";
    self.scrollView.scrollEnabled = false;
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView.frame = CGRectMake(0, 20, mainScreenWidth, mainScreenHeight);
    [self.view addSubview:self.scrollView];
     _fistStepVC = [[FirstStepFastRegisterVC alloc]init];
    _fistStepVC.isFromthirdLogin = self.isFromthirdLogin;
    _secondVC = [[SecondStepFastRegisterVC alloc]init];
    _thirdVC = [[ThirdStepFastRegisterVC alloc]init];
    _fistStepVC.view.backgroundColor = [UIColor whiteColor];
    _secondVC.view.backgroundColor = [UIColor whiteColor];
    _thirdVC.view.backgroundColor = [UIColor whiteColor];
    self.fistStepVC.view.frame = CGRectMake(0, 0, mainScreenWidth, mainScreenHeight);
    self.secondVC.view.frame = CGRectMake(mainScreenWidth, 0, mainScreenWidth, mainScreenHeight);
    _thirdVC.view.frame = CGRectMake(2 * mainScreenWidth, 0, mainScreenWidth, mainScreenHeight);
    [self addChildViewController:self.fistStepVC];
    [self addChildViewController:self.secondVC];
    [self addChildViewController:self.thirdVC];
    _scrollView.contentSize = CGSizeMake(self.childViewControllers.count * mainScreenWidth, 0);
    [self.scrollView addSubview:self.fistStepVC.view];
    [self.scrollView addSubview:self.secondVC.view];
    [self.scrollView addSubview:self.thirdVC.view];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.leftBarButtonItem = left;
    self.view.userInteractionEnabled = true;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapClosekeyBoard)];
    [self.view addGestureRecognizer:g];
}

#pragma mark - action

- (void)configWithThirdpartyLoginType:(ThirdpartyLoginType)loginType accessToken:(NSString *)accessToken openId:(NSString *)openId unionId:(NSString *)unionId userInfo:(NSDictionary *)info {
    _isthirdParty = true;
    _loginType = loginType;
    _accessToken = accessToken;
    _openId = openId;
    _unionId = unionId;
    _info = info;
}

- (void)configIsFastLoginPhoneNum: (NSString*)num AndCapchaCode: (NSString*)code {
    self.isFastLogin = true;
    self.phoneNum = num;
    self.code = code;
}

- (void)configIsFindPasswordPhoneNum: (NSString*)num {
    self.isFindPassword = true;
     self.phoneNum = num;
}

- (void)progressLeftSignInButton{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewTapClosekeyBoard{
    [self.view endEditing:true];
}

- (void)backAction {
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
   
    if (contentOffsetX >= mainScreenWidth && contentOffsetX < 2 * mainScreenWidth) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
    }
    if (contentOffsetX >= 2 * mainScreenWidth) {
         [self.scrollView setContentOffset:CGPointMake(mainScreenWidth, 0) animated:true];
    }
}

- (void)tapAction {
    __weak typeof(self) weakSelf = self;
    self.fistStepVC.nexBtntapAction = ^(NSString * phoneNum){
        [weakSelf.secondVC configPhoneNum:phoneNum];
        [weakSelf.scrollView setContentOffset:CGPointMake(mainScreenWidth, 0) animated:true];
    };
    self.secondVC.nextAction = ^(NSString *phoneNum, NSString * captcha) {
        [weakSelf.thirdVC configPhoneNum:phoneNum Captcha:captcha];
        [weakSelf.scrollView setContentOffset:CGPointMake(2 * mainScreenWidth, 0) animated:true];
    };
    self.thirdVC.registerAction = ^{
        UserInfo *info =[Utils getUserInfo];
        if( weakSelf.registerSuccecss) {
            weakSelf.registerSuccecss(info.phone);
        }
    };
}

#pragma mark - lazy load

-(UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView newAutoLayoutView];
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.showsHorizontalScrollIndicator = false;
    }
    return _scrollView;
}

- (UIButton *)closeBtn {
    if (_closeBtn == nil) {
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        [_closeBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
        _closeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_closeBtn addTarget:self action:@selector(progressLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _closeBtn;
}
- (UIButton *)backBtn {
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        [_backBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _backBtn;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (contentOffsetX < mainScreenWidth) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
        self.navigationItem.leftBarButtonItem = left;
    }
    if (contentOffsetX >= mainScreenWidth && contentOffsetX < 2 * mainScreenWidth) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
        self.navigationItem.leftBarButtonItem = left;
    }
    if (contentOffsetX >= 2 * mainScreenWidth) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
        self.navigationItem.leftBarButtonItem = left;
    }
}
@end
