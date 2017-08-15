//
//  AddAndEditAddressController.m
//  DuoSet
//
//  Created by fanfans on 2017/2/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AddAndEditAddressController.h"
#import "AccountInputCell.h"
#import "AddressChoiceCell.h"
#import "AddressProvinceData.h"
#import "AddressInputDetailCell.h"

@interface AddAndEditAddressController ()<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property(nonatomic,assign) AddressEditStatus status;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titleArr;

@property(nonatomic,strong) UIView *pickeBgView;
@property(nonatomic,strong) UIPickerView *picker;
@property(nonatomic,assign) NSInteger provinceIndex;
@property(nonatomic,assign) NSInteger cityIndex;
@property(nonatomic,assign) NSInteger countyIndex;
@property(nonatomic,strong) NSMutableArray *provinceArr;
@property(nonatomic,assign) BOOL pickIsModify;

@end

@implementation AddAndEditAddressController

-(instancetype)initWithAddressEditStatus:(AddressEditStatus)status{
    self = [super init];
    if (self) {
        _status = status;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    self.title = _status == AddressAdd ? @"新增收货地址" : @"修改收货地址";
    _titleArr = @[@"收货人:",@"手机号码:",@"所在区域:",@"详细地址:"];
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), mainScreenHeight - FitHeight(250.0), mainScreenWidth - FitWith(40.0), FitHeight(90.0))];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    sureBtn.titleLabel.font = CUSFONT(15);
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view bringSubviewToFront:sureBtn];
    
    self.view.userInteractionEnabled = true;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapClosekeyBoard)];
    [self.view addGestureRecognizer:g];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *AccountInputCellID = @"AccountInputCellID";
        AccountInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:AccountInputCellID];
        if (cell == nil) {
            cell = [[AccountInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccountInputCellID];
        }
        cell.tipsLable.text = _titleArr[indexPath.row];
        if (indexPath.row == 1) {
            cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        }
        cell.inputTF.returnKeyType = UIReturnKeyDone;
        cell.inputTF.delegate = self;
        cell.inputTF.placeholder = indexPath.row == 1 ? @"请输入收货人手机号码" : @"请输入收货人姓名";
        if (_status == AddressEdit) {
            cell.inputTF.text = indexPath.row == 1 ? _addressItem.phone : _addressItem.name;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 2) {
        static NSString *AddressChoiceCellID = @"AddressChoiceCellID";
        AddressChoiceCell * cell = [_tableView dequeueReusableCellWithIdentifier:AddressChoiceCellID];
        if (cell == nil) {
            cell = [[AddressChoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressChoiceCellID];
        }
        cell.tipsLable.text = _titleArr[indexPath.row];
        cell.rightSubLable.placeholder = @"请选择所在区域";
        if (_status == AddressEdit) {
            cell.rightSubLable.text = [NSString stringWithFormat:@"%@ %@ %@",_addressItem.province,_addressItem.city,_addressItem.area];
        }
        cell.cellTapHandle = ^(){
            [self configAreaDataAndConfigView];
        };
        return cell;
    }
    if (indexPath.row == 3) {
        static NSString *AddressInputDetailCellID = @"AddressInputDetailCellID";
        AddressInputDetailCell * cell = [_tableView dequeueReusableCellWithIdentifier:AddressInputDetailCellID];
        if (cell == nil) {
            cell = [[AddressInputDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressInputDetailCellID];
        }
        cell.tipsLable.text = _titleArr[indexPath.row];
        cell.inputTF.returnKeyType = UIReturnKeyDone;
        cell.inputTF.delegate = self;
        if (_status == AddressEdit) {
            cell.inputTF.text = _addressItem.addr;
        }
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(106);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(30.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:true];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:true];
    return true;
}

#pragma mark - config pickView
-(void)configPickerChoiceView{
    if (_pickeBgView != nil) {
        _pickeBgView.hidden = false;
        return;
    }
    _pickeBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    _pickeBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.view.userInteractionEnabled = true;
    _pickeBgView.userInteractionEnabled = true;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickBgViewTouch)];
    [_pickeBgView addGestureRecognizer:tapGes];
    [self.view addSubview:_pickeBgView];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - FitHeight(520), mainScreenWidth, FitHeight(520.0))];
    bgView.backgroundColor = [UIColor whiteColor];
    [_pickeBgView addSubview:bgView];
    
    UIButton *pcikeLeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, FitHeight(80.0), FitHeight(80.0))];
    [pcikeLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
    pcikeLeftBtn.titleLabel.font = CUSFONT(13);
    pcikeLeftBtn.contentMode = UIViewContentModeCenter;
    [pcikeLeftBtn setTitleColor:[UIColor colorFromHex:0x007aff] forState:UIControlStateNormal];
    [pcikeLeftBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:pcikeLeftBtn];
    
    UIButton *pcikeRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(80.0) - 10, 0, FitHeight(80.0), FitHeight(80.0))];
    [pcikeRightBtn setTitle:@"确定" forState:UIControlStateNormal];
    pcikeRightBtn.contentMode = UIViewContentModeCenter;
    pcikeRightBtn.titleLabel.font = CUSFONT(13);
    [pcikeRightBtn setTitleColor:[UIColor colorFromHex:0x007aff] forState:UIControlStateNormal];
    [pcikeRightBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:pcikeRightBtn];
    
    _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, FitWith(80.0), mainScreenWidth, 216)];
    _picker.delegate = self;
    _picker.dataSource = self;
    _provinceIndex = 0;
    _cityIndex = 0;
    _countyIndex = 0;
    [bgView addSubview:_picker];
}

#pragma mark - pickerViewDataSource & delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _provinceArr.count;
    }else if (component == 1) {
        AddressProvinceData *pro = _provinceArr[_provinceIndex];
        return pro.cities.count;
    }else{
        AddressProvinceData *pro = _provinceArr[_provinceIndex];
        AddressCity *citys = pro.cities[_cityIndex];
        return citys.counties.count;
    }
    return 0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        AddressProvinceData *pro = _provinceArr[row];
        return pro.provinceName;
    }else if (component == 1){
        AddressProvinceData *pro = _provinceArr[_provinceIndex];
        AddressCity *citys = pro.cities[row];
        return citys.cityName;
    }else{
        AddressProvinceData *pro = _provinceArr[_provinceIndex];
        AddressCity *city = pro.cities[_cityIndex];
        AddressCounty *county = city.counties[row];
        return county.countyName;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _provinceIndex = row;
        _cityIndex = 0;
        _countyIndex = 0;
        [_picker reloadComponent:1];
        [_picker reloadComponent:2];
        [_picker selectRow:0 inComponent:1 animated:true];
        [_picker selectRow:0 inComponent:2 animated:true];
    }
    if (component == 1) {
        _cityIndex = row;
        _countyIndex = 0;
        [_picker reloadComponent:2];
        [_picker selectRow:0 inComponent:2 animated:true];
    }
    if (component == 2) {
        _countyIndex = row;
    }
}

-(void)done{
    _pickIsModify = true;
    [self pickBgViewTouch];
    AddressProvinceData *pro = _provinceArr[_provinceIndex];
    AddressCity *citys = pro.cities[_cityIndex];
    AddressCounty *county = citys.counties[_countyIndex];
    AddressChoiceCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.rightSubLable.text = [NSString stringWithFormat:@"%@ %@ %@",pro.provinceName,citys.cityName,county.countyName];
}

-(void)cancel{
    [self pickBgViewTouch];
}

-(void)pickBgViewTouch{
    _pickeBgView.hidden = true;
}

#pragma mark - buttonActions
-(void)configAreaDataAndConfigView{
    [self.view endEditing:true];
    if (_provinceArr == nil) {
        _provinceArr = [NSMutableArray array];
        NSError*error;
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"cities"ofType:@"json"];
        NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
        if ([jsonObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in jsonObject) {
                AddressProvinceData *item = [AddressProvinceData dataForDictionary:dic];
                [_provinceArr addObject:item];
            }
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self configPickerChoiceView];
    });
}


-(void)viewTapClosekeyBoard{
    [self.view endEditing:true];
}

-(void)sureBtnAction{
    AccountInputCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell0.inputTF.text.length == 0) {
        [self.view makeToast:@"收货人不能为空"];
        return;
    }
    AccountInputCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *valiStr = [ValiMobile valiMobile:cell1.inputTF.text];
    if (![valiStr isEqualToString:@"YES"]) {
        [self.view makeToast:valiStr];
        return;
    }
    AddressChoiceCell * cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if ([cell2.rightSubLable.text isEqualToString:@"请选择所在区域"]) {
        [self.view makeToast:@"请先选择省市地区"];
        return;
    }
    AddressInputDetailCell * cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell3.inputTF.text.length == 0) {
        [self.view makeToast:@"请填写详细地址"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_status == AddressEdit) {
        [params setObject:_addressItem.address_id forKey:@"id"];
    }
    [params setObject:cell0.inputTF.text forKey:@"name"];
    [params setObject:_status == AddressEdit ? _addressItem.def : @"0" forKey:@"def"];
    [params setObject:cell1.inputTF.text forKey:@"phone"];
    if ((_status == AddressEdit && _pickIsModify) || _status == AddressAdd ) {//新增 或者 修改并且修改过picker
        AddressProvinceData *pro = _provinceArr[_provinceIndex];
        [params setObject:pro.provinceName forKey:@"province"];
        AddressCity *citys = pro.cities[_cityIndex];
        [params setObject:citys.cityName forKey:@"city"];
        AddressCounty *county = citys.counties[_countyIndex];
        [params setObject:county.countyName forKey:@"area"];
    }else{
        [params setObject:_addressItem.province forKey:@"province"];
        [params setObject:_addressItem.city forKey:@"city"];
        [params setObject:_addressItem.area forKey:@"area"];
    }
    [params setObject:cell3.inputTF.text forKey:@"addr"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/address" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [[UIApplication sharedApplication].keyWindow makeToast:_status == AddressEdit ? @"修改成功" :@"添加成功"];
            AddressChangeBlock block = _changeHandle;
            if (block) {
                block();
            }
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        //
    }];
}

@end
