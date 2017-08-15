//
//  BillChoiceController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BillChoiceController.h"
#import "RegisterDesignerTipsCell.h"
#import "BillNeedChoiceCell.h"
#import "BillClassChoiceCell.h"
#import "BillNameChoiceCell.h"
#import "BillICompanyNameinputCell.h"
#import "BillPhoneAndEmaillinputCell.h"

typedef enum : NSUInteger {
    BillStutaspaper,
    BillStutasQualification
}BillStutas;

@interface BillChoiceController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) BOOL needBill;
@property(nonatomic,assign) BOOL needBillIsPersoon;
@property(nonatomic,assign) BOOL canChoiceQualification;//是否具有增值税发票资格
@property(nonatomic,assign) BillStutas billStyle;
@property(nonatomic,assign) BillChoiceStyle billStatus;

@end

@implementation BillChoiceController

-(instancetype)initWithBillChoiceStyle:(BillChoiceStyle)billStatus{
    self = [super init];
    if (self) {
        if (billStatus == BillChoiceStatusWithQualification) {
            _canChoiceQualification = true;
        }
        _billStatus = billStatus;
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    self.title = @"发票信息";
    [self configUI];
    [self getqualificationInfo];
}

-(void)getqualificationInfo{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/invoice/qualification" params:nil from:self showHud:true loadingText:nil enableUserActions:true success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"qualification"]) {
                    if ([objDic objectForKey:@"qualification"] != [NSNull null]) {
                        if ([[objDic objectForKey:@"qualification"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *qualificationDic = [objDic objectForKey:@"qualification"];
                            if ([qualificationDic objectForKey:@"status"]) {
                                NSString *str = [NSString stringWithFormat:@"%@",[qualificationDic objectForKey:@"status"]];
                                _canChoiceQualification = str.integerValue == 1;
                            }
                        }
                    }else{
                        _canChoiceQualification = false;
                    }
                }
            }
            [_tableView reloadData];
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void)configUI{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth -FitWith(160.0) , 20, FitWith(160.0), 44)];
    rightBtn.titleLabel.font = CUSFONT(13);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitle:@"发票需知" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightHelpHanlde) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight - FitHeight(140.0)) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBord)];
    [_tableView addGestureRecognizer:tap];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(24.0), mainScreenHeight - FitHeight(90.0) - FitHeight(50), mainScreenWidth - FitWith(48.0), FitHeight(90.0))];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    sureBtn.titleLabel.font = CUSFONT(16);
    [sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}

-(void)hiddenKeyBord{
    [self.view endEditing:false];
}


-(void)rightHelpHanlde{
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@static/invoice/notice.html",WebBaseUrl] NavTitle:@""];
    webVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:webVC animated:true];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_billStatus == BillChoiceStatusWithNoNeed) {
        return 1;
    }else{
        return 3;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_billStatus == BillChoiceStatusWithNoNeed) {
        return 2;
    }else{
        if (section == 0) {//选择是否要发票
            return 2;
        }
        if (section == 1) {//选择发票类型
            return 2;
        }
        if (section == 2) {
            if (_billStatus == BillChoiceStatusWithQualification) {//增值税发票
                return 0;
            }
            if (_billStatus == BillChoiceStatusWithPaperPersion) {//个人纸质发票
                return 2;
            }
            if (_billStatus == BillChoiceStatusWithPaperCompany) {//单位纸质发票
                return 3;
            }
            if (_billStatus == BillChoiceStatusWithElectronicPersion) {//个人电子发票
                return 4;
            }
            if (_billStatus == BillChoiceStatusWithElectronicCompany) {//单位电子发票
                return 4;
            }
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{//
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            static NSString *RegisterDesignerTipsCellID = @"RegisterDesignerTipsCellID";
            RegisterDesignerTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:RegisterDesignerTipsCellID];
            if (cell == nil) {
                cell = [[RegisterDesignerTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterDesignerTipsCellID];
            }
            cell.tipsLable.text = @"发票内容";
            cell.line.hidden = false;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *BillNeedChoiceCellID = @"BillNeedChoiceCellID";
            BillNeedChoiceCell * cell = [_tableView dequeueReusableCellWithIdentifier:BillNeedChoiceCellID];
            if (cell == nil) {
                cell = [[BillNeedChoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BillNeedChoiceCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setUpBtnSeletcedWithBillChoiceStyle:_billStatus];
            __weak typeof(self) weakSelf = self;
            cell.choiceHanlde = ^(UIButton *btn){
                if (btn.tag == 1) {
                    weakSelf.billStatus = BillChoiceStatusWithNoNeed;
                }else{
                    weakSelf.billStatus = BillChoiceStatusWithPaperPersion;
                }
                [weakSelf.tableView reloadData];
            };
            return cell;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *RegisterDesignerTipsCellID = @"RegisterDesignerTipsCellID";
            RegisterDesignerTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:RegisterDesignerTipsCellID];
            if (cell == nil) {
                cell = [[RegisterDesignerTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterDesignerTipsCellID];
            }
            cell.tipsLable.text = @"发票类型";
            cell.line.hidden = true;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{//
            static NSString *BillClassChoiceCellID = @"BillClassChoiceCellID";
            BillClassChoiceCell * cell = [_tableView dequeueReusableCellWithIdentifier:BillClassChoiceCellID];
            if (cell == nil) {
                cell = [[BillClassChoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BillClassChoiceCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.moreBillBtn.hidden = !_canChoiceQualification;
            [cell setUpBtnSeletcedWithBillChoiceStyle:_billStatus];
            __weak typeof(self) weakSelf = self;
            cell.choiceHandle = ^(NSInteger index){//0 纸质发票 1 电子发票 2 增值税发票
                if (index == 0) {
                    weakSelf.billStatus = BillChoiceStatusWithPaperPersion;
                    [weakSelf.tableView reloadData];
                }
                if (index == 1) {
                    weakSelf.billStatus = BillChoiceStatusWithElectronicPersion;
                    [weakSelf.tableView reloadData];
                }
                if (index == 2) {
                    weakSelf.billStatus = BillChoiceStatusWithQualification;
                    [weakSelf.tableView reloadData];
                }
            };
            return cell;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            static NSString *RegisterDesignerTipsCellID = @"RegisterDesignerTipsCellID";
            RegisterDesignerTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:RegisterDesignerTipsCellID];
            if (cell == nil) {
                cell = [[RegisterDesignerTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterDesignerTipsCellID];
            }
            
            cell.tipsLable.text = @"发票抬头";
            cell.line.hidden = true;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *BillNameChoiceCellID = @"BillNameChoiceCellID";
            BillNameChoiceCell * cell = [_tableView dequeueReusableCellWithIdentifier:BillNameChoiceCellID];
            if (cell == nil) {
                cell = [[BillNameChoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BillNameChoiceCellID];
            }
            __weak typeof(self) weakSelf = self;
            [cell setUpBtnSeletcedWithBillChoiceStyle:weakSelf.billStatus];
            cell.nameChoiceHandle = ^(NSInteger index){
                if (weakSelf.billStatus == BillChoiceStatusWithPaperPersion || weakSelf.billStatus == BillChoiceStatusWithPaperCompany) {
                    if (index == 0) {
                        weakSelf.billStatus = BillChoiceStatusWithPaperPersion;
                    }
                    if (index == 1) {
                        weakSelf.billStatus = BillChoiceStatusWithPaperCompany;
                    }
                }
                if (weakSelf.billStatus == BillChoiceStatusWithElectronicCompany || weakSelf.billStatus == BillChoiceStatusWithElectronicPersion) {
                    if (index == 0) {
                        weakSelf.billStatus = BillChoiceStatusWithElectronicPersion;
                    }
                    if (index == 1) {
                        weakSelf.billStatus = BillChoiceStatusWithElectronicCompany;
                    }
                }
                [weakSelf.tableView reloadData];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 2) {//填写公司名称
            if (_billStatus == BillChoiceStatusWithElectronicPersion) {
                return [[UITableViewCell alloc]initWithFrame:CGRectZero];
            }
            static NSString *BillICompanyNameinputCellID = @"BillICompanyNameinputCellID";
            BillICompanyNameinputCell * cell = [_tableView dequeueReusableCellWithIdentifier:BillICompanyNameinputCellID];
            if (cell == nil) {
                cell = [[BillICompanyNameinputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BillICompanyNameinputCellID];
            }
            cell.inputTF.delegate = self;
            cell.inputTF.text = _invoiceName;
            cell.inputTF.tag = 22;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 3) {//填写收票人信息
            static NSString *BillPhoneAndEmaillinputCellID = @"BillPhoneAndEmaillinputCellID";
            BillPhoneAndEmaillinputCell * cell = [_tableView dequeueReusableCellWithIdentifier:BillPhoneAndEmaillinputCellID];
            if (cell == nil) {
                cell = [[BillPhoneAndEmaillinputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BillPhoneAndEmaillinputCellID];
            }
            cell.phoneTF.delegate = self;
            cell.phoneTF.tag = 33;
            cell.phoneTF.text = _phoneStr;
            cell.emailTF.delegate = self;
            cell.emailTF.tag = 44;
            cell.emailTF.text = _emailStr;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return indexPath.row == 0 ? FitHeight(80.0) : FitHeight(190.0);
    }
    if (indexPath.section == 1) {
        return indexPath.row == 0 ? FitHeight(80.0) : FitHeight(96.0);
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return FitHeight(80.0);
        }
        if (indexPath.row == 1) {
            return FitHeight(70.0);
        }
        if (indexPath.row == 2) {
            if (_billStatus == BillChoiceStatusWithElectronicPersion) {
                return 0;
            }
            return FitHeight(97.0);
        }
        if (indexPath.row == 3) {
            return FitHeight(235.0);
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(16.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:false];
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 22) {
        _invoiceName = textField.text;
    }
    if (textField.tag == 33) {
        _phoneStr = textField.text;
    }
    if (textField.tag == 44) {
        _emailStr = textField.text;
    }
}

-(void)sureBtnAction{
    if (self.billStatus == BillChoiceStatusWithNoNeed) {//不要发票
        BillInfoChoiceBlock block = _choiceHandle;
        if (block) {
            block(-1,@"",@"",@"");
        }
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    if (self.billStatus == BillChoiceStatusWithQualification) {//增值税发票
        BillInfoChoiceBlock block = _choiceHandle;
        if (block) {
            block(2,@"",@"",@"");
        }
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    if (self.billStatus == BillChoiceStatusWithPaperPersion) {//个人发票
        BillInfoChoiceBlock block = _choiceHandle;
        if (block) {
            block(0,@"",@"",@"");
        }
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    if (self.billStatus == BillChoiceStatusWithPaperCompany) {//单位发票
        if (_invoiceName.length == 0) {
            [RequestManager showAlertFrom:self title:@"" mesaage:@"请填写公司名称" success:^{
                
            }];
            return;
        }
        BillInfoChoiceBlock block = _choiceHandle;
        if (block) {
            block(1,_invoiceName,@"",@"");
        }
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    if (self.billStatus == BillChoiceStatusWithElectronicPersion) {
        NSString *valiStr = [ValiMobile valiMobile:_phoneStr];
        if (![valiStr isEqualToString:@"YES"]) {
            [RequestManager showAlertFrom:self title:@"" mesaage:valiStr success:^{
                
            }];
            return;
        }
        if (_emailStr.length > 0) {
            if (![Utils IsEmailAdress:_emailStr]) {
                [RequestManager showAlertFrom:self title:@"" mesaage:@"邮箱格式不正确请重新输入" success:^{
                    
                }];
                return;
            }
        }
        BillInfoChoiceBlock block = _choiceHandle;
        if (block) {
            block(3,@"",_phoneStr,_emailStr);
        }
        [self.navigationController popViewControllerAnimated:true];
    }
    if (self.billStatus == BillChoiceStatusWithElectronicCompany) {
        if (_invoiceName.length == 0) {
            [RequestManager showAlertFrom:self title:@"" mesaage:@"请填写公司名称" success:^{
                
            }];
            return;
        }
        NSString *valiStr = [ValiMobile valiMobile:_phoneStr];
        if (![valiStr isEqualToString:@"YES"]) {
            [RequestManager showAlertFrom:self title:@"" mesaage:valiStr success:^{
                
            }];
            return;
        }
        if (_emailStr.length > 0) {
            if (![Utils IsEmailAdress:_emailStr]) {
                [RequestManager showAlertFrom:self title:@"" mesaage:@"邮箱格式不正确请重新输入" success:^{
                    
                }];
                return;
            }
        }
        BillInfoChoiceBlock block = _choiceHandle;
        if (block) {
            block(4,_invoiceName,_phoneStr,_emailStr);
        }
        [self.navigationController popViewControllerAnimated:true];
    }
}

@end
