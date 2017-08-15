//
//  NewReturnAndChangeController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "NewReturnAndChangeController.h"
#import "ScanPictureViewController.h"
#import "SGImagePickerController.h"
#import "AddressViewController.h"

#import "NewReturnAndChangeData.h"
#import "ReturnAndChangeNewProductCell.h"
#import "ReturnAndChangeChoiceTypeCell.h"
#import "ReturnAndChangeChoiceCountCell.h"
#import "ReturnAndChangeResionChoiceCell.h"
#import "ReturnAndChangeDesInputCell.h"
#import "ReturnAndChangeChoicePicCell.h"
#import "ReturnAndChangeRefundCell.h"
#import "ReturnAndChangeReturnTypeCell.h"
#import "ReturnAndChangeUserInfoCell.h"
#import "ReturnAndChangeAddressCell.h"
#import "ReturnAndChangeCommitCell.h"

#import "ReturnAndChangeTipsView.h"


@interface NewReturnAndChangeController ()<UITableViewDataSource, UITableViewDelegate,extendPictureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate,UITextViewDelegate>

@property(nonatomic,copy)   NSString *detailId;
@property(nonatomic,strong) NewReturnAndChangeData *itemData;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *thumbnailsArray;
@property(nonatomic,strong) NSMutableArray *sourceArray;
@property(nonatomic,assign) CGFloat width;
//data
@property(nonatomic,strong) AddressModel *address;
@property(nonatomic,assign) NSInteger seletcedIndex;
@property(nonatomic,assign) NSInteger currentCount;
@property(nonatomic,copy)   NSString *desStr;
//选择原因
@property(nonatomic,strong) UIView *pickeBgView;
@property(nonatomic,strong) UIPickerView *picker;
@property(nonatomic,assign) NSInteger pickerIndex;
@property(nonatomic,strong) NSMutableArray *returnResonArr;
@property(nonatomic,strong) NSMutableArray *ExchangeResonArr;
@property(nonatomic,copy)   NSString *resion;
//tips
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) ReturnAndChangeTipsView *tipsView;

@end

@implementation NewReturnAndChangeController

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

-(instancetype)initWithOrderDetailId:(NSString *)detailId{
    self = [super init];
    if (self) {
        _detailId = detailId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"申请售后";
    _seletcedIndex = -1;
    _currentCount = 1;
    _thumbnailsArray = [NSMutableArray array];
    _sourceArray = [NSMutableArray array];
    [self configUI];
    [self configData];
    
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"user/order/%@/detailChange",_detailId] params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                _itemData = [NewReturnAndChangeData dataForDictionary:objDic];
                _address = _itemData.address;
                [_tableView reloadData];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewTapHiddenKeyBord)];
//    [self.view addGestureRecognizer:tap];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_itemData == nil) {
        return 0;
    }
    return 11;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 6) {
        if (_seletcedIndex == 1) {
            return 0;
        }
        return 1;
    }
    if (section == 9) {
        if (_seletcedIndex == 0) {
            return 0;
        }
        return 1;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//商品展示
        static NSString *ReturnAndChangeNewProductCellID = @"ReturnAndChangeNewProductCellID";
        ReturnAndChangeNewProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeNewProductCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeNewProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeNewProductCellID];
        }
        if (_itemData) {
            [cell setupInfoWithNewReturnAndChangeData:_itemData];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {//选择类型
        static NSString *ReturnAndChangeChoiceTypeCellID = @"ReturnAndChangeChoiceTypeCellID";
        ReturnAndChangeChoiceTypeCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeChoiceTypeCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeChoiceTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeChoiceTypeCellID];
        }
        cell.btnHandle = ^(NSInteger index) {
            _seletcedIndex = index;
            [tableView reloadData];
        };
        [cell setupBtnSeletcedWithIndex:_seletcedIndex];
        if (_itemData) {
            [cell setupInfoWithNewReturnAndChangeData:_itemData];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString *ReturnAndChangeChoiceCountCellID = @"ReturnAndChangeChoiceCountCellID";
        ReturnAndChangeChoiceCountCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeChoiceCountCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeChoiceCountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeChoiceCountCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_itemData) {
            cell.numBtn.maxValue = _itemData.count.integerValue;
        }
        cell.numBtn.currentNumber = _currentCount;
        cell.btnActionHandle = ^(NSInteger num) {
            _currentCount = num;
        };
        return cell;
    }
    if (indexPath.section == 3) {
        static NSString *ReturnAndChangeResionChoiceCellID = @"ReturnAndChangeResionChoiceCellID";
        ReturnAndChangeResionChoiceCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeResionChoiceCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeResionChoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeResionChoiceCellID];
        }
        if (_resion.length > 0) {
            cell.subLable.text = _resion;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 4) {
        static NSString *ReturnAndChangeDesInputCellID = @"ReturnAndChangeDesInputCellID";
        ReturnAndChangeDesInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeDesInputCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeDesInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeDesInputCellID];
        }
        if (_desStr.length > 0) {
            cell.inputView.text = _desStr;
        }
        cell.rightTipsLable.hidden = _seletcedIndex != 1;
        cell.inputView.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 5) {
        static NSString *ReturnAndChangeChoicePicCellID = @"ReturnAndChangeChoicePicCellID";
        ReturnAndChangeChoicePicCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeChoicePicCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeChoicePicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeChoicePicCellID];
        }
        [cell.picView diplayPicture:_thumbnailsArray];
        cell.picView.delegate = self;
        __weak typeof(self) weakSelf = self;
        cell.picView.handleBlock = ^(){
            [weakSelf selectPicture];
            [weakSelf.view endEditing:true];
        };
        cell.picView.deleteBlock = ^(NSInteger tag){
            [weakSelf.thumbnailsArray removeObjectAtIndex:tag];
            [weakSelf.sourceArray removeObjectAtIndex:tag];
            //        [weakSelf updateBtnColor];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        };
        [cell updateFrameAndPicWithThumbnailsArray:_thumbnailsArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 6) {//退款说明
        static NSString *ReturnAndChangeRefundCellID = @"ReturnAndChangeRefundCellID";
        ReturnAndChangeRefundCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeRefundCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeRefundCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeRefundCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 7) {
        static NSString *ReturnAndChangeReturnTypeCellID = @"ReturnAndChangeReturnTypeCellID";
        ReturnAndChangeReturnTypeCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeReturnTypeCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeReturnTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeReturnTypeCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 8) {
        static NSString *ReturnAndChangeUserInfoCellID = @"ReturnAndChangeUserInfoCellID";
        ReturnAndChangeUserInfoCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeUserInfoCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeUserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeUserInfoCellID];
        }
        if (_itemData) {
            cell.nameLable.text = [NSString stringWithFormat:@"联系人:%@",_itemData.nickName];
            if (_itemData.phone.length == 11) {
                NSString *numberString = [_itemData.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                cell.phoneLable.text = [NSString stringWithFormat:@"联系电话:%@",numberString];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 9) {
        static NSString *ReturnAndChangeAddressCellID = @"ReturnAndChangeAddressCellID";
        ReturnAndChangeAddressCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeAddressCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeAddressCellID];
        }
        if (_address) {
            [cell setupInfoWithAddressModel:_address];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 10) {
        static NSString *ReturnAndChangeCommitCellID = @"ReturnAndChangeCommitCellID";
        ReturnAndChangeCommitCell * cell = [_tableView dequeueReusableCellWithIdentifier:ReturnAndChangeCommitCellID];
        if (cell == nil) {
            cell = [[ReturnAndChangeCommitCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReturnAndChangeCommitCellID];
        }
        cell.commitHandle = ^{
            [self commitData];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return FitHeight(160.0);
    }
    if (indexPath.section == 1) {
        return FitHeight(180.0);
    }
    if (indexPath.section == 2) {
        return FitHeight(180.0);
    }
    if (indexPath.section == 3) {
        return FitHeight(90.0);
    }
    if (indexPath.section == 4) {
        return FitHeight(338.0);
    }
    if (indexPath.section == 5) {
        CGFloat height;
        _width = (mainScreenWidth - FitWith(60) - FitWith(30))/3;
        if (_thumbnailsArray.count >= 3 && _thumbnailsArray.count < 6) {
            height = _width*2 + FitWith(10);
        }else if (_thumbnailsArray.count >= 6){
            height = _width*3 + FitWith(20);
        }else{
            height = _width;
        }
        return height + 80;
    }
    if (indexPath.section == 6) {
        return FitHeight(170.0);
    }
    if (indexPath.section == 7) {
        return FitHeight(268.0);
    }
    if (indexPath.section == 8) {
        return FitHeight(140.0);
    }
    if (indexPath.section == 9) {
        return FitHeight(230.0);
    }
    if (indexPath.section == 10) {
        return FitHeight(200.0);
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {//选择原因
        if (_seletcedIndex < 0) {
            [self.view makeToast:@"请选择服务类型"];
            return;
        }
        if (_seletcedIndex == 0) {
            if (_returnResonArr.count == 0) {
                [self getReson];
            }else{
                [self configPickerChoiceView];
            }
        }
        if (_seletcedIndex == 1) {
            if (_ExchangeResonArr.count == 0) {
                [self getReson];
            }else{
                [self configPickerChoiceView];
            }
        }
    }
    if (indexPath.section == 9) {
        AddressViewController *addressVc = [[AddressViewController alloc]init];
        addressVc.hidesBottomBarWhenPushed = true;
        addressVc.isChoice = true;
        addressVc.seletcedHandle = ^(AddressModel *address) {
            _address = address;
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        };
        [self.navigationController pushViewController:addressVc animated:true];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)scrollViewTapHiddenKeyBord{
    [self.view endEditing:true];
}

#pragma mark - 选择图片
- (void)selectPicture{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectMorePicture];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        [_thumbnailsArray addObject:image];
        [_sourceArray addObject:image];
        //        [self updateBtnColor];
//        [self updateFrameAndPic];
        
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:5]] withRowAnimation:UITableViewRowAnimationFade];
    }];
}

#pragma mark - 更新图片尺寸

#pragma mark - 选择图片
- (void)selectMorePicture{
    SGImagePickerController *imageCon = [[SGImagePickerController alloc]init];
    imageCon.maxCount = 9 - _thumbnailsArray.count;
    //返回选择的缩略图
    [imageCon setDidFinishSelectThumbnails:^(NSArray *thumbnails) {
        for (UIImage *image in thumbnails) {
            [_thumbnailsArray addObject:image];
        }
        //        [self updateBtnColor];
//        [self updateFrameAndPic];
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:5]] withRowAnimation:UITableViewRowAnimationFade];
        
    }];
    //返回选中的原图
    [imageCon setDidFinishSelectImages:^(NSArray *images) {
        for (UIImage *image in images) {
            [_sourceArray addObject:image];
        }
    }];
    [self presentViewController:imageCon animated:YES completion:^{
        
    }];
}

#pragma mark - extendPictureDelegate 选中图片放大
- (void)extendPictureWithTag:(NSInteger)tag{
    ScanPictureViewController *picture = [[ScanPictureViewController alloc]initWithPhotosUrl:nil WithCurrentIndex:tag];
    picture.photos = _sourceArray;
    [self presentViewController:picture animated:YES completion:^{
        
    }];
}

#pragma mark - UItextViewDelegate
-(void)textViewDidEndEditing:(UITextView *)textView{
    _desStr = textView.text;
}

#pragma mark - 选择原因
-(void)getReson{
    NSString *urlStr = [NSString stringWithFormat:@"services/reason?type=%ld",(long)_seletcedIndex];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (_seletcedIndex == 0) {
                _returnResonArr = [NSMutableArray array];
            }
            if (_seletcedIndex == 1) {
                _ExchangeResonArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objArr) {
                    if ([d objectForKey:@"text"]) {
                        if (_seletcedIndex == 0) {
                            [_returnResonArr addObject:[NSString stringWithFormat:@"%@",[d objectForKey:@"text"]]];
                        }
                        if (_seletcedIndex == 1) {
                            [_ExchangeResonArr addObject:[NSString stringWithFormat:@"%@",[d objectForKey:@"text"]]];
                        }
                    }
                }
                [self configPickerChoiceView];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configPickerChoiceView{
    if (_pickeBgView != nil) {
        [_picker reloadAllComponents];
        [_picker selectRow:0 inComponent:0 animated:true];
        _pickerIndex = 0;
        _pickeBgView.hidden = false;
        return;
    }
    _pickeBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    _pickeBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.view.userInteractionEnabled = true;
    _pickeBgView.userInteractionEnabled = true;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickBgViewTouch)];
    [_pickeBgView addGestureRecognizer:tapGes];
    [[UIApplication sharedApplication].keyWindow addSubview:_pickeBgView];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - FitHeight(520), mainScreenWidth, FitHeight(520.0))];
    bgView.backgroundColor = [UIColor colorFromHex:0xd1d5db];
    [_pickeBgView addSubview:bgView];
    
    UIView *titlebgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(80.0))];
    titlebgView.backgroundColor = [UIColor colorFromHex:0xf0f1f2];
    [bgView addSubview:titlebgView];
    
    UILabel *tipLable = [[UILabel alloc]initWithFrame:CGRectMake(10 + FitHeight(80.0), 0, mainScreenWidth - 20 - FitHeight(160.0), FitHeight(80.0))];
    tipLable.backgroundColor = [UIColor colorFromHex:0xf0f1f2];
    tipLable.text = @"请选择退换货原因";
    tipLable.font = CUSFONT(15);
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.textColor = [UIColor colorFromHex:0x222222];
    [titlebgView addSubview:tipLable];
    
    UIButton *pcikeLeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, FitHeight(80.0), FitHeight(80.0))];
    [pcikeLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
    pcikeLeftBtn.titleLabel.font = CUSFONT(13);
    pcikeLeftBtn.contentMode = UIViewContentModeCenter;
    [pcikeLeftBtn setTitleColor:[UIColor colorFromHex:0x007aff] forState:UIControlStateNormal];
    [pcikeLeftBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [titlebgView addSubview:pcikeLeftBtn];
    
    UIButton *pcikeRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(80.0) - 10, 0, FitHeight(80.0), FitHeight(80.0))];
    [pcikeRightBtn setTitle:@"确定" forState:UIControlStateNormal];
    pcikeRightBtn.contentMode = UIViewContentModeCenter;
    pcikeRightBtn.titleLabel.font = CUSFONT(13);
    [pcikeRightBtn setTitleColor:[UIColor colorFromHex:0x007aff] forState:UIControlStateNormal];
    [pcikeRightBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [titlebgView addSubview:pcikeRightBtn];
    
    _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, FitWith(80.0), mainScreenWidth, 216)];
    _picker.delegate = self;
    _picker.dataSource = self;
    [bgView addSubview:_picker];
}

#pragma mark - pickerViewDataSource & delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_seletcedIndex == 0) {
        return _returnResonArr.count;
    }
    if (_seletcedIndex == 1) {
        return _ExchangeResonArr.count;
    }
    return 0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_seletcedIndex == 0) {
        return _returnResonArr[row];
    }
    if (_seletcedIndex == 1) {
        return _ExchangeResonArr[row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _pickerIndex = row;
}

-(void)done{
    _resion = _seletcedIndex == 0 ? _returnResonArr[_pickerIndex] : _ExchangeResonArr[_pickerIndex];
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationFade];
    [self pickBgViewTouch];
}

-(void)cancel{
    [self pickBgViewTouch];
}

-(void)pickBgViewTouch{
    _pickeBgView.hidden = true;
}


-(void)showTipsView{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.markView];
    if (_tipsView == nil){
        _tipsView = [[ReturnAndChangeTipsView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(730.0))];
        [_tipsView setupInfoWithArticles:_itemData.articles AndArticlesCellHight:_itemData.articleCellHightArr];
        [window addSubview:_tipsView];
    }
    __weak typeof(self) weakSelf = self;
    _tipsView.closeHandle = ^{
        [weakSelf hiddenMarkView];
    };
    _tipsView.agreeHandle = ^{
        [weakSelf hiddenMarkView];
        [weakSelf agreeTipsCommitData];
    };
    CGRect frame = _tipsView.frame;
    frame.origin.y = mainScreenHeight - FitHeight(730.0);
    [UIView animateWithDuration:0.25 animations:^{
        _tipsView.frame = frame;
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
    CGRect frame = _tipsView.frame;
    frame.origin.y = mainScreenHeight;
    [UIView animateWithDuration:0.25 animations:^{
        _tipsView.frame = frame;
        [_markView removeFromSuperview];
        _markView = nil;
        [_tipsView removeFromSuperview];
        _tipsView = nil;
    }];
}

-(void)agreeTipsCommitData{
    NSString *urlStr = @"";
    if (_seletcedIndex == 0) {
        urlStr = [NSString stringWithFormat:@"user/order/%@/%@/return",_itemData.no,_detailId];
    }
    if (_seletcedIndex == 1) {
        urlStr = [NSString stringWithFormat:@"user/order/%@/%@/change",_itemData.no,_detailId];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_desStr forKey:@"message"];
    [params setObject:_resion forKey:@"reason"];
    [params setObject:[NSNumber numberWithInteger:_currentCount] forKey:@"count"];
    [params setObject:_itemData.nickName forKey:@"contact"];
    [params setObject:_itemData.phone forKey:@"phone"];
    if (_seletcedIndex == 1) {
        [params setObject:_address.name forKey:@"changeContact"];
        [params setObject:_address.phone forKey:@"changePhone"];
        [params setObject:_address.province forKey:@"changeProvince"];
        [params setObject:_address.city forKey:@"changeCity"];
        [params setObject:_address.area forKey:@"changeArea"];
        [params setObject:_address.addr forKey:@"changeStreet"];
    }
    if (_sourceArray.count == 0) {//无图片
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [MQToast showToast:@"提交成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                ReturnOrChangedSucceedBlock block = _succeedHandle;
                if (block) {
                    block(_itemData.no);
                }
                UserInfo *info = [Utils getUserInfo];
                NSString *urlStr = [NSString stringWithFormat:@"%@user/order/%@/%@/trace-change?userId=%@",BaseUrl,_itemData.no,_detailId,info.userId];
                WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
                webVC.hidesBottomBarWhenPushed = true;
                webVC.isFromReturnAndChange = true;
                [self.navigationController pushViewController:webVC animated:true];
            }
        } fail:^(NSError *error) {
            //
        }];
    }else{
        NSMutableArray *imgDataArr = [NSMutableArray array];
        for (UIImage *img in _sourceArray) {
            NSData *imageData = UIImageJPEGRepresentation(img,1.0);
            CGFloat sizeOriginKB = imageData.length / 1024.0;
            if (sizeOriginKB <= 200.0) {
                [imgDataArr addObject:imageData];
            }else{
                NSData *data = [NSData reSizeImageData:img maxImageSize:800 maxSizeWithKB:200];
                [imgDataArr addObject:data];
            }
        }
        [UploadUtils upLoadMultimediaWithDataArr:imgDataArr success:^(NSArray *mediaStrs) {
            [params setObject:mediaStrs forKey:@"pics"];
            [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
                NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                if ([resultCode isEqualToString:@"ok"]) {
                    [MQToast showToast:@"提交成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                    ReturnOrChangedSucceedBlock block = _succeedHandle;
                    if (block) {
                        block(_itemData.no);
                    }
                    UserInfo *info = [Utils getUserInfo];
                    NSString *urlStr = [NSString stringWithFormat:@"%@user/order/%@/%@/trace-change?userId=%@",BaseUrl,_itemData.no,_detailId,info.userId];
                    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
                    webVC.hidesBottomBarWhenPushed = true;
                    webVC.isFromReturnAndChange = true;
                    [self.navigationController pushViewController:webVC animated:true];
                }
            } fail:^(NSError *error) {
                //
            }];
        } fail:^(NSString *errStr) {
            [MQToast showToast:@"图片上传失败" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        } progress:^(NSString *progressStr) {
            
        }];
    }
}

//提交数据
-(void)commitData{
    if (_seletcedIndex < 0) {
        [MQToast showToast:@"请选择服务类型" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    if (_resion.length == 0) {
        [MQToast showToast:@"请选择申请原因" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    if (_desStr.length == 0) {
        [MQToast showToast:@"请输入问题描述" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    [self showTipsView];
}

@end
