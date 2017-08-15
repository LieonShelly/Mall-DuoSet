//
//  RegisterDesignerController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RegisterDesignerController.h"
#import "RegisterDesignerTipsCell.h"
#import "RegisterDesignerInputCell.h"
#import "RegisterDesignerUploadPicCell.h"
#import "RegisterDesignerResionCell.h"
#import "DesignerTagData.h"
#import "AHTagTableViewCell.h"
#import "DesignerData.h"
#import "RegisterDesignerHeaderView.h"

typedef enum : NSUInteger {
    ChoiceImgLeft,
    ChoiceImgRight
} ChoiceImgStyle;

@interface RegisterDesignerController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate >

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,assign) BOOL isAgree;
@property(nonatomic,strong) NSArray *tipsArr;
@property(nonatomic,strong) NSArray *placeStrArr;
@property(nonatomic,strong) NSMutableArray *tagArr;
@property(nonatomic,assign) ChoiceImgStyle choiceStatus;
@property(nonatomic,strong) NSData *leftImageData;
@property(nonatomic,strong) UIImage *leftImg;
@property(nonatomic,strong) NSData *rightImageData;
@property(nonatomic,strong) UIImage *rightImg;
@property(nonatomic,strong) NSMutableArray *seletcedArr;
@property(nonatomic,strong) RegisterDesignerHeaderView *headerView;

//
@property(nonatomic,strong) DesignerData *myInfo;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *phoneNum;
@property(nonatomic,copy) NSString *wechatStr;
@property(nonatomic,copy) NSString *qqStr;
@property(nonatomic,copy) NSString *inputStr;
@property(nonatomic,copy) NSString *idcardBack;
@property(nonatomic,copy) NSString *idcardFront;
@property(nonatomic,copy) NSString *backReason;
@property(nonatomic,copy) NSString *reason;
@property(nonatomic,strong) NSMutableArray *cotentArr;

@end

@implementation RegisterDesignerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _isEdit ? @"重新认证" : @"申请设计师认证";
    _tipsArr = @[@"*真实姓名:",@"*手机号:",@"微信号:",@"QQ号:"];
    _placeStrArr = @[@"请输入真实姓名",@"请输入您的手机号码",@"请输入您的微信账号",@"请输入您的QQ号码"];
    [self configUI];
    [self configTagData];
    if (_isEdit) {
        [self getMyInfo];
    }
}

-(void)getMyInfo{
    [RequestManager requestWithMethod:GET WithUrlPath:@"designer/designer/my" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"designer"] && [[objDic objectForKey:@"designer"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *desDic = [objDic objectForKey:@"designer"];
                    _myInfo = [DesignerData dataForDictionary:desDic];
                    _name = _myInfo.name;
                    _phoneNum = _myInfo.phone;
                    _qqStr = _myInfo.qq != nil ? _myInfo.qq : @"";
                    _wechatStr = _myInfo.weixin != nil ? _myInfo.weixin : @"";
                    _idcardBack = _myInfo.idcardBack;
                    _idcardFront = _myInfo.idcardFront;
                    _backReason = _myInfo.backReason;
                    _reason = _myInfo.reason;
                    _cotentArr = [NSMutableArray arrayWithObjects:_name,_phoneNum,_wechatStr,_qqStr, nil];
                }
                RegisterDesignerHeaderView *headerView = (RegisterDesignerHeaderView *)_tableView.tableHeaderView;
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.lineSpacing = 5;
                NSDictionary *attributes = @{
                                             NSFontAttributeName:CUSFONT(14),
                                             NSParagraphStyleAttributeName:paragraphStyle
                                             };
                NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:_myInfo.backReason attributes:attributes];
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,_myInfo.backReason.length)];
                headerView.contentLable.attributedText = attributedString;
                CGRect frame = headerView.frame;
                frame.size.height = _myInfo.backReasonCellHight;
                headerView.frame = frame;
                [_tableView beginUpdates];
                [_tableView setTableHeaderView:headerView];
                [_tableView endUpdates];

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
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"AHTagTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    if (_isEdit) {
        _headerView = [[RegisterDesignerHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(100.0))];
        _tableView.tableHeaderView = _headerView;
    }
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(245.0))];
    footView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = footView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBord)];
    [_tableView addGestureRecognizer:tap];
    
    UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), FitHeight(10.0), FitWith(260.0), FitHeight(60.0))];
    agreeBtn.titleLabel.font = CUSFONT(13);
    [agreeBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
    [agreeBtn setTitle:@"我已阅读并遵守" forState:UIControlStateNormal];
    agreeBtn.selected = false;
    agreeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    [agreeBtn addTarget:self action:@selector(agreeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _isAgree = false;
    [footView addSubview:agreeBtn];
    [footView bringSubviewToFront:agreeBtn];
    
    UIButton *protocolBtn = [[UIButton alloc]initWithFrame:CGRectMake(agreeBtn.frame.origin.x + agreeBtn.frame.size.width , agreeBtn.frame.origin.y, FitWith(250.0), agreeBtn.frame.size.height)];
    protocolBtn.titleLabel.font = CUSFONT(13);
    [protocolBtn setTitle:@"《用户服务协议》" forState:UIControlStateNormal];
    [protocolBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
    [protocolBtn addTarget:self action:@selector(protocolBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:protocolBtn];
    [footView bringSubviewToFront:protocolBtn];
    
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), protocolBtn.frame.origin.y + protocolBtn.frame.size.height + FitHeight(30.0), mainScreenWidth - FitWith(40.0), FitHeight(90.0))];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    registerBtn.titleLabel.font = CUSFONT(15);
    [registerBtn setTitle:_isEdit ? @"重新提交" : @"立即申请" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [footView bringSubviewToFront:registerBtn];
    
    [self.view addSubview:_tableView];
}

-(void)configTagData{//DesignerTagData
    [RequestManager requestWithMethod:GET WithUrlPath:@"designer/designer/tag" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            _tagArr = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objArr) {
                    DesignerTagData *item = [DesignerTagData dataForDictionary:d];
                    [_tagArr addObject:item];
                }
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)hiddenKeyBord{
    [self.view endEditing:false];
}


-(void)agreeBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    _isAgree = btn.selected;
}

-(void)protocolBtnAction{
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@static/designer/protocol.html",WebBaseUrl] NavTitle:@""];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:true];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return 2;
    }
    if (section == 3) {
        return 2;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *RegisterDesignerTipsCellID = @"RegisterDesignerTipsCellID";
            RegisterDesignerTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:RegisterDesignerTipsCellID];
            if (cell == nil) {
                cell = [[RegisterDesignerTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterDesignerTipsCellID];
            }
            cell.line.hidden = false;
            cell.tipsLable.text = @"请正确填写您的个人资料";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            NSString *RegisterDesignerInputCellID = [NSString stringWithFormat:@"RegisterDesignerInputCellID-%ld",indexPath.row];
            RegisterDesignerInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:RegisterDesignerInputCellID];
            if (cell == nil) {
                cell = [[RegisterDesignerInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterDesignerInputCellID];
            }
            cell.tipsLable.text = _tipsArr[indexPath.row - 1];
            if (indexPath.row == 1 || indexPath.row == 2) {
                NSString *text = _tipsArr[indexPath.row - 1];
                NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
                if (text.length > 2) {
                    [attributeString addAttribute:NSFontAttributeName value:CUSFONT(13) range:NSMakeRange(0, 1)];
                    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0, 1)];
                }
                cell.tipsLable.attributedText = attributeString;
            }
            cell.inputTF.delegate = self;
            cell.inputTF.placeholder = _placeStrArr[indexPath.row - 1];
            cell.inputTF.returnKeyType = indexPath.row == 4 ? UIReturnKeyDone : UIReturnKeyNext;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_isEdit) {
                cell.inputTF.text = _cotentArr[indexPath.row - 1];
            }
            return cell;
        }
    }
    if (indexPath.section == 1) {//
        if (indexPath.row == 0) {
            static NSString *RegisterDesignerTipsCellID = @"RegisterDesignerTipsCellID";
            RegisterDesignerTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:RegisterDesignerTipsCellID];
            if (cell == nil) {
                cell = [[RegisterDesignerTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterDesignerTipsCellID];
            }
            cell.line.hidden = true;
            cell.tipsLable.text = @"本人身份证正反面";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *RegisterDesignerUploadPicCellID = @"RegisterDesignerUploadPicCellID";
            RegisterDesignerUploadPicCell * cell = [_tableView dequeueReusableCellWithIdentifier:RegisterDesignerUploadPicCellID];
            if (cell == nil) {
                cell = [[RegisterDesignerUploadPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterDesignerUploadPicCellID];
            }
            if (_isEdit) {
                if (_leftImg == nil) {
                    [cell.leftImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,_idcardFront]] placeholderImage:placeholderImage_226_256 options:0];
                    cell.leftDeletedBtn.hidden = false;
                }
                if (_rightImg == nil) {
                    [cell.rightImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,_idcardBack]] placeholderImage:placeholderImage_226_256 options:0];
                    cell.rightDeletedBtn.hidden = false;
                }
            }
            
            cell.deletedHandle = ^(NSInteger index){
                [self deletedImgVWithIndex:index];
            };
            cell.imgVTapHandle = ^(NSInteger index){
                if (index == 0) {
                    if (_isEdit) {
                        if (_idcardFront.length > 0) {
                            [self showBigImgVWithIndex:0];
                            return ;
                        }
                        if (_leftImg == nil) {
                            _choiceStatus = index == 0 ? ChoiceImgLeft : ChoiceImgRight;
                            [self choicePic];
                        }else{
                            [self showBigImgVWithIndex:0];
                        }
                        
                    }else{
                        if (_leftImg == nil) {
                            _choiceStatus = index == 0 ? ChoiceImgLeft : ChoiceImgRight;
                            [self choicePic];
                        }else{
                            [self showBigImgVWithIndex:0];
                        }
                    }
                }else{
                    if (_isEdit) {
                        if (_idcardBack.length > 0) {
                            [self showBigImgVWithIndex:1];
                        }else{
                            if (_rightImg == nil) {
                                _choiceStatus = index == 0 ? ChoiceImgLeft : ChoiceImgRight;
                                [self choicePic];
                            }else{
                                [self showBigImgVWithIndex:1];
                            }
                        }
                    }else{
                        if (_rightImg == nil) {
                            _choiceStatus = index == 0 ? ChoiceImgLeft : ChoiceImgRight;
                            [self choicePic];
                        }else{
                            [self showBigImgVWithIndex:1];
                        }
                    }
                }
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            cell.line.hidden = true;
            cell.tipsLable.text = @"申请原因:";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *RegisterDesignerResionCellID = @"RegisterDesignerResionCellID";
            RegisterDesignerResionCell * cell = [_tableView dequeueReusableCellWithIdentifier:RegisterDesignerResionCellID];
            if (cell == nil) {
                cell = [[RegisterDesignerResionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterDesignerResionCellID];
            }
            if (_isEdit) {
                cell.inputTV.text = _reason;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            static NSString *RegisterDesignerTipsCellID = @"RegisterDesignerTipsCellID";
            RegisterDesignerTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:RegisterDesignerTipsCellID];
            if (cell == nil) {
                cell = [[RegisterDesignerTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterDesignerTipsCellID];
            }
            cell.line.hidden = true;
            cell.tipsLable.text = @"标签(最多选7个)";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            AHTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            [self configureCell:cell atIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

- (void)configureCell:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if (![object isKindOfClass:[AHTagTableViewCell class]]) {
        return;
    }
    _seletcedArr = [NSMutableArray array];
    AHTagTableViewCell *cell = (AHTagTableViewCell *)object;
    NSMutableArray *ahTagArr = [NSMutableArray array];
    for (DesignerTagData *item in _tagArr) {
        AHTag *tag = [[AHTag alloc]init];
        tag.tag_id = item.tag_id;
        tag.title = item.name;
        tag.enabled = [NSNumber numberWithBool:item.isSeletced];
        [ahTagArr addObject:tag];
        if (item.isSeletced) {
            [_seletcedArr addObject:tag];
        }
    }
    cell.label.tags = ahTagArr;
    cell.label.maxSeletcedBlock = ^(){
        [self.view makeToast:@"最多只能选择7个标签"];
    };
    cell.label.seletceBlock = ^(NSMutableArray *seletcedArr){
        for (DesignerTagData *item in _tagArr) {
            for (AHTag *tag in seletcedArr) {
                if ([tag.tag_id isEqualToString:item.tag_id]) {
                    item.isSeletced = true;
                }
            }
        }
        _seletcedArr = seletcedArr;
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return indexPath.row == 0 ? FitHeight(80.0) : FitHeight(110.0);
    }
    if (indexPath.section == 1) {
        return indexPath.row == 0 ? FitHeight(80.0) : FitHeight(260.0);
    }
    if (indexPath.section == 2) {
        return indexPath.row == 0 ? FitHeight(80.0) : FitHeight(300.0);
    }
    if (indexPath.section == 3) {
        return indexPath.row == 0 ? FitHeight(80.0) : UITableViewAutomaticDimension;
    }
    return FitHeight(420);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.textLabel.textColor = [UIColor whiteColor];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - textFiledDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    RegisterDesignerInputCell * cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    RegisterDesignerInputCell * cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    RegisterDesignerInputCell * cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    RegisterDesignerInputCell * cell4 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    if (textField == cell1.inputTF) {
        [cell2.inputTF becomeFirstResponder];
    }
    if (textField == cell2.inputTF) {
        [cell3.inputTF becomeFirstResponder];
    }
    if (textField == cell3.inputTF) {
        [cell4.inputTF becomeFirstResponder];
    }
    if (textField == cell4.inputTF) {
        [cell4.inputTF resignFirstResponder];
    }
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    RegisterDesignerInputCell * cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    RegisterDesignerInputCell * cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    RegisterDesignerInputCell * cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    RegisterDesignerInputCell * cell4 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    if (cell1.inputTF == textField) {
        _name = cell1.inputTF.text;
    }
    if (cell2.inputTF == textField) {
        _phoneNum = cell2.inputTF.text;
    }
    if (cell3.inputTF == textField) {
        _wechatStr = cell3.inputTF.text;
    }
    if (cell4.inputTF == textField) {
        _qqStr = cell4.inputTF.text;
    }
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
        RegisterDesignerUploadPicCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        if (_choiceStatus == ChoiceImgLeft) {
            cell.leftImgV.image = image;
            _leftImageData = [NSData data];
            _leftImageData = UIImageJPEGRepresentation(image, 0.5);
            cell.leftDeletedBtn.hidden = false;
            _leftImg = image;
        }else{
            cell.rightImgV.image = image;
            _rightImageData = [NSData data];
            _rightImageData = UIImageJPEGRepresentation(image, 0.5);
            cell.rightDeletedBtn.hidden = false;
            _rightImg = image;
        }
    }];
}

-(void)showBigImgVWithIndex:(NSInteger)index{
    ScanPictureViewController *picVC = [[ScanPictureViewController alloc]init];
    if (_isEdit) {
        if (index == 0) {
            if (_idcardFront.length > 0) {
                [picVC setPhotosUrl:@[[NSString stringWithFormat:@"%@%@",BaseImgUrl,_idcardFront]]];
            }else{
                picVC.photos = [NSMutableArray arrayWithObject:index == 0 ? _leftImg : _rightImg];
            }
        }
        if (index == 1) {
            if (_idcardBack.length > 0) {
                [picVC setPhotosUrl:@[[NSString stringWithFormat:@"%@%@",BaseImgUrl,_idcardBack]]];
            }else{
                picVC.photos = [NSMutableArray arrayWithObject:index == 0 ? _leftImg : _rightImg];
            }
        }
    }else{
        picVC.photos = [NSMutableArray arrayWithObject:index == 0 ? _leftImg : _rightImg];
    }
    [self.navigationController presentViewController:picVC animated:true completion:nil];
}

-(void)deletedImgVWithIndex:(NSInteger)index{
    RegisterDesignerUploadPicCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if (index == 0) {
        _idcardFront = nil;
        cell.leftImgV.image = [UIImage imageNamed:@"upload_pic_img"];
        cell.leftDeletedBtn.hidden = true;
        _leftImageData = nil;
        _leftImg = nil;
    }
    if (index == 1) {
        _idcardBack = nil;
        cell.rightImgV.image = [UIImage imageNamed:@"upload_pic_img"];
        cell.rightDeletedBtn.hidden = true;
        _rightImageData = nil;
        _rightImg = nil;
    }
}

//立即申请
-(void)registerBtnAction{
    if (_name.length == 0) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请填写真实姓名" success:^(){
        }];
        return;
    }
    NSString *valiStr = [ValiMobile valiMobile:_phoneNum];
    if (![valiStr isEqualToString:@"YES"]) {
        [RequestManager showAlertFrom:self title:@"" mesaage:valiStr success:^(){
        }];
        return;
    }
    if (_leftImg == nil && _idcardFront.length == 0) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请选择身份证正面图片" success:^(){
        }];
        return;
    }
    if (_rightImg == nil && _idcardBack.length == 0) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请选择身份证背面图片" success:^(){
        }];
        return;
    }
    RegisterDesignerResionCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    if (cell.inputTV.text.length == 0) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"填写申请原因" success:^(){
        }];
        return;
    }
    if (!_isAgree) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请先阅读和同意协议" success:^(){
        }];
        return;
    }
    NSMutableArray *tagArr = [NSMutableArray array];
    if (_seletcedArr.count > 0) {
        for (AHTag *tag in _seletcedArr) {
            [tagArr addObject:tag.tag_id];
        }
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:cell.inputTV.text forKey:@"reason"];
    [params setObject:_name forKey:@"name"];
    [params setObject:_phoneNum forKey:@"phone"];
    if (_wechatStr.length > 0) {//微信号
        [params setObject:_wechatStr forKey:@"weixin"];
    }
    if (_qqStr.length > 0) {//QQ号
        [params setObject:_qqStr forKey:@"qq"];
    }
    if (tagArr.count > 0) {
        [params setObject:tagArr forKey:@"tag"];
    }
    if (_isEdit) {
        if (_idcardFront.length > 0) {
            [params setObject:_idcardFront forKey:@"idcardFront"];
            if (_idcardBack.length > 0) {
                [params setObject:_idcardBack forKey:@"idcardBack"];//一个都没修改
                [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/apply" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {//上传接口
                    NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                    if ([resultCode isEqualToString:@"ok"]) {
                        RegisterUploadSucceedBlock block = _registerHandle;
                        if (block) {
                            block();
                        }
                        [self.view makeToast:@"申请信息提交成功"];
                        [self.navigationController popViewControllerAnimated:true];
                    }
                } fail:^(NSError *error) {
                    //
                }];
            }else{//只有正面没修改，背面修改了
                __block NSString *rightImgUrlStr = @"";
                dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_group_t group = dispatch_group_create();
                dispatch_group_async(group, queue, ^{
                    [UploadUtils upLoadMultimediaWithData:_rightImageData success:^(NSString *mediaStr) {
                        rightImgUrlStr = mediaStr;
                        dispatch_semaphore_signal(semaphore);
                    } fail:^(NSString *errStr) {
                        //
                    } progress:^(NSString *progressStr) {
                        [self.view makeToast:@"上传失败"];
                    }];
                });
                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                    [params setObject:rightImgUrlStr forKey:@"idcardBack"];
                    [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/apply" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {//上传接口
                        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                        if ([resultCode isEqualToString:@"ok"]) {
                            RegisterUploadSucceedBlock block = _registerHandle;
                            if (block) {
                                block();
                            }
                            [self.view makeToast:@"申请信息提交成功"];
                            [self.navigationController popViewControllerAnimated:true];
                        }
                    } fail:^(NSError *error) {
                        //
                    }];
                });
            }
        }else{
            if (_idcardBack.length > 0) {//正面修改了 背面没修改
                [params setObject:_idcardBack forKey:@"idcardBack"];
                __block NSString *leftImgUrlStr = @"";
                dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_group_t group = dispatch_group_create();
                dispatch_group_async(group, queue, ^{
                    [UploadUtils upLoadMultimediaWithData:_leftImageData success:^(NSString *mediaStr) {
                        leftImgUrlStr = mediaStr;
                        dispatch_semaphore_signal(semaphore);
                    } fail:^(NSString *errStr) {
                        //
                    } progress:^(NSString *progressStr) {
                        [self.view makeToast:@"上传失败"];
                    }];
                });
                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                    [params setObject:leftImgUrlStr forKey:@"idcardFront"];
                    [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/apply" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {//上传接口
                        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                        if ([resultCode isEqualToString:@"ok"]) {
                            RegisterUploadSucceedBlock block = _registerHandle;
                            if (block) {
                                block();
                            }
                            [self.view makeToast:@"申请信息提交成功"];
                            [self.navigationController popViewControllerAnimated:true];
                        }
                    } fail:^(NSError *error) {
                        //
                    }];
                });
            }else{//都修改了
                __block NSString *leftImgUrlStr = @"";
                __block NSString *rightImgUrlStr = @"";
                dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_group_t group = dispatch_group_create();
                dispatch_group_async(group, queue, ^{
                    [UploadUtils upLoadMultimediaWithData:_leftImageData success:^(NSString *mediaStr) {
                        leftImgUrlStr = mediaStr;
                        dispatch_semaphore_signal(semaphore);
                    } fail:^(NSString *errStr) {
                        //
                    } progress:^(NSString *progressStr) {
                        [self.view makeToast:@"上传失败"];
                    }];
                });
                dispatch_group_async(group, queue, ^{
                    [UploadUtils upLoadMultimediaWithData:_rightImageData success:^(NSString *mediaStr) {
                        rightImgUrlStr = mediaStr;
                        dispatch_semaphore_signal(semaphore);
                    } fail:^(NSString *errStr) {
                        //
                    } progress:^(NSString *progressStr) {
                        [self.view makeToast:@"上传失败"];
                    }];
                });
                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                    [params setObject:leftImgUrlStr forKey:@"idcardFront"];
                    [params setObject:rightImgUrlStr forKey:@"idcardBack"];
                    [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/apply" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {//上传接口
                        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                        if ([resultCode isEqualToString:@"ok"]) {
                            RegisterUploadSucceedBlock block = _registerHandle;
                            if (block) {
                                block();
                            }
                            [self.view makeToast:@"申请信息提交成功"];
                            [self.navigationController popViewControllerAnimated:true];
                        }
                    } fail:^(NSError *error) {
                        //
                    }];
                });
            }
        }
    }else{
        __block NSString *leftImgUrlStr = @"";
        __block NSString *rightImgUrlStr = @"";
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            [UploadUtils upLoadMultimediaWithData:_leftImageData success:^(NSString *mediaStr) {
                leftImgUrlStr = mediaStr;
                dispatch_semaphore_signal(semaphore);
            } fail:^(NSString *errStr) {
                //
            } progress:^(NSString *progressStr) {
                [self.view makeToast:@"上传失败"];
            }];
        });
        dispatch_group_async(group, queue, ^{
            [UploadUtils upLoadMultimediaWithData:_rightImageData success:^(NSString *mediaStr) {
                rightImgUrlStr = mediaStr;
                dispatch_semaphore_signal(semaphore);
            } fail:^(NSString *errStr) {
                //
            } progress:^(NSString *progressStr) {
                [self.view makeToast:@"上传失败"];
            }];
        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [params setObject:leftImgUrlStr forKey:@"idcardFront"];
            [params setObject:rightImgUrlStr forKey:@"idcardBack"];
            [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/apply" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {//上传接口
                NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                if ([resultCode isEqualToString:@"ok"]) {
                    RegisterUploadSucceedBlock block = _registerHandle;
                    if (block) {
                        block();
                    }
                    [self.view makeToast:@"申请信息提交成功"];
                    [self.navigationController popViewControllerAnimated:true];
                }
            } fail:^(NSError *error) {
                //
            }];
        });
    }
}

@end
