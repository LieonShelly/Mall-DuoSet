//
//  OrderRefundController.m
//  DuoSet
//
//  Created by fanfans on 2017/6/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderRefundController.h"
#import "RefundTipsCell.h"
#import "RefundInputCell.h"
#import "CancelResionData.h"
#import "OrderCancelResionView.h"

@interface OrderRefundController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *tipArr;
@property(nonatomic,strong) NSArray *placehoderArr;
@property(nonatomic,strong) NSMutableArray *refundResionArr;
@property(nonatomic,strong) OrderCancelResionView *resionView;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) UIButton *commitBtn;
@property(nonatomic,strong) DuojiOrderData *order;
@property(nonatomic,strong) NSString *personName;
@property(nonatomic,strong) NSString *persionPhone;
@property(nonatomic,strong) NSString *resionStr;

@end

@implementation OrderRefundController

-(instancetype)initWithDuojiOrderData:(DuojiOrderData *)order{
    self = [super init];
    if (self) {
        _order = order;
        _resionStr = @"";
        _personName = order.contact;
        _persionPhone = order.phone;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
    manager.shouldResignOnTouchOutside = true;
    manager.shouldToolbarUsesTextFieldTintColor = true;
    manager.enableAutoToolbar = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
    manager.shouldResignOnTouchOutside = false;
    manager.shouldToolbarUsesTextFieldTintColor = true;
    manager.enableAutoToolbar = true;
    manager.shouldShowTextFieldPlaceholder = false;
    manager.enableAutoToolbar = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请退款";
    _tipArr = @[@"退款原因:",@"退款联系人:",@"联系方式:"];
    _placehoderArr = @[@"请选择退款原因",@"请输入退款联系人",@"请输入联系方式"];
    [self confgUI];
    [self configDataSuccess:^{
        //
    }];
}

-(void)configDataSuccess:(void (^)())success{
    NSString *urlStr = @"services/reason?type=2";
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            _refundResionArr = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objArr) {
                    CancelResionData *item = [CancelResionData dataForDictionary:d];
                    [_refundResionArr addObject:item];
                }
                success();
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)confgUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xffffff];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xffffff];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 200)];
    footView.backgroundColor = [UIColor whiteColor];
    
    _commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 80, mainScreenWidth - 20, 45)];
    [_commitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [_commitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateDisabled];
    [_commitBtn setTitle:@"申请退款" forState:UIControlStateNormal];
    [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _commitBtn.enabled = false;
    [footView addSubview:_commitBtn];
    _tableView.tableFooterView = footView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *RefundTipsCellID = @"RefundTipsCellID";
        RefundTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:RefundTipsCellID];
        if (cell == nil) {
            cell = [[RefundTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RefundTipsCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *RefundInputCellID = @"RefundInputCellID";
        RefundInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:RefundInputCellID];
        if (cell == nil) {
            cell = [[RefundInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RefundInputCellID];
        }
        cell.tipsLable.text = _tipArr[indexPath.row];
        cell.inputTF.placeholder = _placehoderArr[indexPath.row];
        cell.inputTF.userInteractionEnabled = indexPath.row != 0;
        cell.inputTF.keyboardType = indexPath.row == 1 ? UIKeyboardTypeDefault : UIKeyboardTypeNumberPad;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.inputTF.delegate = self;
        if (indexPath.row == 1) {
            cell.inputTF.text = _personName;
        }
        if (indexPath.row == 2) {
            cell.inputTF.text = _persionPhone;
        }
        if (indexPath.row == 0) {
            cell.inputTF.text = _resionStr;
        }
        cell.inputTF.tag = indexPath.row;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0  ? 100 : 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self getResion];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        _personName = textField.text;
    }
    if (textField.tag == 2) {
        _persionPhone = textField.text;
    }
}

-(void)getResion{
    if (_refundResionArr.count == 0) {
        [self configDataSuccess:^{
            [self showTipsView];
        }];
        return;
    }
    [self showTipsView];
}

-(void)showTipsView{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.markView];
    if (_resionView == nil){
        _resionView = [[OrderCancelResionView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(542.0))];
        [window addSubview:_resionView];
    }
    _resionView.titleLable.text = @"申请退款";
    _resionView.tipsLable.text = @"申请退款后，本单所享用的优惠可能会一并取消，是否继续？";
    _resionView.resiontipsLable.text = @"请选择申请退款的原因（必选）：";
    [_resionView setupInfoWithCancelResionDataArr:_refundResionArr];
    __weak typeof(self) weakSelf = self;
    _resionView.closeHandle = ^{
        [weakSelf hiddenMarkView];
    };
    _resionView.agreeHandle = ^(NSString *resion){
        [weakSelf hiddenMarkView];
        [weakSelf agreeTipsCommitDataWithResion:resion];
    };
    CGRect frame = _resionView.frame;
    frame.origin.y = mainScreenHeight - FitHeight(542.0);
    [UIView animateWithDuration:0.25 animations:^{
        _resionView.frame = frame;
    }];
}

-(UIView *)markView{
    if (_markView) {
        return _markView;
    }
    _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:_markView];
    _markView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenMarkView)];
    [_markView addGestureRecognizer:tap];
    return _markView;
}

-(void)hiddenMarkView{
    CGRect frame = _resionView.frame;
    frame.origin.y = mainScreenHeight;
    [UIView animateWithDuration:0.25 animations:^{
        _resionView.frame = frame;
        [_markView removeFromSuperview];
        _markView = nil;
        [_resionView removeFromSuperview];
        _resionView = nil;
    }];
}

//选择了原因后的回调
-(void)agreeTipsCommitDataWithResion:(NSString *)resion{
    _commitBtn.enabled = true;
    _resionStr = resion;
    RefundInputCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.inputTF.text = resion;
}

-(void)commitBtnAction{
    [self.view endEditing:true];
    if (_resionStr.length == 0) {
        [MQToast showToast:@"请先选择退款原因" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"/user/order/%@/refund",_order.no];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_resionStr forKey:@"reason"];
    if (_personName.length > 0) {
        [params setObject:_personName forKey:@"contact"];
    }
    if (_persionPhone.length > 0) {
        [params setObject:_persionPhone forKey:@"phone"];
    }
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            RefundSucceedBlock block = _refundHandle;
            if (block) {
                block();
            }
            UserInfo *info = [Utils getUserInfo];
            NSString *urlStr = [NSString stringWithFormat:@"%@user/order/%@/trace-return?userId=%@",BaseUrl,_order.no,info.userId];
            WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
            webVC.hidesBottomBarWhenPushed = YES;
            webVC.isFromRefund = true;
            [self.navigationController pushViewController:webVC animated:true];
        }
    } fail:^(NSError *error) {
        //
    }];
}

@end
