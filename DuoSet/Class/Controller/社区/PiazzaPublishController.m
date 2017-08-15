//
//  PiazzaPublishController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaPublishController.h"
#import "DSPublishToolbar.h"
#import "MEIQIA_HPGrowingTextView.h"
#import "PictureView.h"
#import "SGImagePickerController.h"
#import "PiazzaPurchasedProduct.h"
#import "PiazzaPurchasedListController.h"
#import "PiazzaItemData.h"

typedef enum : NSUInteger {
    ChoiceImageWithContent,
    ChoiceImageWithCover,
} ChoiceImageStatus;

@interface PiazzaPublishController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIWebViewDelegate>

@property(nonatomic,assign) BOOL didUpdateConstraints;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) DSPublishToolbar *toolbar;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, strong) UILabel *rightTitleCountLable;
@property (nonatomic, weak) UIView *textFieldBottomLine;
@property (nonatomic, weak) UIView *textViewBottomLine;

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIScrollView *footScrollView;

@property (nonatomic, strong) NSMutableArray *footCoverImageViewArr;
@property (nonatomic, strong) NSMutableArray *realImgArray;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, assign) ChoiceImageStatus choiceStatus;
@property (nonatomic, copy)  NSString *inHtmlString;
@property (nonatomic, copy)  NSString *communityId;
@property (nonatomic, strong) PiazzaItemData *piazzaData;
@property (nonatomic, strong) NSMutableArray *urlPicArr;

@end

@implementation PiazzaPublishController

-(instancetype)initWithPiazzaItemId:(NSString *)communityId{
    self = [super init];
    if (self) {
        _communityId = communityId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _sourceArray = [[NSMutableArray alloc]init];
    [self configUI];
    if (_communityId.length > 0) {
        [self configData];
    }
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"community/%@/edit",_communityId] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"community"] && [[objDic objectForKey:@"community"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *itemDic = [objDic objectForKey:@"community"];
                    _piazzaData = [PiazzaItemData dataForDictionary:itemDic];
                    self.textField.text = _piazzaData.title;
                    _rightTitleCountLable.text = [NSString stringWithFormat:@"%ld",30-_piazzaData.title.length];
                    self.inHtmlString = _piazzaData.content;
                    NSString *place = [NSString stringWithFormat:@"window.placeHTMLToEditor('%@')",self.inHtmlString];
                    [_webView stringByEvaluatingJavaScriptFromString:place];
                }
                if ([objDic objectForKey:@"communityPicture"] && [[objDic objectForKey:@"communityPicture"] isKindOfClass:[NSArray class]]) {
                    NSArray *picArr = [objDic objectForKey:@"communityPicture"];
                    _urlPicArr = [NSMutableArray array];
                    for (NSDictionary *d in picArr) {
                        if ([d objectForKey:@"picture"]) {
                            NSString *imgUrl = [NSString stringWithFormat:@"%@%@",BaseImgUrl,[d objectForKey:@"picture"]];
                            [_urlPicArr addObject:imgUrl];
                        }
                    }
                    if (_urlPicArr.count > 0) {
                        [self downPic];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)downPic{
    [UploadUtils downImageWithUrlStrArr:_urlPicArr success:^(NSArray *imgArr) {
        _sourceArray = [NSMutableArray arrayWithArray:imgArr];
        _realImgArray = [NSMutableArray arrayWithArray:imgArr];
        if (_sourceArray.count < 9) {
            UIImage *imge = [UIImage imageNamed:@"piazz_publish_choicebtn"];
            [_sourceArray addObject:imge];
        }
        [self setupScrollViewiSubImagesWithSourceArray:_sourceArray];
    } errorBlock:^(NSError *error) {
        [RequestManager showAlertFrom:self title:@"获取图片失败" mesaage:@"请重新上传设计稿图片" success:^{
            //
        }];
    }];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发表笔记";
    
    UIButton *publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    publishBtn.titleLabel.font = CUSNEwFONT(20);
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishUpload) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithCustomView:publishBtn];
    self.navigationItem.rightBarButtonItem = save;
    
    [self setupTextField];
    
    CGRect frame = CGRectMake(0, 51 + 64, mainScreenWidth, FitHeight(660.0));
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc]initWithFrame:frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *indexFileURL = [bundle URLForResource:@"richTextEditor" withExtension:@"html"];
    
    [self.webView setKeyboardDisplayRequiresUserAction:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:indexFileURL]];
    
    UIView *textViewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.inputView.height, self.view.width, 1)];
    textViewBottomLine.backgroundColor = [UIColor colorFromHex:0xE6E6E6];
    [self.inputView addSubview:textViewBottomLine];
    self.textViewBottomLine = textViewBottomLine;
    
    _sourceArray = [[NSMutableArray alloc]init];
    _realImgArray = [[NSMutableArray alloc]init];
    [self configFootScrollView];
    UIImage *imge = [UIImage imageNamed:@"piazz_publish_choicebtn"];
    [_sourceArray addObject:imge];
    [self setupScrollViewiSubImagesWithSourceArray:_sourceArray];
    
    // 键盘的frame发生改变时发出的通知（位置和尺寸）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setupToolbar];
}

-(void)saveText{
    [self printHTML];
}

- (NSString *)printHTML{
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('title-input').value"];
    NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').innerHTML"];
    NSString *script = [self.webView stringByEvaluatingJavaScriptFromString:@"window.alertHtml()"];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
    NSLog(@"Title: %@", title);
    NSLog(@"Inner HTML: %@", html);
    NSString *htmlString = html;
    NSLog(@"htmlString:%@",htmlString);
    return htmlString;
}

-(NSString *)filterHTML:(NSString *)html{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    NSString *newhtml = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    return newhtml;
}

#pragma mark - 选择图片
- (void)selectPicture{
    _choiceStatus = ChoiceImageWithCover;
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
        NSLog(@"");
        if (_choiceStatus == ChoiceImageWithCover) {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
            [_realImgArray addObject:image];
            UIImage *imge = [UIImage imageNamed:@"piazz_publish_choicebtn"];
            [_sourceArray removeObject:imge];
            [_sourceArray addObject:image];
            if (_realImgArray.count < 9) {
                [_sourceArray addObject:imge];
            }
            [self setupScrollViewiSubImagesWithSourceArray:_sourceArray];
        }else{
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [self contentPicHandleWithImage:image];
        }
    }];
}

#pragma mark - 选择图片
- (void)selectMorePicture{
    SGImagePickerController *imageCon = [[SGImagePickerController alloc]init];
    imageCon.maxCount = 10 - _sourceArray.count;
    //返回选中的原图
    [imageCon setDidFinishSelectImages:^(NSArray *images) {
        for (UIImage *image in images) {
            [_realImgArray addObject:image];
            UIImage *publishImge = [UIImage imageNamed:@"piazz_publish_choicebtn"];
            [_sourceArray removeObject:publishImge];
            [_sourceArray addObject:image];
            if (_realImgArray.count < 9) {
                [_sourceArray addObject:publishImge];
            }
        }
        [self setupScrollViewiSubImagesWithSourceArray:_sourceArray];
    }];
    //返回选择的缩略图
//    [imageCon setDidFinishSelectThumbnails:^(NSArray *thumbnails) {
//        for (UIImage *image in thumbnails) {
//            [_thumbnailsArray addObject:image];
//        }
//        //        [self updateBtnColor];
//        //        [self updateFrameAndPic];
//        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:5]] withRowAnimation:UITableViewRowAnimationFade];
//        
//    }];
    [self presentViewController:imageCon animated:YES completion:^{
        
    }];
}

-(void)setupScrollViewiSubImagesWithSourceArray:(NSMutableArray *)sourceArray{
    _footScrollView.contentSize = CGSizeMake(((FitHeight(320.0) + FitWith(10.0)) * sourceArray.count) + FitWith(20.0), 0);
    for (int i = 0; i < 9; i++) {
        UIImageView *imgV = _footCoverImageViewArr[i];
        if (i < sourceArray.count) {
            imgV.hidden = false;
            imgV.image = sourceArray[i];
        }else{
            imgV.hidden = true;
        }
    }
}

//图片点击操作
-(void)imgVTapAction:(UITapGestureRecognizer *)tap{
    if (_realImgArray.count < 9  && tap.view.tag == _sourceArray.count - 1) {
        [self selectPicture];
    }else{
        [self deleteImghandleWithIndex:tap.view.tag];
    }
}

-(void)deleteImghandleWithIndex:(NSInteger)index{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (_sourceArray.count >= 9) {
            UIImage *publishImge = [UIImage imageNamed:@"piazz_publish_choicebtn"];
            if (![_sourceArray containsObject: publishImge]) {
                [_sourceArray addObject:publishImge];
            }
        }
        [_sourceArray removeObjectAtIndex:index];
        [_realImgArray removeObjectAtIndex:index];
        [self setupScrollViewiSubImagesWithSourceArray:_sourceArray];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark - 内容单选图片
-(void)addContentPic{
    _choiceStatus = ChoiceImageWithContent;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.sourceType = sourceType;
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
        [self presentViewController:pickerImage animated:YES completion:^{
        }];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

-(void)contentPicHandleWithImage:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image,1.0);
    NSData *imagehandleData = [NSData data];
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    if (sizeOriginKB <= 200.0) {
        imagehandleData = imageData;
    }else{
        NSData *data = [NSData reSizeImageData:image maxImageSize:800 maxSizeWithKB:200];
        imagehandleData = data;
    }
    [UploadUtils upLoadMultimediaWithData:imagehandleData success:^(NSString *mediaStr) {
        dispatch_async(dispatch_get_main_queue(), ^(){//回到主线程
            NSString *url = [NSString stringWithFormat:@"%@%@",BaseImgUrl,mediaStr];
            NSString *script = [NSString stringWithFormat:@"window.insertImage('%@')", url];
            [self.webView stringByEvaluatingJavaScriptFromString:script];
        });
    } fail:^(NSString *errStr) {
        [MQToast showToast:@"图片上传失败,请重试" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
    } progress:^(NSString *progressStr) {
        //
    }];
}

#pragma mark - extendPictureDelegate 选中图片放大
- (void)extendPictureWithTag:(NSInteger)tag{
    ScanPictureViewController *picture = [[ScanPictureViewController alloc]initWithPhotosUrl:nil WithCurrentIndex:tag];
    picture.photos = _sourceArray;
    [self presentViewController:picture animated:YES completion:^{
        
    }];
}

/**
 * 添加输入标题输入框
 */
- (void)setupTextField{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, self.view.width - 50, 50)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"添加标题";
    textField.font = CUSNEwFONT(18);
    [self.view addSubview:textField];
    [textField addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField = textField;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    leftView.backgroundColor = [UIColor whiteColor];
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *textFieldBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.textField.height, self.view.width, 1)];
    textFieldBottomLine.backgroundColor = [UIColor colorFromHex:0xE6E6E6];
    [self.textField addSubview:textFieldBottomLine];
    self.textFieldBottomLine = textFieldBottomLine;
    
    _rightTitleCountLable = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenWidth - 50, 64, 50, 50)];
    _rightTitleCountLable.textColor = [UIColor colorFromHex:0x666666];
    _rightTitleCountLable.text = @"30";
    _rightTitleCountLable.font = CUSNEwFONT(18);
    _rightTitleCountLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_rightTitleCountLable];
}

-(void)textFieldValueChange:(UITextField *)textFiled{
    bool isChinese;
    if ([[[UIApplication sharedApplication]textInputMode].primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = false;
    }else{
        isChinese = true;
    }
    //要求输入最多40位字符
    NSString *str = [textFiled.text stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [textFiled markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textFiled positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            NSLog(@"输入的是汉字");
            if ( str.length>=30) {
                NSString *strNew = [NSString stringWithString:str];
                [textFiled setText:[strNew substringToIndex:30]];
                _rightTitleCountLable.text = @"0";
            }else{
                _rightTitleCountLable.text = [NSString stringWithFormat:@"%ld",30-str.length];
            }
        }else{
            NSLog(@"英文还没有转化为汉字");
        }
    }else{
        if ([str length]>=30) {
            NSString *strNew = [NSString stringWithString:str];
            [textFiled setText:[strNew substringToIndex:30]];
            _rightTitleCountLable.text = @"0";
        }
    }
}

/**
 * 添加工具条
 */
- (void)setupToolbar
{
    DSPublishToolbar *toolbar = [[DSPublishToolbar alloc] init];
    toolbar.btnActionHandle = ^(UIButton *btn) {
        if (btn.tag == 0) {
            return ;
        }
        if (btn.tag == 1) {
            PiazzaPurchasedListController *buyListVC = [[PiazzaPurchasedListController alloc]init];
            buyListVC.hidesBottomBarWhenPushed = true;
            buyListVC.seletcedHandle = ^(PiazzaPurchasedProduct *product) {
                NSString *str = [NSString stringWithFormat:@"%@community/productHtml/",BaseUrl];
                NSString *script = [NSString stringWithFormat:@"insertiframe('%@', '%@')",str, product.productNumber];
                [self.webView stringByEvaluatingJavaScriptFromString:script];
            };
            [self.navigationController pushViewController:buyListVC animated:true];
            return ;
        }
        if (btn.tag == 2) {
            [self addContentPic];
            return ;
        }
    };
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    [self.view bringSubviewToFront:toolbar];
}

/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
//    // 如果正在切换键盘，就不要执行后面的代码
//    if (self.switchingKeybaord) return;
    
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];
}

-(void)configFootScrollView{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.webView.frame.origin.y + self.webView.frame.size.height + FitHeight(10.0), mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
    [self.view addSubview:line];
    
    _footScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, line.frame.origin.y + 0.5 + FitHeight(10.0), mainScreenWidth, FitHeight(320.0))];
    _footScrollView.backgroundColor = [UIColor whiteColor];
    _footCoverImageViewArr = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(10.0) + (FitHeight(320.0) + FitWith(10.0)) * i, 0, FitHeight(320.0), FitHeight(320.0))];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.layer.masksToBounds = true;
        imgV.tag = i;
        imgV.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgVTapAction:)];
        [imgV addGestureRecognizer:tap];
        [_footScrollView addSubview:imgV];
        [_footCoverImageViewArr addObject:imgV];
    }
    [self.view addSubview:_footScrollView];
}

-(void)publishUpload{
    NSString *content = [self printHTML];
    NSString *filterContent = [self filterHTML:content];
    NSString *temp1 = [filterContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (temp1.length == 0) {
        [MQToast showToast:@"请输入笔记的内容" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    NSString *temp = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (temp.length == 0) {
        [MQToast showToast:@"请输入笔记的标题" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    if (_realImgArray.count == 0) {
        [MQToast showToast:@"请添加笔记的封面" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:content forKey:@"content"];
    [params setObject:self.textField.text forKey:@"title"];
    if (_communityId.length > 0) {
        [params setObject:_communityId forKey:@"id"];
    }
    NSMutableArray *imgDataArr = [NSMutableArray array];
    for (int i = 0 ; i < _realImgArray.count; i++) {
        UIImage *img = _realImgArray[i];
        NSData *imageData = UIImageJPEGRepresentation(img,1.0);
        CGFloat sizeOriginKB = imageData.length / 1024.0;
        if (sizeOriginKB <= 200.0) {
            [imgDataArr addObject:imageData];
        }else{
            NSData *data = [NSData reSizeImageData:img maxImageSize:800 maxSizeWithKB:200];
            [imgDataArr addObject:data];
        }
        NSData *firstData = imgDataArr[0];
        UIImage *newImg = [UIImage imageWithData:firstData];
        NSString *sizeStr = [NSString stringWithFormat:@"%ldx%ld",(NSInteger)newImg.size.width,(NSInteger)newImg.size.height];
        [params setObject:sizeStr forKey:@"coverSize"];
    }
    [UploadUtils upLoadMultimediaWithDataArr:imgDataArr success:^(NSArray *mediaStrs) {
        [params setObject:mediaStrs forKey:@"pics"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"community/post" params:params from:self showHud:false loadingText:nil enableUserActions:true success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [MQToast showToast:_communityId.length > 0 ? @"笔记修改成功，请等待审核" : @"笔记发布成功，请等待审核" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                PubishSuccessBlock block = _uploadSuccessHandle;
                if (block) {
                    block();
                }
                [self.navigationController popViewControllerAnimated:true];
            }
        } fail:^(NSError *error) {
            //
        }];
    } fail:^(NSString *errStr) {
        //
    } progress:^(NSString *progressStr) {
        //
    }];
}

@end
