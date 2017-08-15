//
//  ThirdpartyLoginController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ThirdpartyLoginController.h"
#import "ThirdpartyBindingController.h"
#import "RegisterViewController.h"
#import "FastRegisterViewController.h"

@interface ThirdpartyLoginController ()
//Data
@property(nonatomic,assign)ThirdpartyLoginType loginType;
@property(nonatomic,copy) NSString *accessToken;
@property(nonatomic,copy) NSString *openId;
@property(nonatomic,copy) NSString *unionId;
@property(nonatomic,strong) NSDictionary *info;
//View
@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *nameTipLabel;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UILabel *noAccountLable;
@property(nonatomic,strong) UIButton *registerBtn;
@property(nonatomic,strong) UILabel *bindingLabel;
@property(nonatomic,strong) UIButton *bindingBtn;

@end

@implementation ThirdpartyLoginController

-(instancetype)initWithThirdpartyLoginType:(ThirdpartyLoginType)loginType accessToken:(NSString *)accessToken openId:(NSString *)openId unionId:(NSString *)unionId userInfo:(NSDictionary *)info{
    self = [super init];
    if (self) {
        _loginType = loginType;
        _accessToken = accessToken;
        _openId = openId;
        _unionId = unionId;
        _info = info;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第三方登录";
    [self configUI];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    //headimgurl
    _avatar = [UIImageView newAutoLayoutView];//figureurl_qq_2
    _avatar.layer.cornerRadius = FitHeight(200.0) * 0.5;
    _avatar.layer.masksToBounds = true;
    NSString *urlStr = @"";
    if (_loginType == ThirdpartyLoginWithQQ) {
        if ([_info objectForKey:@"figureurl_qq_2"]) {
            urlStr = [NSString stringWithFormat:@"%@",[_info objectForKey:@"figureurl_qq_2"]];
        }
    }
    if (_loginType == ThirdpartyLoginWithWechat) {
        if ([_info objectForKey:@"headimgurl"]) {
            urlStr = [NSString stringWithFormat:@"%@",[_info objectForKey:@"headimgurl"]];
        }
    }
    if (_loginType == ThirdpartyLoginWithSina) {
        if ([_info objectForKey:@"profile_image_url"]) {
            urlStr = [NSString stringWithFormat:@"%@",[_info objectForKey:@"profile_image_url"]];
        }
    }
    [_avatar sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholderImage_avatar options:0];
    [self.view addSubview:_avatar];
    
    _nameTipLabel = [UILabel newAutoLayoutView];
    _nameTipLabel.textColor = [UIColor colorFromHex:0x808080];
    _nameTipLabel.textAlignment = NSTextAlignmentLeft;
    _nameTipLabel.font = CUSFONT(13);
    NSString *typeStr = @"";
    if (_loginType == ThirdpartyLoginWithQQ) {
        typeStr = @"QQ";
    }
    if (_loginType == ThirdpartyLoginWithWechat) {
        typeStr = @"微信";
    }
    if (_loginType == ThirdpartyLoginWithSina) {
        typeStr = @"微博";
    }
    _nameTipLabel.text = [NSString stringWithFormat:@"亲爱的%@用户:",typeStr];
    [self.view addSubview:_nameTipLabel];
    
    _nameLable = [UILabel newAutoLayoutView];
    _nameLable.textColor = [UIColor colorFromHex:0x222222];
    _nameLable.textAlignment = NSTextAlignmentLeft;
    _nameLable.font = CUSFONT(13);
    NSString *nameStr = @"";
    if (_loginType == ThirdpartyLoginWithQQ) {
        if ([_info objectForKey:@"nickname"]) {
            nameStr = [NSString stringWithFormat:@"%@",[_info objectForKey:@"nickname"]];
        }
    }
    if (_loginType == ThirdpartyLoginWithWechat) {
        if ([_info objectForKey:@"nickname"]) {
            nameStr = [NSString stringWithFormat:@"%@",[_info objectForKey:@"nickname"]];
        }
    }
    if (_loginType == ThirdpartyLoginWithSina) {
        if ([_info objectForKey:@"name"]) {
            nameStr = [NSString stringWithFormat:@"%@",[_info objectForKey:@"name"]];
        }
    }
    _nameLable.text = nameStr;
    [self.view addSubview:_nameLable];
    
    _tipsLable = [UILabel newAutoLayoutView];
    _tipsLable.text = @"为了给您更方便的服务，请你关联一个哆集账号";
    _tipsLable.textColor = [UIColor colorFromHex:0x222222];
    _tipsLable.font = CUSFONT(13);
    _tipsLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_tipsLable];
    
    _noAccountLable = [UILabel newAutoLayoutView];
    _noAccountLable.text = @"还没有哆集账号?";
    _noAccountLable.textColor = [UIColor colorFromHex:0x808080];
    _noAccountLable.font = CUSFONT(13);
    _noAccountLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_noAccountLable];
    
    _registerBtn = [UIButton newAutoLayoutView];
    [_registerBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [_registerBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    _registerBtn.titleLabel.font = CUSFONT(16);
    [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    _bindingLabel = [UILabel newAutoLayoutView];
    _bindingLabel.text = @"已有哆集账号?";
    _bindingLabel.textColor = [UIColor colorFromHex:0x808080];
    _bindingLabel.font = CUSFONT(14);
    _bindingLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_bindingLabel];
    
    _bindingBtn = [UIButton newAutoLayoutView];
    _bindingBtn.titleLabel.font = CUSFONT(16);
    _bindingBtn.backgroundColor = [UIColor whiteColor];
    _bindingBtn.layer.borderColor = [UIColor colorFromHex:0xcccccc].CGColor;
    _bindingBtn.layer.cornerRadius = 3;
    _bindingBtn.layer.borderWidth = 1;
    [_bindingBtn setTitle:@"立即关联" forState:UIControlStateNormal];
    [_bindingBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
    [_bindingBtn addTarget:self action:@selector(bindingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bindingBtn];
    
    [self updateViewConstraints];
}

-(void)registerBtnAction{
    FastRegisterViewController *registerVC = [[FastRegisterViewController alloc]init];
    registerVC.registerSuccecss = ^(NSString *phoneNum) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
        [self dismissViewControllerAnimated:true completion:nil];
    };
    [registerVC configWithThirdpartyLoginType:_loginType accessToken:_accessToken openId:_openId unionId:_unionId userInfo:_info];
    registerVC.hidesBottomBarWhenPushed = true;
    registerVC.isFromthirdLogin = true;
    [self.navigationController pushViewController:registerVC animated:true];
}

-(void)bindingBtnAction{
    ThirdpartyBindingController *bindingVC = [[ThirdpartyBindingController alloc]initWithThirdpartyLoginType:_loginType accessToken:_accessToken openId:_openId unionId:_unionId userInfo:_info];
    bindingVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:bindingVC animated:true];
}

- (void)updateViewConstraints{
    if (!_didUpdateConstraints) {
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(88.0) + 64];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitHeight(200.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitHeight(200.0)];
        [_avatar autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_nameTipLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(36.0)];
        [_nameTipLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(360.0) + 64];
        
        [_nameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_nameTipLabel];
        [_nameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_nameTipLabel withOffset:2];
        
        [_tipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameTipLabel];
        [_tipsLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLable withOffset:3];
        
        [_noAccountLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameTipLabel];
        [_noAccountLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipsLable withOffset:FitHeight(60.0)];
        
        [_registerBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_registerBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_registerBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_noAccountLable withOffset:5];
        [_registerBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        
        [_bindingLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameTipLabel];
        [_bindingLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_registerBtn withOffset:FitHeight(90.0)];
        
        [_bindingBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_bindingBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_bindingBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_bindingLabel withOffset:5];
        [_bindingBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateViewConstraints];
}

@end
