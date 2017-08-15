//
//  ScanPictureViewController.m
//  BossApp
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 ZDJY. All rights reserved.
//

#import "ScanPictureViewController.h"
//#import "CircleNewFileViewController.h"
//#import "PersonDataViewController.h"
//#import "ScanResultViewController.h"
//#import "BSScanResultController.h"

@interface ScanPictureViewController ()

@end

@implementation ScanPictureViewController

- (instancetype)initWithPhotosUrl:(NSArray *)photoUrl WithCurrentIndex:(NSInteger)index{
    _photosUrl = photoUrl;
    _currentIndex = index;
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navView.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(indexChange:) name:@"INDEX_CHANGED" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"DIS_MISS" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longPress:) name:@"Long_Press" object:nil];
    if (_photos.count > 0) {
        [self configImageUI];
    }else{
        [self configUI];
    }
}

- (void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    _scrollView = [[LDJScrollView alloc]initWithFrame:CGRectMake(-30, 0, mainScreenWidth + 30, mainScreenHeight)];
    _scrollView.currentIndex = _currentIndex;
    _scrollView.imageUrlArray = [[NSMutableArray alloc]initWithArray:_photosUrl];
    if (_photosUrl.count < 2) {
        _scrollView.scrollEnabled = NO;
    }
    [_scrollView initializeUserInterface];
    [self.view addSubview:_scrollView];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenWidth*0.5, mainScreenHeight - 50, mainScreenWidth/2 - 20, 20)];
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.textAlignment = NSTextAlignmentRight;
    if (_photosUrl.count > 0) {
        _numLabel.text = [NSString stringWithFormat:@"%ld/%ld", _currentIndex, _photosUrl.count];
    }
    _numLabel.font = CUSFONT(13);
    if (_hiddenNumLabel == YES) {
        _numLabel.hidden = YES;
    }
//    [self.view addSubview:_numLabel];
}


- (void)configImageUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    _scrollView = [[LDJScrollView alloc]initWithFrame:CGRectMake(-30, 0, mainScreenWidth + 30, mainScreenHeight)];
    _scrollView.currentIndex = _currentIndex;
    _scrollView.imageArray = [[NSMutableArray alloc]initWithArray:_photos];
    if (_photos.count < 2) {
        _scrollView.scrollEnabled = NO;
    }
    [_scrollView initializeUserInterface];
    [self.view addSubview:_scrollView];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenWidth*0.5, mainScreenHeight - 50, mainScreenWidth/2 - 20, 20)];
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.textAlignment = NSTextAlignmentRight;
    if (_photosUrl.count > 0) {
        _numLabel.text = [NSString stringWithFormat:@"%ld/%ld", _currentIndex, _photos.count];
    }
    _numLabel.font = CUSFONT(13);
    if (_hiddenNumLabel == YES) {
        _numLabel.hidden = YES;
    }
}



- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)indexChange:(NSNotification *)notifi{
    NSDictionary *dic = notifi.userInfo;
    if ([dic objectForKey:@"index"]) {
        NSInteger index = [[dic objectForKey:@"index"] integerValue];
        _currentIndex = index + 1;
    }
    if (_photos.count > 0){
        _numLabel.text = [NSString stringWithFormat:@"%ld/%ld", _currentIndex, _photos.count];
    }else{
        _numLabel.text = [NSString stringWithFormat:@"%ld/%ld", _currentIndex, _photosUrl.count];
    }
}

-(void)longPress:(NSNotification *)notifi{
    NSDictionary *dic = notifi.userInfo;
    if ([dic objectForKey:@"img"]) {
        UIImage *img = [dic objectForKey:@"img"];
        CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:img.CGImage]];
        if (features.count >=1) {
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            if (scannedResult) {
                NSString *contents = scannedResult;
                [self addImgToLibsAndShowQrCode:true andQrString:contents andImg:img];
            }
        }
        else{
            [self addImgToLibsAndShowQrCode:false andQrString:@"" andImg:img];
        }
    }
}

-(void)addImgToLibsAndShowQrCode:(BOOL)show andQrString:(NSString *)qrStr andImg:(UIImage *)img{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:cancel];
    
    UIAlertAction *addImg = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self tapSaveImageToIphoneWithImg:img];
    }];
    [actionSheet addAction:addImg];
    if (show) {
        UIAlertAction *scanQr = [UIAlertAction actionWithTitle:@"识别图中二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self scanQrCode:qrStr];
        }];
        [actionSheet addAction:scanQr];
    }
    [self presentViewController:actionSheet animated:true completion:nil];
}

- (void)tapSaveImageToIphoneWithImg:(UIImage *)img{
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if (error == nil) {
//        [Utils showPointInfoWithStr:@"已存入手机相册"];
//    }else{
//        [Utils showPointInfoWithStr:@"保存失败"];
//    }
}

-(void)scanQrCode:(NSString *)qrStr{
    [self dismissViewControllerAnimated:YES completion:^{
        if (qrStr.length>0) {
            QrScanBlock block = _qrScanHandle;
            if (block) {
                block(qrStr);
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
