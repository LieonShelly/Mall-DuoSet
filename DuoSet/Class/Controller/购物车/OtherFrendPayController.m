//
//  OtherFrendPayController.m
//  DuoSet
//
//  Created by fanfans on 2017/6/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OtherFrendPayController.h"

@interface OtherFrendPayController ()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *headerBgView;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *desTipLable;
@property(nonatomic,strong) UIButton *shareBtn;
@property(nonatomic,strong) UIView *midBgView;
@property(nonatomic,strong) UILabel *desLable;
@property(nonatomic,strong) UIView *footView;
//data
@property(nonatomic,copy)   NSString *orderId;
@property(nonatomic,copy)   NSString *price;

@end

@implementation OtherFrendPayController

-(instancetype)initWithOrderId:(NSString *)orderId andPrice:(NSString *)price{
    self = [super init];
    if (self) {
        _orderId = orderId;
        _price = price;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起代付请求";
    [self configUI];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    
    _headerBgView = [UIView newAutoLayoutView];
    _headerBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerBgView];
    
    _priceLable = [UILabel newAutoLayoutView];
    _priceLable.textColor = [UIColor mainColor];
    _priceLable.font = [UIFont systemFontOfSize:24];
    [_headerBgView addSubview:_priceLable];
    NSString *allStr = [NSString stringWithFormat:@"￥%@",_price];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:allStr];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 1)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(allStr.length - 2, 2)];
    self.priceLable.attributedText = attributeString;
    
    _desTipLable = [UILabel newAutoLayoutView];
    _desTipLable.textColor = [UIColor colorFromHex:0x222222];
    _desTipLable.font = [UIFont systemFontOfSize:14];
    _desTipLable.text = @"通过微信将代付请求发送给好友，即可让他帮你买单。";
    _desTipLable.numberOfLines = 2;
    [_headerBgView addSubview:_desTipLable];
    
    _shareBtn = [UIButton newAutoLayoutView];
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_shareBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [_shareBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    [_shareBtn setTitle:@"发送代付请求" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_headerBgView addSubview:_shareBtn];
    
    _midBgView = [UIView newAutoLayoutView];
    _midBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_midBgView];
    
    _desLable = [UILabel newAutoLayoutView];
    _desLable.textColor = [UIColor colorFromHex:0x808080];
    _desLable.numberOfLines = 0;
    NSString *text = @"说明：\n 1、对方需开通微信支付才能帮你买单，如果该好友没有开通，请 重新选择好友发送代付请求\n 2、如果发生退款，钱将返还至您付款时选择的支付账户中。";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,text.length)];
    self.desLable.attributedText = attributedString;
    [_midBgView addSubview:_desLable];
    
    _footView = [UIView newAutoLayoutView];
    _footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_footView];
    
    [self updateViewConstraints];
}

-(void)shareBtnAction{
    NSArray *imgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"share_icon"], nil];
    NSString *url = [NSString stringWithFormat:@"%@pay/payment-for-other/wechat/oauthUrl?orderId=%@",BaseUrl,_orderId];
    [Utils sharePlateType:SSDKPlatformSubTypeWechatSession ImageArray:imgArr contentText:@"我在哆集上挑了件美美的商品，快帮我付个款吧~" shareURL:url shareTitle:@"土豪大大，跪求代付~" andViewController:self success:^(SSDKPlatformType plateType) {
        
    }];
}

-(void)updateViewConstraints{
    if (!_didUpdateConstraints) {
        
        [_headerBgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10 + 64];
        [_headerBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_headerBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_headerBgView autoSetDimension:ALDimensionHeight toSize:200];
        
        [_shareBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        [_shareBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [_shareBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        [_shareBtn autoSetDimension:ALDimensionHeight toSize:44];
        
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
        [_priceLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_desTipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
        [_desTipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [_desTipLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        [_desTipLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_midBgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_headerBgView withOffset:10];
        [_midBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_midBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_midBgView autoSetDimension:ALDimensionHeight toSize:120];
        
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        
        [_footView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_midBgView withOffset:10];
        [_footView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_footView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_footView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = true;
    }
    [super updateViewConstraints];
}

@end
