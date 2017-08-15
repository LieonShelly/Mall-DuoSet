//
//  FeedbackUploadController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FeedbackUploadController.h"
#import "MEIQIA_HPGrowingTextView.h"
#import "PictureView.h"
#import "SGImagePickerController.h"

@interface FeedbackUploadController ()<UITextViewDelegate,extendPictureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property(nonatomic,assign) FeedbackType type;
@property(nonatomic,copy) NSString *titleName;
//View
@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) UITextView *inputView;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) PictureView *pictureView;
@property(nonatomic,strong) UIButton *sureBtn;
//Data
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,strong) NSMutableArray *thumbnailsArray;
@property(nonatomic,strong) NSMutableArray *sourceArray;

@end

#define MAX_LIMIT_NUMS 100

@implementation FeedbackUploadController

-(instancetype)initWithFeedbackType:(FeedbackType)type andTitleName:(NSString *)titleName{
    self = [super init];
    if (self) {
        _type = type;
        _titleName = titleName;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleName;
    _thumbnailsArray = [[NSMutableArray alloc]init];
    _sourceArray = [[NSMutableArray alloc]init];
    [self configUI];
}

-(void)configUI{
    
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64)];
    [_bgScrollView setContentSize:CGSizeMake(0, mainScreenHeight - 64 + FitHeight(200.0))];
    _bgScrollView.showsHorizontalScrollIndicator = false;
    [self.view addSubview:_bgScrollView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _inputView = [[UITextView alloc]initWithFrame:CGRectMake(FitWith(24.0), 20, mainScreenWidth - FitWith(48.0), FitHeight(200.0))];
    _inputView.placeholder = @"写下哆集的功能建议或发现的系统问题，谢谢亲的厚爱!(100字以内)";
    _inputView.maxHeight = FitHeight(200.0);
    _inputView.placeholderColor = [UIColor colorFromHex:0x808080];
    _inputView.delegate = self;
    _inputView.font = CUSFONT(14);
    _inputView.textColor = [UIColor colorFromHex:0x222222];
    _inputView.textAlignment = NSTextAlignmentLeft;
    [_bgScrollView addSubview:_inputView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _inputView.frame.origin.y + _inputView.frame.size.height + FitHeight(20.0), mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    [_bgScrollView addSubview:line];
    
    _tipsLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), line.frame.origin.y + line.frame.size.height + FitHeight(20.0), mainScreenWidth - FitWith(24.0), FitHeight(94.0))];
    _tipsLable.font = CUSFONT(16);
    _tipsLable.textColor = [UIColor colorFromHex:0x222222];
    _tipsLable.textAlignment = NSTextAlignmentLeft;
    _tipsLable.text = @"添加图片依据";
    [_bgScrollView addSubview:_tipsLable];
    
    CGFloat maxYText = CGRectGetMaxY(_tipsLable.frame);
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
    
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(24.0),_pictureView.frame.origin.y + _pictureView.frame.size.height + FitHeight(200.0), mainScreenWidth - FitWith(48.0), FitHeight(90.0))];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:_sureBtn];
    
    self.view.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBord)];
    [self.view addGestureRecognizer:tap];
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
    
    CGFloat maxYText = CGRectGetMaxY(_tipsLable.frame);
    _pictureView.frame = CGRectMake(0, maxYText + FitHeight(30.0), mainScreenWidth, height);
    
    _sureBtn.frame = CGRectMake(FitWith(24.0),_pictureView.frame.origin.y + _pictureView.frame.size.height + FitHeight(100.0), mainScreenWidth - FitWith(48.0), FitHeight(90.0));
    
    [_pictureView diplayPicture:_thumbnailsArray];
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

-(void)hiddenKeyBord{
    [_inputView resignFirstResponder];
}

-(void)sureBtnAction{
    if (_inputView.text.length == 0) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请填写您的建议吧。" success:^{
            //
        }];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_inputView.text forKey:@"content"];
    if (_type == FeedbackWithSuggestForSys) {
        [params setObject:[NSNumber numberWithInt:0] forKey:@"type"];
    }
    if (_type == FeedbackWithErrorWithApp) {
        [params setObject:[NSNumber numberWithInt:1] forKey:@"type"];
    }
    if (_type == FeedbackWithErrorWithOrder) {
        [params setObject:[NSNumber numberWithInt:2] forKey:@"type"];
    }
    if (_sourceArray.count == 0) {
        _sureBtn.userInteractionEnabled = false;
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/suggestion/add" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                _sureBtn.userInteractionEnabled = true;
                [RequestManager showAlertFrom:self title:@"温馨提示" mesaage:@"感谢亲给予的帮助，我们会立即更正，请继续关注我们app哦～" success:^{
                    [self.navigationController popViewControllerAnimated:true];
                }];
            }
        } fail:^(NSError *error) {
            _sureBtn.userInteractionEnabled = true;
            //
        }];
        return;
    }
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
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/suggestion/add" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                _sureBtn.userInteractionEnabled = true;
                [RequestManager showAlertFrom:self title:@"温馨提示" mesaage:@"感谢亲给予的帮助，我们会立即更正，请继续关注我们app哦～" success:^{
                    [self.navigationController popViewControllerAnimated:true];
                }];
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

#pragma mark - TextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
    bool isChinese;//判断是否是中文
    if ([[[UIApplication sharedApplication]textInputMode].primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = false;
    }else{
        isChinese = true;
    }
    //要求输入最多40位字符
    NSString *str = [[textView text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {//输入的是汉字
            if ( str.length>=MAX_LIMIT_NUMS) {
                NSString *strNew = [NSString stringWithString:str];
                [textView setText:[strNew substringToIndex:MAX_LIMIT_NUMS]];
            }
        }else{//英文还没有转化为汉字
            
        }
    }else{
        if ([str length]>=MAX_LIMIT_NUMS + 1) {
            NSString *strNew = [NSString stringWithString:str];
            [textView setText:[strNew substringToIndex:MAX_LIMIT_NUMS]];
        }
    }
}

@end
