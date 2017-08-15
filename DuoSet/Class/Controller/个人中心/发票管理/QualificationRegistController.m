//
//  QualificationRegistController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "QualificationRegistController.h"
#import "QualificationRegistInputCell.h"
#import "QualificationRegistPicCell.h"
#import "QualificationRegistFootView.h"
#import "QualificationData.h"
#import "SDWebImageManager.h"

@interface QualificationRegistController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titleNameArr;
@property(nonatomic,strong) NSArray *placeStrArr;
@property(nonatomic,strong) NSMutableArray *contentArr;
@property(nonatomic,strong) NSData *imageData;
@property(nonatomic,strong) UIImage *img;
@property(nonatomic,strong) QualificationData *qualification;
@property(nonatomic,strong) QualificationRegistFootView *footView;
//提交数据
@property(nonatomic,copy) NSString *unitName;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,copy) NSString *registerAddress;
@property(nonatomic,copy) NSString *registerPhone;
@property(nonatomic,copy) NSString *openBank;
@property(nonatomic,copy) NSString *bankAccount;

@end

@implementation QualificationRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    self.title = @"添加增票资格";
    _titleNameArr = @[@"单位名称:",@"纳税人识别码:",@"注册地址:",@"注册电话:",@"开户银行:",@"银行账号:"];
    _placeStrArr = @[@"请输入单位名称",@"请输入纳税人识别码",@"请输入注册地址",@"请输入注册电话",@"请输入开户银行名称",@"请输入银行账号"];
    [self configUI];
    
    _unitName = @"";
    _code = @"";
    _registerAddress = @"";
    _registerPhone = @"";
    _openBank = @"";
    _bankAccount = @"";
    
    [self configData];
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/invoice/qualification" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"qualification"]) {
                    if ([objDic objectForKey:@"qualification"] != [NSNull null]) {
                        if ([[objDic objectForKey:@"qualification"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *qualificationDic = [objDic objectForKey:@"qualification"];
                            _qualification = [QualificationData dataForDictionary:qualificationDic];
                            _contentArr = [NSMutableArray arrayWithObjects:_qualification.unitName,_qualification.code,_qualification.registerAddress,_qualification.registerPhone,_qualification.openBank,_qualification.bankAccount, nil];
                            
                            _unitName = _qualification.unitName;
                            _code = _qualification.code;
                            _registerAddress = _qualification.registerAddress;
                            _registerPhone = _qualification.registerPhone;
                            _openBank = _qualification.openBank;
                            _bankAccount = _qualification.bankAccount;
                            
                            [_footView setupInfoWithQualificationData:_qualification];
                            [_tableView reloadData];
                        }
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}


- (void)configUI{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth -FitWith(160.0) , 20, FitWith(160.0), 44)];
    rightBtn.titleLabel.font = CUSFONT(13);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitle:@"帮助" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightHelpHanlde) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _footView = [[QualificationRegistFootView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(360.0))];
    _tableView.tableFooterView = _footView;
    __weak typeof(self) weakSelf = self;
    _footView.commitHandle = ^(){
        [weakSelf commitData];
    };
    _footView.downHandle = ^(){
        [weakSelf downPic];
    };
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBord)];
    [_tableView addGestureRecognizer:tap];
}

-(void)rightHelpHanlde{
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@static/invoice/qualification-help.html",WebBaseUrl] NavTitle:@""];
    webVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:webVC animated:true];
}

-(void)hiddenKeyBord{
    [self.view endEditing:false];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 6 : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{//
    if (indexPath.section == 0) {
        static NSString *QualificationRegistInputCellID = @"QualificationRegistInputCellID";
        QualificationRegistInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:QualificationRegistInputCellID];
        if (cell == nil) {
            cell = [[QualificationRegistInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QualificationRegistInputCellID];
        }
        cell.tipLable.text = _titleNameArr[indexPath.row];
        if (_qualification) {
            cell.inputTF.text = _contentArr[indexPath.row];
            if(_qualification.status != CheckInfoFailure){
                cell.inputTF.userInteractionEnabled = false;
            }
        }
        cell.inputTF.placeholder = _placeStrArr[indexPath.row];
        cell.inputTF.returnKeyType = indexPath.row != 5 ? UIReturnKeyNext : UIReturnKeyDone;
        if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 ) {
            cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        }else{
            cell.inputTF.keyboardType = UIKeyboardTypeDefault;
        }
        cell.inputTF.delegate = self;
        cell.inputTF.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {//
        static NSString *QualificationRegistPicCellID = @"QualificationRegistPicCellID";
        QualificationRegistPicCell * cell = [_tableView dequeueReusableCellWithIdentifier:QualificationRegistPicCellID];
        if (cell == nil) {
            cell = [[QualificationRegistPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QualificationRegistPicCellID];
        }
        if (_qualification) {
            if(_qualification.status != CheckInfoFailure){
                cell.picView.userInteractionEnabled = false;
                cell.deletedBtn.userInteractionEnabled = false;
                [cell.picView sd_setImageWithURL:[NSURL URLWithString:_qualification.entrustPicture] placeholderImage:placeholderImage_226_256 options:0];
                cell.deletedBtn.hidden = true;
            }else{//审核失败
                cell.picView.userInteractionEnabled = true;
                cell.deletedBtn.userInteractionEnabled = true;
                [cell.picView sd_setImageWithURL:[NSURL URLWithString:_qualification.entrustPicture] placeholderImage:placeholderImage_226_256 options:0];
                cell.deletedBtn.hidden = false;
                [self downPicCheckInfoFailureImg];
            }
        }else{
            cell.deletedBtn.hidden = true;
            cell.showbigPicHandle = ^(){
                if (_imageData == nil) {
                    [self choicePic];
                }else{
                    [self showBigImgV];
                }
            };
            cell.deletedPicHandle = ^(){
                cell.picView.image = [UIImage imageNamed:@"upload_pic_img"];
                cell.deletedBtn.hidden = true;
                _imageData = nil;
                _img = nil;
            };
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return FitHeight(100.0);
    }
    if (indexPath.section == 1) {
        return FitHeight(320.0);
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        QualificationRegistInputCell * cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        _unitName = cell0.inputTF.text;
    }
    if (textField.tag == 1) {
        QualificationRegistInputCell * cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        _code = cell1.inputTF.text;
    }
    if (textField.tag == 2) {
        QualificationRegistInputCell * cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        _registerAddress = cell2.inputTF.text;
    }
    if (textField.tag == 3) {
        QualificationRegistInputCell * cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        _registerPhone = cell3.inputTF.text;
    }
    if (textField.tag == 4) {
        QualificationRegistInputCell * cell4 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        _openBank = cell4.inputTF.text;
    }
    if (textField.tag == 5) {
        QualificationRegistInputCell * cell5 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        _bankAccount = cell5.inputTF.text;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    QualificationRegistInputCell * cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    QualificationRegistInputCell * cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    QualificationRegistInputCell * cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    QualificationRegistInputCell * cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    QualificationRegistInputCell * cell4 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    QualificationRegistInputCell * cell5 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    if (textField == cell0.inputTF) {
        _unitName = cell0.inputTF.text;
        [cell1.inputTF becomeFirstResponder];
    }
    if (textField == cell1.inputTF) {
        _code = cell1.inputTF.text;
        [cell2.inputTF becomeFirstResponder];
    }
    if (textField == cell2.inputTF) {
        _registerAddress = cell2.inputTF.text;
        [cell3.inputTF becomeFirstResponder];
    }
    if (textField == cell3.inputTF) {
        _registerPhone = cell3.inputTF.text;
        [cell4.inputTF becomeFirstResponder];
    }
    if (textField == cell4.inputTF) {
        _openBank = cell4.inputTF.text;
        [cell5.inputTF becomeFirstResponder];
    }
    if (textField == cell5.inputTF) {
        _bankAccount = cell5.inputTF.text;
        [cell5.inputTF resignFirstResponder];
    }
    return true;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:true];
}

-(void)downPicCheckInfoFailureImg{
    [UploadUtils downImageWithUrlStrArr:[NSMutableArray arrayWithObject:_qualification.entrustPicture] success:^(NSArray *imgArr) {
        if (imgArr.count > 0) {
            UIImage *image = imgArr[0];
            _img = image;
            _imageData = [NSData data];
            _imageData = UIImageJPEGRepresentation(image, 0.5);
        }
    } errorBlock:^(NSError *error) {
        [self.view makeToast:@"获取图片失败，请重新上传委托证书"];
    }];
}


#pragma mark - seletcedPic
-(void)choicePic{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择您要上传的图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.sourceType = sourceType;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        }
        
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [self presentViewController:pickerImage animated:YES completion:^{
        }];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:^{//img
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        QualificationRegistPicCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.picView.image = image;
        _img = image;
        _imageData = [NSData data];
        _imageData = UIImageJPEGRepresentation(image, 0.5);
        cell.deletedBtn.hidden = false;
    }];
}

-(void)showBigImgV{
    ScanPictureViewController *picVC = [[ScanPictureViewController alloc]init];
    picVC.photos = [NSMutableArray arrayWithObject:_img];
    [self.navigationController presentViewController:picVC animated:true completion:nil];
}

-(void)downPic{
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@default/protocol/img/authorize-protocol-by-invoice.jpg",WebBaseUrl]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (error) {
            [RequestManager showAlertFrom:self title:@"下载失败" mesaage:@"请联系客服" success:^{
                //
            }];
        }
        if (image){
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        [RequestManager showAlertFrom:self title:@"下载成功" mesaage:@"请到个人相册查看下载的委托书模板" success:^{
            //
        }];
    }else{
        [RequestManager showAlertFrom:self title:@"下载失败" mesaage:@"请联系客服" success:^{
            //
        }];
    }
}

-(void)commitData{
    if (
        _unitName.length == 0 ||
        _code.length == 0 ||
        _registerAddress.length == 0 ||
        _registerPhone.length == 0 ||
        _openBank.length == 0 ||
        _bankAccount.length == 0
        ) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"信息输入不完整，请完善信息" success:^{
            //
        }];
        return;
    }
    if (_imageData == nil) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请上传委托证书" success:^{
            //
        }];
        return;
    }
    [UploadUtils upLoadMultimediaWithData:_imageData success:^(NSString *mediaStr) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_unitName forKey:@"unitName"];
        [params setObject:_code forKey:@"code"];
        [params setObject:_registerAddress forKey:@"registerAddress"];
        [params setObject:_registerPhone forKey:@"registerPhone"];
        [params setObject:_openBank forKey:@"openBank"];
        [params setObject:_bankAccount forKey:@"bankAccount"];
        [params setObject:mediaStr forKey:@"entrustPicture"];
        
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/invoice/qualification" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [RequestManager showAlertFrom:self title:@"" mesaage:@"审核信息提交成功" success:^{
                    RegistUploadBlock block = _uploadHandle;
                    if (block) {
                        block();
                    }
                    [self.navigationController popViewControllerAnimated:true];
                }];
            }
        } fail:^(NSError *error) {
            //
        }];
    } fail:^(NSString *errStr) {
        NSLog(@"errStr:%@",errStr);
        //
    } progress:^(NSString *progressStr) {
        [self.view makeToast:@"上传失败"];
    }];
}

@end
