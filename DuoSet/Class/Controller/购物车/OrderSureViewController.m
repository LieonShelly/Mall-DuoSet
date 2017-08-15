//
//  OrderSureViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "OrderSureViewController.h"
#import "OrderSureAddressCell.h"
#import "BillChoiceController.h"
#import "AddressModel.h"
#import "Product.h"
#import "OrderSureNextActionCell.h"
#import "OrderProductCell.h"
#import "OrderSureMoreProductCell.h"
#import "YouhuiJuanModel.h"
#import "SeletcedCouponController.h"
#import "OrderDetailViewController.h"
#import "OrderSureProductListController.h"
#import "OrderSureTotalPriceCell.h"
#import "OrderSureGlobalInputCell.h"
#import "OrderSureGlobalTotalPriceCell.h"
#import "CallServiceViewController.h"
#import "AllOrderViewController.h"
#import "OrderSureOutOfStockView.h"
#import "SellOutProductData.h"
#import "CustomAlert.h"

@interface OrderSureViewController () <UITableViewDelegate, UITableViewDataSource>


//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UILabel *titleLable;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *buyItemArr;
@property (nonatomic, strong) AddressModel *address;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) NSDictionary *resultDic;
@property (nonatomic, copy)   NSString *couponId;
@property (nonatomic, strong) NSArray *cartIdArr;
@property (nonatomic, strong) ShopCarSureData *dataItem;
@property (nonatomic, assign) OrderSuerStatus status;
@property (nonatomic, assign) BillChoiceStyle billStatus;
@property (nonatomic, copy) NSString *invoiceName;
@property (nonatomic, copy) NSString *phoneStr;
@property (nonatomic, copy) NSString *emailStr;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *idCard;

@property (nonatomic,strong) TransitionAnimator *animator;

@property (nonatomic,strong) UIView *markView;
@property (nonatomic,strong) OrderSureOutOfStockView *outOfStockView;
@property (nonatomic,strong) NSMutableArray *sellOutArr;

@property(nonatomic,strong) CustomAlert *alertView;
@property(nonatomic,assign) BOOL alertIsShow;
@property(nonatomic,assign) BOOL sellOutIsShow;

@end

@implementation OrderSureViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
    manager.shouldResignOnTouchOutside = true;
    manager.shouldToolbarUsesTextFieldTintColor = true;
    manager.enableAutoToolbar = true;
    manager.shouldShowTextFieldPlaceholder = false;
    manager.enableAutoToolbar = true;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
    manager.shouldResignOnTouchOutside = false;
    manager.shouldToolbarUsesTextFieldTintColor = true;
    manager.enableAutoToolbar = true;
    manager.shouldShowTextFieldPlaceholder = false;
    manager.enableAutoToolbar = false;
}

-(instancetype)initWithOrderSuerStatus:(OrderSuerStatus)status ShopCarSureData:(ShopCarSureData *)dataItem andShopCartIdArr:(NSArray *)cartIdArr{
    self = [super init];
    if (self) {
        _status = status;
        _cartIdArr = cartIdArr;
        _dataItem = dataItem;
    }
    return self;
}

-(instancetype)initWithBuyProductArr:(NSMutableArray *)buyItemArr{
    self = [super init];
    if (self) {
        _buyItemArr = buyItemArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isEdit = _dataItem.trueName.length > 0 && [Utils IsIdentityCard:_dataItem.idCard];
    [self configNav];
    [self creatUI];
    _billStatus = BillChoiceStatusWithNoNeed;
    [self configData];
    [self confiAdressData];
}

-(void)configData{
    if (_status == OrderSuerStatusByCart) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_cartIdArr forKey:@"cartIds"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/order/confirm" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [responseDic objectForKey:@"object"];
                    ShopCarSureData *data = [ShopCarSureData dataForDictionary:objDic];
                    _dataItem = data;
                    _trueName = _dataItem.trueName;
                    _idCard = _dataItem.idCard;
                    [self setupFootViewShowPrice];
                    [_tableView reloadData];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_productNumber forKey:@"productNumber"];
        [params setObject:_propertyCollection forKey:@"propertyCollection"];
        [params setObject:[NSNumber numberWithInteger:_count.integerValue] forKey:@"count"];
        NSString *urlStr = @"user/order/single/confirm";
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [responseDic objectForKey:@"object"];
                    ShopCarSureData *data = [ShopCarSureData dataForDictionary:objDic];
                    _dataItem = data;
                    _trueName = _dataItem.trueName;
                    _idCard = _dataItem.idCard;
                    [self setupFootViewShowPrice];
                    [_tableView reloadData];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}
//获取地址
-(void)confiAdressData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/address" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]){
                NSArray *objArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objArr) {
                    AddressModel *item = [AddressModel dataForDictionary:d];
                    if (item.isDEFAULT) {
                        _address = item;
                    }
                }
                if (_address) {
                    [_tableView reloadData];
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,20,44,44)];
    _leftBtn.titleLabel.font = CUSFONT(13);
    [_leftBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftBtnBackHandle) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_leftBtn];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _titleLable.text = @"确认订单";
    [_navView addSubview:_titleLable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

-(void)leftBtnBackHandle{
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
            _alertIsShow = true;
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
            _alertIsShow = false;
        }];
    }
}

-(CustomAlert *)alertView{
    if (_alertView == nil) {
        CGFloat width = self.view.bounds.size.width - 30 * 2;
        CGFloat height = 135;
        _alertView = [[CustomAlert alloc]initWithFrame:CGRectMake(0, 0, width, height) title:nil message:@"便宜不等人，请三思而行~" leftTitle:@"我再想想" leftColor:[UIColor whiteColor] leftTextColor:[UIColor colorFromHex:0x222222] rightTitle:@"去意已决" rightColor:[UIColor mainColor] rightTextColor:[UIColor whiteColor]];
        _alertView.alertActionHandle = ^(NSInteger index) {
            if (index == 0) {
                [self showAlertView:false];
            }
            if (index == 1) {
                [self showAlertView:false];
                [self.navigationController popViewControllerAnimated:true];
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

-(void)creatUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    CGRect tableViewFrame;
    if (_isGlobal) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(92.0))];
        headerView.backgroundColor = [UIColor colorFromHex:0xfff2f2];
        [self.view addSubview:headerView];
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(20.0), 0, FitWith(60.0), FitHeight(92.0))];
        imgV.contentMode = UIViewContentModeCenter;
        imgV.image = [UIImage imageNamed:@"global_header_tipsIcon"];
        [headerView addSubview:imgV];
        
        UILabel *tipsLable = [[UILabel alloc]initWithFrame:CGRectMake(imgV.frame.origin.x + imgV.frame.size.width, 0, mainScreenWidth - imgV.frame.origin.x - imgV.frame.size.width - FitWith(20.0) , FitHeight(92.0))];
        tipsLable.text = @"温馨提示：全球购商品不支持7/15天无理由退换的商品，请确认相关 商品信息后提交订单";
        tipsLable.numberOfLines = 2;
        tipsLable.font = CUSNEwFONT(13);
        tipsLable.textColor = [UIColor colorFromHex:0x808080];
        [headerView addSubview:tipsLable];
        
        tableViewFrame = CGRectMake(0, FitHeight(92.0) + 64, mainScreenWidth, mainScreenHeight - FitHeight(92.0) - 64);
    }else{
        tableViewFrame = CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - FitHeight(176.0));
    }
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, CGFLOAT_MIN)];
    self.tableView.tableHeaderView = tableViewHeaderView;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"YouHuiJuanCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
   _footView = [[UIView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - FitHeight(176.0) , mainScreenWidth, FitHeight(76))];
    _footView.backgroundColor = [UIColor colorFromHex:0xfff2f2];
    _footView.hidden = true;
    [self.view addSubview:_footView];
    
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(26.0), 0, mainScreenWidth - FitWith(52.0), _footView.frame.size.height)];
    _addressLabel.font = CUSNEwFONT(14);
    _addressLabel.textColor = [UIColor colorFromHex:0x808080];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    [_footView addSubview:_addressLabel];
    
    CGFloat btnW = 100;
    CGFloat btnH = FitHeight(100.0);
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - btnH, mainScreenWidth, btnH)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,0, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
    [bottomView addSubview:line];
    
    _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainScreenWidth-btnW, 0, btnW, btnH)];
    _sureBtn.titleLabel.font = CUSFONT(14);
    _sureBtn.backgroundColor = [UIColor mainColor];
    [_sureBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_sureBtn];
    
    _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth-btnW-15, btnH)];
    _totalPriceLabel.textAlignment = UITextLayoutDirectionRight;
    _totalPriceLabel.font = CUSNEwFONT(18);
    _totalPriceLabel.textColor = [UIColor mainColor];
    [bottomView addSubview:_totalPriceLabel];
}

-(void)setupFootViewShowPrice{
    NSString *text = [NSString stringWithFormat:@"实付金额：￥%@",_dataItem.totalPrice];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(18) range:NSMakeRange(0,5)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x212121] range:NSMakeRange(0,5)];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(16) range:NSMakeRange(5,1)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(5,1)];
    _totalPriceLabel.attributedText = attributeString;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        if (_isGlobal) {
            return 1;
        }else{
            return 0;
        }
    }
    if (section == 2){
        if (_dataItem != nil) {
            return 1;
        }else{
            return 0;
        }
    }
    if (section == 3 ){
        return 2;
    }
    if (section == 4) {
        return 1;
    }
    if (section == 5) {
        return _dataItem == nil ?  0 : 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_address == nil) {
            static NSString *NOAddressCellID = @"NOAddressCellID";
            UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:NOAddressCellID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NOAddressCellID];
            }
            cell.textLabel.text = @"请添加收货地址";
            return cell;
        }else{
            static NSString *OrderSureAddressCellID = @"OrderSureAddressCellID";
            OrderSureAddressCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderSureAddressCellID];
            if (cell == nil) {
                cell = [[OrderSureAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderSureAddressCellID];
            }
            if (_address != nil) {
                [cell setupInfoWithAddressModel:_address];
                _addressLabel.text = [NSString stringWithFormat:@"送至：%@%@%@%@",_address.province,_address.city,_address.area,_address.addr];
            }
            return cell;
        }
    }
    if (indexPath.section == 1) {
        static NSString *OrderSureGlobalInputCellID = @"OrderSureGlobalInputCellID";
        OrderSureGlobalInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderSureGlobalInputCellID];
        if (cell == nil) {
            cell = [[OrderSureGlobalInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderSureGlobalInputCellID];
        }
        [cell setupRealName:_trueName AndIdentityCard:_idCard andIsEdit:_isEdit];
        cell.editHandle = ^(UIButton *btn) {
            _isEdit = btn.selected;
        };
        cell.changeHandle = ^(NSString *realName, NSString *identityCard) {
            _trueName = realName;
            _idCard = identityCard;
        };
        __weak typeof(cell) weakCell = cell;
        cell.saveHandle = ^(NSString *realName, NSString *identityCard, UIButton *btn) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:realName forKey:@"trueName"];
            [params setObject:identityCard forKey:@"idCard"];
            [RequestManager requestWithMethod:POST WithUrlPath:@"user/idCard" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
                NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                if ([resultCode isEqualToString:@"ok"]) {
                    _dataItem.trueName = realName;
                    _dataItem.idCard = identityCard;
                    _trueName = realName;
                    _idCard = identityCard;
                    btn.selected = true;
                    _isEdit = true;
                    weakCell.nameInputTextFiled.userInteractionEnabled = false;
                    weakCell.numInputTextFiled.userInteractionEnabled = false;
                    [MQToast showToast:@"保存成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                }
            } fail:^(NSError *error) {
                //
            }];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if  (indexPath.section == 2){
        if (_dataItem.products.count == 1) {
            static NSString *OrderProductCellID = @"OrderProductCellID";
            OrderProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderProductCellID];
            if (cell == nil) {
                cell = [[OrderProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderProductCellID];
            }
            ShopCarSureProduct *item = _dataItem.products[indexPath.row];
            [cell setUpdataInfoWithShopCarSureProduct:item];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *OrderSureMoreProductCellID = @"OrderSureMoreProductCellID";
            OrderSureMoreProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderSureMoreProductCellID];
            if (cell == nil) {
                cell = [[OrderSureMoreProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderSureMoreProductCellID];
            }
            [cell setUpInfoShopCarSureData:_dataItem];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section == 4){
        static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID";
        OrderSureNextActionCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
        if (cell == nil) {
            cell = [[OrderSureNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
        }
        cell.tipsLable.text = @"优惠券";
        cell.rightSubLable.text = _dataItem.couponCodeResponses.count == 0 ? @"无" : [NSString stringWithFormat:@"%ld张可用",_dataItem.couponCodeResponses.count];
        cell.arrowImgV.image = [UIImage imageNamed:@"common_right_arrow_small"];
        cell.arrowImgV.hidden = _dataItem.couponCodeResponses.count == 0;
        cell.arrowImgV.hidden = false;
        return cell;
    }
    if (indexPath.section == 3){
        static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID";
        OrderSureNextActionCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
        if (cell == nil) {
            cell = [[OrderSureNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
        }
        if (indexPath.row == 0) {
            cell.tipsLable.text = @"支付方式";
            cell.rightSubLable.text = @"在线支付";
            cell.arrowImgV.image = [UIImage imageNamed:@"common_right_arrow_small"];
            cell.arrowImgV.hidden = true;
        }else{
            cell.tipsLable.text = @"发票";
            cell.rightSubLable.text = @"不开发票";
            cell.arrowImgV.image = [UIImage imageNamed:@"common_right_arrow_small"];
            cell.arrowImgV.hidden = false;
            if(_isGlobal){
                cell.rightSubLable.text = @"全球购商品暂不支持发票";
                cell.arrowImgV.hidden = true;
            }
        }
        return cell;
    }
    if (indexPath.section == 5) {
        if (_isGlobal) {
            static NSString *OrderSureGlobalTotalPriceCellID = @"OrderSureGlobalTotalPriceCellID";
            OrderSureGlobalTotalPriceCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderSureGlobalTotalPriceCellID];
            if (cell == nil) {
                cell = [[OrderSureGlobalTotalPriceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderSureGlobalTotalPriceCellID];
            }
            [cell setupInfoWithShopCarSureData:_dataItem];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.taxDexHandle = ^{
                WebPageController *webVc = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@static/global/tax_note.html",WebBaseUrl] NavTitle:@""];
                webVc.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:webVc animated:true];
            };
            cell.readProtocolHandle = ^{
                WebPageController *webVc = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@static/global/buy_note.html",WebBaseUrl] NavTitle:@""];
                webVc.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:webVc animated:true];
            };
            cell.agreeProtocolHandle = ^(UIButton *btn) {
                _dataItem.agreePropocol = btn.selected;
            };
            return cell;
        }
        static NSString *OrderSureTotalPriceCellID = @"OrderSureTotalPriceCellID";
        OrderSureTotalPriceCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderSureTotalPriceCellID];
        if (cell == nil) {
            cell = [[OrderSureTotalPriceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderSureTotalPriceCellID];
        }
        [cell setupInfoWithShopCarSureData:_dataItem];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0){
        AddressViewController *addressVC = [[AddressViewController alloc] init];
        addressVC.isChoice = true;
        addressVC.seletcedHandle = ^(AddressModel *item){
            _address = item;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController pushViewController:addressVC animated:true];
        return;
    }
    if (indexPath.section == 2) {
        if (_dataItem.products.count > 1) {
            OrderSureProductListController *listVc = [[OrderSureProductListController alloc]initWithShopCarSureProductArr:_dataItem.products];
            listVc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:listVc animated:true];
        }
        return;
    }
    if (indexPath.section == 4) {//优惠券
        if (_dataItem.couponCodeResponses.count == 0 ) {
            [MQToast showToast:@"暂无优惠券可用" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return;
        }
        SeletcedCouponController *youhuiquanVC = [[SeletcedCouponController alloc]initWithShopCarSureData:_dataItem];
        youhuiquanVC.hidesBottomBarWhenPushed = true;
        youhuiquanVC.chioceHandle = ^(CGFloat minusPrice,NSMutableArray *couponArr){
            OrderSureNextActionCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
            if (minusPrice == 0.0) {
                cell.rightSubLable.text = [NSString stringWithFormat:@"%ld张可用",_dataItem.couponCodeResponses.count];
            }else{
                cell.rightSubLable.text = [NSString stringWithFormat:@"-￥%.2lf",minusPrice];
            }
            if (_status == OrderSuerStatusByCart) {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                if (couponArr.count > 0) {
                    NSMutableArray *couponIds = [NSMutableArray array];
                    for (CouponInfoData *info in couponArr) {
                        [couponIds addObject:info.couponSelectedResonse.couponCodeId];
                    }
                    [params setObject:couponIds forKey:@"couponIds"];
                }
                [params setObject:_cartIdArr forKey:@"cartIds"];
                [RequestManager requestWithMethod:POST WithUrlPath:@"user/order/confirm" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
                    NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                    if ([resultCode isEqualToString:@"ok"]) {
                        if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *objDic = [responseDic objectForKey:@"object"];
                            ShopCarSureData *data = [ShopCarSureData dataForDictionary:objDic];
                            _dataItem = data;
                            [self setupFootViewShowPrice];
                            OrderSureTotalPriceCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:5]];
                            if (cell) {
                                [cell setupInfoWithShopCarSureData:_dataItem];
                            }
                        }
                    }
                } fail:^(NSError *error) {
                    //
                }];
            }else{//单个商品选择优惠券回调
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                if (couponArr.count > 0) {
                    NSMutableArray *couponIds = [NSMutableArray array];
                    for (CouponInfoData *info in couponArr) {
                        [couponIds addObject:info.couponSelectedResonse.couponCodeId];
                    }
                    [params setObject:couponIds forKey:@"couponIds"];
                }
                [params setObject:_productNumber forKey:@"productNumber"];
                [params setObject:_propertyCollection forKey:@"propertyCollection"];
                [params setObject:_count forKey:@"count"];
                [RequestManager requestWithMethod:POST WithUrlPath:@"user/order/single/confirm" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
                    NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                    if ([resultCode isEqualToString:@"ok"]) {
                        if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *objDic = [responseDic objectForKey:@"object"];
                            ShopCarSureData *data = [ShopCarSureData dataForDictionary:objDic];
                            _dataItem = data;
                            [self setupFootViewShowPrice];
                            OrderSureTotalPriceCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:5]];
                            if (cell) {
                                [cell setupInfoWithShopCarSureData:_dataItem];
                            }
                        }
                    }
                } fail:^(NSError *error) {
                    //
                }];
            }
        };
        [self.navigationController pushViewController:youhuiquanVC animated:true];
        return;
    }
    if (indexPath.section == 3) {//发票
        if (indexPath.row == 0) {
            return;
        }
        if (_isGlobal) {
            [MQToast showToast:@"全球购商品暂不支持发票" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return;
        }
        BillChoiceController *billVC = [[BillChoiceController alloc]initWithBillChoiceStyle:_billStatus];
        billVC.hidesBottomBarWhenPushed = true;
        billVC.invoiceName = _invoiceName;
        billVC.phoneStr = _phoneStr;
        billVC.emailStr = _emailStr;
        billVC.choiceHandle = ^(NSInteger index, NSString *invoiceName ,NSString *phoneStr, NSString *emailStr){
            OrderSureNextActionCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
            if(index == -1){
                _billStatus = BillChoiceStatusWithNoNeed;
                _invoiceName = invoiceName;
                _phoneStr = phoneStr;
                _emailStr = emailStr;
                cell.rightSubLable.text = @"不开发票";
            }
            if (index == 0) {
                _billStatus = BillChoiceStatusWithPaperPersion;
                _invoiceName = invoiceName;
                _phoneStr = phoneStr;
                _emailStr = emailStr;
                cell.rightSubLable.text = @"纸质发票-个人";
            }
            if(index == 1){
                _billStatus = BillChoiceStatusWithPaperCompany;
                cell.rightSubLable.text = [NSString stringWithFormat:@"纸质发票-%@",invoiceName];
                _invoiceName = invoiceName;
                _phoneStr = phoneStr;
                _emailStr = emailStr;
            }
            if (index == 2) {
                _billStatus = BillChoiceStatusWithQualification;
                cell.rightSubLable.text = @"增值税发票";
                _invoiceName = invoiceName;
                _phoneStr = phoneStr;
                _emailStr = emailStr;
            }
            if (index == 3) {//电子个人
                _billStatus = BillChoiceStatusWithElectronicPersion;
                cell.rightSubLable.text = @"电子发票-个人";
                _invoiceName = invoiceName;
                _phoneStr = phoneStr;
                _emailStr = emailStr;
            }
            if (index == 4) {//电子公司
                _billStatus = BillChoiceStatusWithElectronicCompany;
                _invoiceName = invoiceName;
                _phoneStr = phoneStr;
                _emailStr = emailStr;
                cell.rightSubLable.text = [NSString stringWithFormat:@"电子发票-%@",invoiceName];
            }
        };
        [self.navigationController pushViewController:billVC animated:true];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 && !_isGlobal) {
        return 0.1;
    }
    return  FitHeight(20.0);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(14.0))];
    view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return FitHeight(160.0);
    }
    if (indexPath.section == 1) {
        return  _isGlobal ? FitHeight(202) : 0;
    }
    if (indexPath.section == 2){
        if (_dataItem.products.count == 1) {
            return FitHeight(230.0);
        }else{
            return FitHeight(190.0);
        }
    }
    if (indexPath.section == 5) {
        if (_isGlobal) {
            return FitHeight(290.0);
        }
        return FitHeight(160.0);
    }
    return FitHeight(90.0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _footView.hidden = scrollView.contentOffset.y < 25.0;
    if (scrollView.contentOffset.y < 25.0) {
        if (_isGlobal) {
            CGRect tableViewFrame = CGRectMake(0, FitHeight(92.0) + 64, mainScreenWidth, mainScreenHeight - FitHeight(92.0) - 64);
            _tableView.frame = tableViewFrame;
        }else{
            CGRect tableViewFrame = CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - FitHeight(92.0));
            _tableView.frame = tableViewFrame;
        }
    }else{
        if (_isGlobal) {
            CGRect tableViewFrame = CGRectMake(0, FitHeight(92.0) + 64, mainScreenWidth, mainScreenHeight - FitHeight(176.0) - FitHeight(92.0) - 64);
            _tableView.frame = tableViewFrame;
        }else{
            CGRect tableViewFrame = CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - FitHeight(92.0));
            _tableView.frame = tableViewFrame;
        }
    }
}

#pragma mark - sureAction 提交订单按钮点击
- (void)sureAction {
    if (_alertIsShow) {
        return;
    }
    [self checkSellOut];
    return;
}

#pragma mark - checkSellOut 检查库存
-(void)checkSellOut{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_status == OrderSuerStatusByCart) {
        [params setObject:_cartIdArr forKey:@"cartIds"];
    }
    if (_status == OrderSuerStatusBySingleItem) {
        [params setObject:_productNumber forKey:@"productNumber"];
        [params setObject:_propertyCollection forKey:@"propertyCollection"];
        [params setObject:[NSNumber numberWithInteger:_count.integerValue] forKey:@"count"];
    }
    [RequestManager requestWithMethod:POST WithUrlPath:_status == OrderSuerStatusByCart ? @"user/order/checkRepertory" : @"user/order/checkRepertorySingle" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            _sellOutArr = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]   ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if (_status == OrderSuerStatusBySingleItem) {//单个商品直接购买
                    if ([objDic objectForKey:@"product"] && [[objDic objectForKey:@"product"] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *productDic = [objDic objectForKey:@"product"];
                        SellOutProductData *item = [SellOutProductData dataForDictionary:productDic];
                        [_sellOutArr addObject:item];
                    }
                    if (_sellOutArr.count > 0) {
                        [self showOutOfStockView:true];
                    }else{
                        [self createOrder];
                    }
                }
                if (_status == OrderSuerStatusByCart) {//购物车购买
                    if ([objDic objectForKey:@"product"] && [[objDic objectForKey:@"product"] isKindOfClass:[NSArray class]]) {
                        NSArray *productArr = [objDic objectForKey:@"product"];
                        for (NSDictionary *d in productArr) {
                            SellOutProductData *item = [SellOutProductData dataForDictionary:d];
                            [_sellOutArr addObject:item];
                        }
                    }
                    if (_sellOutArr.count > 0) {
                        [self showOutOfStockView:true];
                    }else{
                        [self createOrder];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - createOrder 下单
-(void)createOrder{
    if (_address == nil) {
        [MQToast showToast:@"请先选择收货地址以及联系方式" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    if (_isGlobal) {
        if (_trueName.length == 0 || ![Utils IsIdentityCard:_idCard]) {
            [MQToast showToast:@"请先填写正确的身份证信息" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return;
        }
        if (_dataItem.agreePropocol == false) {
            [MQToast showToast:@"请先同意用户服务协议" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return;
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableArray *couponCodeIdArr = [NSMutableArray array];
    for (CouponInfoData *item in _dataItem.couponCodeResponses) {
        if (item.couponSelectedResonse.selected) {
            [couponCodeIdArr addObject:item.couponSelectedResonse.couponCodeId];
        }
    }
    if (couponCodeIdArr.count > 0) {
        [params setObject:couponCodeIdArr forKey:@"couponCodeId"];
    }
    if (_billStatus == BillChoiceStatusWithPaperPersion) {//个人发票
        [params setObject:[NSNumber numberWithInteger:0] forKey:@"invoiceType"];
    }
    if (_billStatus == BillChoiceStatusWithPaperCompany) {//单位发票
        [params setObject:[NSNumber numberWithInteger:1] forKey:@"invoiceType"];
        [params setObject:_invoiceName forKey:@"invoiceTitle"];
    }
    if (_billStatus == BillChoiceStatusWithQualification) {//增值税
        [params setObject:[NSNumber numberWithInteger:2] forKey:@"invoiceType"];
    }
    if (_billStatus == BillChoiceStatusWithElectronicPersion) {
        [params setObject:[NSNumber numberWithInteger:3] forKey:@"invoiceType"];
        [params setObject:_phoneStr forKey:@"invoicePhone"];
        if (_emailStr.length > 0) {
            [params setObject:_emailStr forKey:@"invoiceEmail"];
        }
    }
    if (_billStatus == BillChoiceStatusWithElectronicCompany) {
        [params setObject:[NSNumber numberWithInteger:4] forKey:@"invoiceType"];
        [params setObject:_phoneStr forKey:@"invoicePhone"];
        if (_invoiceName.length > 0) {
            [params setObject:_invoiceName forKey:@"invoiceTitle"];
        }
        if (_emailStr.length > 0) {
            [params setObject:_emailStr forKey:@"invoiceEmail"];
        }
    }
    [params setObject:_address.name forKey:@"contact"];
    [params setObject:_address.phone forKey:@"phone"];
    [params setObject:_address.province forKey:@"province"];
    [params setObject:_address.city forKey:@"city"];
    [params setObject:_address.area forKey:@"area"];
    [params setObject:_address.addr forKey:@"street"];
    if (_status == OrderSuerStatusByCart) {
        [params setObject:_cartIdArr forKey:@"cartIds"];
    }
    if (_status == OrderSuerStatusBySingleItem) {
        [params setObject:_productNumber forKey:@"productNumber"];
        [params setObject:_propertyCollection forKey:@"propertyCollection"];
        [params setObject:[NSNumber numberWithInteger:_count.integerValue] forKey:@"count"];
    }
    if (_isGlobal) {
        [params setObject:_dataItem.trueName forKey:@"trueName"];
        [params setObject:_dataItem.idCard forKey:@"idCard"];
    }
    [RequestManager requestWithMethod:POST WithUrlPath:_status == OrderSuerStatusByCart ? @"user/order/apply" : @"user/order/single/apply" params:params from:self showHud:true loadingText:nil enableUserActions:true success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]] ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                NSString *orderId = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"orderId"]];
                PayViewController *payVc = [[PayViewController alloc]initWithPayWayStatus:_status == OrderSuerStatusByCart ? PayWayStatusByCart : PayWayStatusBySingleItem orderId:orderId];
                payVc.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:payVc animated:true];
                _sureBtn.userInteractionEnabled = true;
            }
        }
        if ([resultCode isEqualToString:@"over"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]] ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                NSString *orderId = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"orderId"]];
                OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]initWithOrderNum:orderId];
                self.hidesBottomBarWhenPushed = true;
                detailVC.isPopToTop = true;
                [self.navigationController pushViewController:detailVC animated:true];
                _sureBtn.userInteractionEnabled = true;
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - showOutOfStockView
-(void)showOutOfStockView:(BOOL)show{
    if (show) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.markView];
        [self.markView addSubview:self.outOfStockView];
        [self.outOfStockView setupInfoWithSellOutProductDataArr:_sellOutArr];
    }else{
        [self.outOfStockView removeFromSuperview];
        self.outOfStockView = nil;
        [self.markView removeFromSuperview];
        self.markView = nil;
    }
}

-(OrderSureOutOfStockView *)outOfStockView{
    if (_outOfStockView == nil) {
        _outOfStockView = [[OrderSureOutOfStockView alloc]initWithFrame:CGRectMake(0, 0, 300, 168) leftBtnTitle:_status == OrderSuerStatusBySingleItem ? @"返回上一页" : @"返回购物车" leftBtnBlock:^{
            [self showOutOfStockView:false];
            [self.navigationController popViewControllerAnimated:true];
        } rightBtnBlock:^{
            [self showOutOfStockView:false];
            if (_status == OrderSuerStatusBySingleItem) {
                [self.navigationController popViewControllerAnimated:true];
                return ;
            }
            NSMutableArray *oldCartArr = [NSMutableArray arrayWithArray:_cartIdArr];
            for (SellOutProductData *item in _sellOutArr) {
                for (int i = 0 ; i < oldCartArr.count; i++) {
                    NSString *idStr = (NSString *)oldCartArr[i];
                    if ([item.cartId isEqualToString:idStr]) {
                        [oldCartArr removeObject:idStr];
                    }
                }
            }
            _cartIdArr = oldCartArr;
            if (_cartIdArr.count == 0) {
                [self.navigationController popViewControllerAnimated:true];
                return;
            }
            [self configData];
        }];
        _outOfStockView.center = _markView.center;
        return _outOfStockView;
    }
    return _outOfStockView;
}



@end
