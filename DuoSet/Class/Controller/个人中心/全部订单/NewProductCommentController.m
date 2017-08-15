//
//  NewProductCommentController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "NewProductCommentController.h"
#import "ScanPictureViewController.h"
#import "PictureView.h"
#import "SGImagePickerController.h"

@interface NewProductCommentController ()<UITextViewDelegate, extendPictureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property(nonatomic,copy) NSString *detailId;
@property(nonatomic,copy) NSString *orderNo;
@property(nonatomic,assign) NSInteger score;
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) UIView *navline;

@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *starLable;
@property(nonatomic,strong) NSMutableArray *starArr;
@property(nonatomic,strong) UIView *textViewBgView;
@property(nonatomic,strong) UITextView *theTextView;
@property(nonatomic,strong) UILabel *picTipLable;
@property(nonatomic,strong) PictureView *pictureView;
@property(nonatomic,strong) UIView *footView;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIButton *commitBtn;

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,strong) NSMutableArray *thumbnailsArray;
@property (nonatomic,strong) NSMutableArray *sourceArray;

@end

@implementation NewProductCommentController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(instancetype)initWithDetailId:(NSString *)detailId{
    self = [super init];
    if (self) {
        _detailId = detailId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _thumbnailsArray = [[NSMutableArray alloc]init];
    _sourceArray = [[NSMutableArray alloc]init];
    _score = 100;
    [self configData];
    [self configUI];
    [self configNav];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftItemHandle) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:_leftBtn];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _titleLable.text = @"书写评论";
    [_navView addSubview:_titleLable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

-(void)leftItemHandle{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"user/order/%@/detailComment",_detailId] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"orderDetail"] && [[objDic objectForKey:@"orderDetail"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *productDic = [objDic objectForKey:@"orderDetail"];
                    _orderNo = [NSString stringWithFormat:@"%@",[productDic objectForKey:@"no"]];
                    NSString *coverUrl = [NSString stringWithFormat:@"%@%@",BaseImgUrl,[productDic objectForKey:@"cover"]];
                    [_productImgV sd_setImageWithURL:[NSURL URLWithString:coverUrl] placeholderImage:placeholderImageSize(300, 300) options:0];
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configUI{
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64 - FitHeight(130.0))];
    _bgScrollView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewTapHiddenKeyBord)];
    [_bgScrollView addGestureRecognizer:tap];
    [self.view addSubview:_bgScrollView];
    
    [self configCommitView];
    
    //configFootView
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - FitHeight(130.0), mainScreenWidth, FitHeight(130.0))];
    _footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_footView];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
    _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
    [_footView addSubview:_line];
    
    _commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(24.0), FitHeight(20.0), mainScreenWidth - FitWith(48.0), FitHeight(90.0))];
    [_commitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [_commitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateDisabled];
    _commitBtn.titleLabel.font = CUSFONT(16);
    [_commitBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:_commitBtn];
    _commitBtn.enabled = false;
}

-(void)configCommitView{
    _productImgV = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(24.0), 0, FitWith(140), FitWith(140.0))];
    _productImgV.image = placeholderImageSize(300, 300);
    [_bgScrollView addSubview:_productImgV];
    
    _starLable = [[UILabel alloc]initWithFrame:CGRectMake(_productImgV.frame.origin.x + _productImgV.frame.size.width + FitWith(22), FitHeight(56.0), FitWith(136.0), FitWith(40.0))];
    _starLable.font = CUSNEwFONT(16.0);
    _starLable.text = @"星级评价";
    _starLable.textColor = [UIColor colorFromHex:0x222222];
    [_bgScrollView addSubview:_starLable];
    
    _starArr = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(_starLable.frame.origin.x + _starLable.frame.size.width + (FitWith(60.0) * i) , _starLable.frame.origin.y - FitHeight(20), FitHeight(80.0), FitHeight(80.0))];
        btn.selected = true;
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:@"comment_star_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"comment_star_selected"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(starSelectedHandle:) forControlEvents:UIControlEventTouchUpInside];
        [_starArr addObject:btn];
        [_bgScrollView addSubview:btn];
    }
    
    _textViewBgView = [[UIView alloc]initWithFrame:CGRectMake(0, FitHeight(190.0), mainScreenWidth, FitHeight(250.0))];
    _textViewBgView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [_bgScrollView addSubview:_textViewBgView];
    
    _theTextView = [[UITextView alloc]initWithFrame:CGRectMake(FitWith(24.0), FitHeight(22.0), mainScreenWidth - FitWith(48.0), _textViewBgView.frame.size.height - FitHeight(44.0))];
    _theTextView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    _theTextView.font = CUSNEwFONT(14);
    _theTextView.textColor = [UIColor colorFromHex:0x222222];
    _theTextView.delegate = self;
    _theTextView.placeholder = @"分享您的购物心得吧!";
    [_textViewBgView addSubview:_theTextView];
    
    _picTipLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), _textViewBgView.frame.origin.y + _textViewBgView.frame.size.height, mainScreenWidth - FitWith(24.0), FitHeight(64.0))];
    _picTipLable.textColor = [UIColor colorFromHex:0x808080];
    _picTipLable.font = CUSNEwFONT(14);
    _picTipLable.text = @"最多上传9张照片";
    [_bgScrollView addSubview:_picTipLable];
    
    CGFloat maxYText = CGRectGetMaxY(_picTipLable.frame);
    _width = (mainScreenWidth - FitWith(60) - FitWith(30))/3;
    
    _pictureView = [[PictureView alloc]initWithFrame:CGRectMake(0, maxYText, mainScreenWidth + FitHeight(20), _width)];
    [_pictureView diplayPicture:_thumbnailsArray];
    [_bgScrollView addSubview:_pictureView];
    _pictureView.delegate = self;
    __weak typeof(self) weakSelf = self;
    _pictureView.handleBlock = ^(){
        [weakSelf selectPicture];
        [weakSelf.theTextView resignFirstResponder];
    };
    
    _pictureView.deleteBlock = ^(NSInteger tag){
        [weakSelf.thumbnailsArray removeObjectAtIndex:tag];
        [weakSelf.sourceArray removeObjectAtIndex:tag];
        [weakSelf updateFrameAndPic];
    };
}

//按钮控制状态
-(void)textViewDidChange:(UITextView *)textView{
    NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *temp1 = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (temp1.length > 0) {
        _commitBtn.enabled = true;
    }else{
        _commitBtn.enabled = false;
    }
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
    CGFloat maxYText = CGRectGetMaxY(_picTipLable.frame);
    _pictureView.frame = CGRectMake(0, maxYText, mainScreenWidth, height);
    [_pictureView diplayPicture:_thumbnailsArray];
    [_bgScrollView setContentSize:CGSizeMake(0, _bgScrollView.frame.size.height + height)];
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

-(void)commitBtnAction{
    [_theTextView resignFirstResponder];
    _commitBtn.userInteractionEnabled = false;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_detailId forKey:@"orderDetailId"];
    [params setObject:_theTextView.text forKey:@"content"];
    [params setObject:[NSNumber numberWithInteger:_score] forKey:@"score"];
    NSString *urlStr = [NSString stringWithFormat:@"user/order/%@/comment",_orderNo];
    if (_sourceArray.count == 0) {
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                _rightBtn.userInteractionEnabled = true;
                CommentSucceedBlock block = _commentedHanld;
                if (block) {
                    block();
                }
                [MQToast showToast:@"评价成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                [self.navigationController popViewControllerAnimated:true];
            }
        } fail:^(NSError *error) {
            _rightBtn.userInteractionEnabled = true;
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
                    _rightBtn.userInteractionEnabled = true;
                    CommentSucceedBlock block = _commentedHanld;
                    if (block) {
                        block();
                    }
                    [MQToast showToast:@"评价成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                    [self.navigationController popViewControllerAnimated:true];
                }
            } fail:^(NSError *error) {
                _rightBtn.userInteractionEnabled = true;
                //
            }];
        } fail:^(NSString *errStr) {
            _rightBtn.userInteractionEnabled = true;
            [MQToast showToast:@"图片上传失败" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        } progress:^(NSString *progressStr) {
            //
        }];
    }
}

-(void)scrollViewTapHiddenKeyBord{
    [_theTextView resignFirstResponder];
}


-(void)starSelectedHandle:(UIButton *)btn{
    for (UIButton *b in _starArr) {
        b.selected = b.tag <= btn.tag;
    }
    _score = (btn.tag + 1 ) * 20;
}

@end
