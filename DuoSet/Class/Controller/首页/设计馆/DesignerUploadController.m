//
//  DesignerUploadController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerUploadController.h"
#import "PictureView.h"
#import "SGImagePickerController.h"


@interface DesignerUploadController ()<extendPictureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) UITextField *nameTF;
@property(nonatomic,strong) UILabel *picLable;
@property(nonatomic,strong) PictureView *pictureView;
//
@property(nonatomic,strong) UIView *line1;
@property(nonatomic,strong) UILabel *desLable;
@property(nonatomic,strong) UITextView *inputView;
@property(nonatomic,strong) UIView *line2;
@property(nonatomic,strong) UIButton *sureBtn;

@property(nonatomic,assign) CGFloat width;
@property(nonatomic,strong) NSMutableArray *thumbnailsArray;
@property(nonatomic,strong) NSMutableArray *sourceArray;
//编辑需要的
@property(nonatomic,strong) UILabel *resionlable;

@end

@implementation DesignerUploadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线投稿";
    _thumbnailsArray = [[NSMutableArray alloc]init];
    _sourceArray = [[NSMutableArray alloc]init];
    [self configUI];
    if (_isEdit) {
        [self downPic];
    }
}

-(void)downPic{
    [UploadUtils downImageWithUrlStrArr:_noPassData.allworksPictureList success:^(NSArray *imgArr) {
        _thumbnailsArray = [NSMutableArray arrayWithArray:imgArr];
        _sourceArray = [NSMutableArray arrayWithArray:imgArr];
        [self updateFrameAndPic];
    } errorBlock:^(NSError *error) {
        [RequestManager showAlertFrom:self title:@"获取图片失败" mesaage:@"请重新上传设计稿图片" success:^{
            //
        }];
    }];
}

-(void)configUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    _bgScrollView.contentSize = CGSizeMake(0, mainScreenHeight + FitHeight(500.0));
    _bgScrollView.showsHorizontalScrollIndicator = true;
    _bgScrollView.delegate = self;
    _bgScrollView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBord)];
    [_bgScrollView addGestureRecognizer:tap];
    [self.view addSubview:_bgScrollView];//Design_header_imgV@3x
    
    UIImageView *headerimgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(300.0))];
    headerimgV.image = [UIImage imageNamed:@"Design_header_imgV"];
    [_bgScrollView addSubview:headerimgV];
    
    if (_isEdit) {
        UILabel *noPassLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), headerimgV.frame.origin.y + headerimgV.frame.size.height,FitWith(180.0) , FitHeight(80.0))];
        noPassLable.textColor = [UIColor mainColor];
        noPassLable.text = @"驳回原因:";
        noPassLable.font = CUSFONT(15);
        noPassLable.textAlignment = NSTextAlignmentLeft;
        [_bgScrollView addSubview:noPassLable];
        
        _resionlable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), noPassLable.frame.origin.y + noPassLable.frame.size.height, mainScreenWidth - FitWith(48.0), _noPassData.backReasonCellHight)];
        _resionlable.text = _noPassData.reason;
        _resionlable.font = CUSFONT(14);
        _resionlable.textColor = [UIColor mainColor];
        _resionlable.textAlignment = NSTextAlignmentLeft;
        [_bgScrollView addSubview:_resionlable];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _resionlable.frame.origin.y + _resionlable.frame.size.height, mainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [_bgScrollView addSubview:line];
    }
    
    CGFloat nameLableY = _isEdit ? _resionlable.frame.origin.y + _resionlable.frame.size.height + 0.5 : headerimgV.frame.origin.y + headerimgV.frame.size.height;
    
    UILabel *nameTipLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), nameLableY, FitWith(180.0) , FitHeight(100.0))];
    nameTipLable.text = @"作品名";
    nameTipLable.textColor = [UIColor colorFromHex:0x222222];
    nameTipLable.font = CUSFONT(15);
    nameTipLable.textAlignment = NSTextAlignmentLeft;
    [_bgScrollView addSubview:nameTipLable];
    
    
    _nameTF = [[UITextField alloc]initWithFrame:CGRectMake(FitWith(300.0), nameTipLable.frame.origin.y, FitWith(395.0), nameTipLable.frame.size.height)];
    _nameTF.placeholder = @"快为您的作品起个名字吧";
    _nameTF.tintColor = [UIColor mainColor];
    _nameTF.font = CUSFONT(14);
    if (_isEdit) {
        _nameTF.text = _noPassData.name;
    }
    [_bgScrollView addSubview:_nameTF];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, nameTipLable.frame.origin.y + nameTipLable.frame.size.height, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
    [_bgScrollView addSubview:line];
    
    _picLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), line.frame.origin.y + line.frame.size.height, mainScreenWidth - FitWith(48.0), FitHeight(100.0))];
    _picLable.text = @"上传设计稿:(最多上传9张照片)";
    _picLable.textColor = [UIColor colorFromHex:0x222222];
    _picLable.font = CUSFONT(15);
    _picLable.textAlignment = NSTextAlignmentLeft;
    [_bgScrollView addSubview:_picLable];
    
    
    CGFloat maxYText = CGRectGetMaxY(_picLable.frame);
    _width = (mainScreenWidth - FitWith(60) - FitWith(30))/3;
    _pictureView = [[PictureView alloc]initWithFrame:CGRectMake(0, maxYText + FitHeight(20), mainScreenWidth + FitHeight(20), _width)];
    [_pictureView diplayPicture:_thumbnailsArray];
    [_bgScrollView addSubview:_pictureView];
    _pictureView.delegate = self;
    __weak typeof(self) weakSelf = self;
    _pictureView.handleBlock = ^(){
        [weakSelf selectPicture];
        [weakSelf.inputView resignFirstResponder];
    };
    
    _pictureView.deleteBlock = ^(NSInteger tag){
        [weakSelf.thumbnailsArray removeObjectAtIndex:tag];
        [weakSelf.sourceArray removeObjectAtIndex:tag];
        //        [weakSelf updateBtnColor];
        [weakSelf updateFrameAndPic];
    };
    
    _line1 = [[UIView alloc]initWithFrame:CGRectMake(0, _pictureView.frame.origin.y + _pictureView.frame.size.height + FitHeight(30.0), mainScreenWidth, 0.5)];
    _line1.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
    [_bgScrollView addSubview:_line1];
    
    _desLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), _line1.frame.origin.y + _line1.frame.size.height, FitWith(350.0), FitHeight(100.0))];
    _desLable.text = @"设计理念";
    _desLable.textColor = [UIColor colorFromHex:0x222222];
    _desLable.font = CUSFONT(15);
    _desLable.textAlignment = NSTextAlignmentLeft;
    [_bgScrollView addSubview:_desLable];
    
    _inputView = [[UITextView alloc]initWithFrame:CGRectMake(FitWith(30.0), _desLable.frame.origin.y +_desLable.frame.size.height, mainScreenWidth - FitWith(60.0), FitHeight(200.0))];
    _inputView.font = CUSFONT(12);
    _inputView.placeholder = @"我们非常看重您的设计理念(200字以内)";
    _inputView.textAlignment = NSTextAlignmentLeft;
    _inputView.textColor = [UIColor colorFromHex:0x666666];
    _inputView.returnKeyType = UIReturnKeyDefault;
    if (_isEdit) {
        _inputView.text = _noPassData.descr;
    }
    [_bgScrollView addSubview:_inputView];
    
    _line2 = [[UIView alloc]initWithFrame:CGRectMake(0, _inputView.frame.origin.y + _inputView.frame.size.height + FitHeight(30.0), mainScreenWidth, 0.5)];
    _line2.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
    [_bgScrollView addSubview:_line2];
    
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), _line2.frame.origin.y + _line2.frame.size.height + FitHeight(70.0), mainScreenWidth - FitWith(40.0), FitHeight(90.0))];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    [_sureBtn setTitle:@"立即投稿" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:_sureBtn];
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
        [self updateFrameAndPic];
    }];
}

#pragma mark - 更新图片尺寸
- (void)updateFrameAndPic{
    CGFloat height;
    if (_thumbnailsArray.count >= 3 && _thumbnailsArray.count < 6) {
        height = _width*2 + FitWith(10);
    }else if (_thumbnailsArray.count >= 6){
        height = _width*3 + FitWith(20);
    }else{
        height = _width;
    }
    
    CGFloat maxYText = CGRectGetMaxY(_picLable.frame);
    _pictureView.frame = CGRectMake(0, maxYText + FitHeight(20), mainScreenWidth, height);
    [_pictureView diplayPicture:_thumbnailsArray];
    CGFloat picViewY = CGRectGetMaxY(_pictureView.frame);
    
    _line1.frame = CGRectMake(0, picViewY + FitHeight(30.0), mainScreenWidth, 0.5);
    _desLable.frame = CGRectMake(FitWith(24.0), _line1.frame.origin.y + _line1.frame.size.height, FitWith(350.0), FitHeight(100.0));
    _inputView.frame = CGRectMake(FitWith(30.0), _desLable.frame.origin.y +_desLable.frame.size.height, mainScreenWidth - FitWith(60.0), FitHeight(200.0));
    _line2.frame = CGRectMake(0, _inputView.frame.origin.y + _inputView.frame.size.height + FitHeight(30.0), mainScreenWidth, 0.5);
    _sureBtn.frame = CGRectMake(FitWith(20.0), _line2.frame.origin.y + _line2.frame.size.height + FitHeight(70.0), mainScreenWidth - FitWith(40.0), FitHeight(90.0));
}

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
        [self updateFrameAndPic];
        
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
#pragma mark - 隐藏键盘
-(void)hiddenKeyBord{
    [_nameTF resignFirstResponder];
    [_inputView resignFirstResponder];
}

-(void)sureBtnAction{
    if(_nameTF.text.length == 0){
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请输入作品名称" success:^{
            //
        }];
        return;
    }
    if (_sourceArray.count == 0) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请选择您的设计稿图片" success:^{
            //
        }];
        return;
    }
    if (_inputView.text.length == 0) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请输入您的设计理念" success:^{
            //
        }];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_isEdit) {
        [params setObject:[NSNumber numberWithInteger:_noPassData.objId.integerValue] forKey:@"id"];
    }
    [params setObject:_nameTF.text forKey:@"name"];
    [params setObject:_inputView.text forKey:@"descr"];
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
    _sureBtn.userInteractionEnabled = false;
    [UploadUtils upLoadMultimediaWithDataArr:imgDataArr success:^(NSArray *mediaStrs) {
        [params setObject:mediaStrs forKey:@"picture"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/works/apply" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                _sureBtn.userInteractionEnabled = true;
                if (_isEdit) {
                    EditSucceedBlock block = _editHanlde;
                    if (block) {
                        block();
                    }
                }
                if (underiOS9) {
                    [self alertIos8handle];
                }else{
                    [RequestManager showAlertFrom:self title:@"温馨提示" mesaage:@"提交成功，请等待审核" success:^{
                        [self.navigationController popViewControllerAnimated:true];
                    }];
                }
            }
        } fail:^(NSError *error) {
            _sureBtn.userInteractionEnabled = true;
            //
        }];
    } fail:^(NSString *errStr) {
        _sureBtn.userInteractionEnabled = true;
        //
    } progress:^(NSString *progressStr) {
        [self.view makeToast:@"上传失败"];
    }];
}

-(void)alertIos8handle{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"提交成功，请等待审核" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    alert.delegate = self;
    [alert addButtonWithTitle:@"确定"];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:true];
}

@end
