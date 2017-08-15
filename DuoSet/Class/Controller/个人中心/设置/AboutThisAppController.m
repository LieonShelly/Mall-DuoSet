//
//  AboutThisAppController.m
//  DuoSet
//
//  Created by fanfans on 2017/2/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AboutThisAppController.h"
#import "ShareView.h"
#import "TopNewVersion.h"

@interface AboutThisAppController ()

@property(nonatomic,strong) UIView *shareMarkView;
@property(nonatomic,strong) ShareView *shareView;

@end

@implementation AboutThisAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于哆集";
    [self configUI];
}

-(void)configUI{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"nav_black_share"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarItemAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    
    UIImageView *iconImgV = [[UIImageView alloc]initWithFrame:CGRectMake((mainScreenWidth - FitWith(380)) * 0.5 , 64 + FitHeight(100), FitWith(380), FitHeight(200.0))];
    iconImgV.image = [UIImage imageNamed:@"duoji_icon"];
    [self.view addSubview:iconImgV];
    
    UIImageView *qrcodeImgV = [[UIImageView alloc]initWithFrame:CGRectMake((mainScreenWidth - FitWith(250.0)) * 0.5, iconImgV.frame.origin.y + iconImgV.frame.size.height + FitHeight(80), FitWith(250.0), FitWith(250.0))];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSString *url = [NSString stringWithFormat:@"%@download/index",BaseUrl];
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:data forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(CGSizeMake(FitWith(450), FitWith(450)));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    qrcodeImgV.image = codeImage;
    [self.view addSubview:qrcodeImgV];
    
    UILabel *tipsLbale = [[UILabel alloc]initWithFrame:CGRectMake(0, qrcodeImgV.frame.origin.y + qrcodeImgV.frame.size.height + FitHeight(20.0), mainScreenWidth, 40)];
    tipsLbale.text = @"扫描二维码，您的朋友也可以下载哆集客户端";
    tipsLbale.textAlignment = NSTextAlignmentCenter;
    tipsLbale.textColor = [UIColor colorFromHex:0x333333];
    tipsLbale.font = CUSFONT(12);
    [self.view addSubview:tipsLbale];
    
    UIView *footBgView = [[UIView alloc]initWithFrame:CGRectMake(0, tipsLbale.frame.origin.y + tipsLbale.frame.size.height + FitHeight(100.0), mainScreenWidth, FitHeight(110.0))];
    footBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footBgView];
    
    UILabel *checkVersionLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(30.0), 0, FitWith(200.0), footBgView.frame.size.height)];
    checkVersionLable.text = @"当前版本";
    checkVersionLable.textAlignment = NSTextAlignmentLeft;
    checkVersionLable.font = CUSFONT(14);
    checkVersionLable.textColor = [UIColor colorFromHex:0x333333];
    [footBgView addSubview:checkVersionLable];
    
//        UIImageView *arrowImgV = [[UIImageView alloc]initWithFrame:CGRectMake(mainScreenWidth - footBgView.frame.size.height , 0, footBgView.frame.size.height, footBgView.frame.size.height)];
//        arrowImgV.image = [UIImage imageNamed:@"right_arrow"];
//        arrowImgV.contentMode = UIViewContentModeCenter;
//        [footBgView addSubview:arrowImgV];

    UILabel *versionLable = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(80.0) - FitWith(300.0) , 0, FitWith(300.0), footBgView.frame.size.height)];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    versionLable.text = [NSString stringWithFormat:@"For iPhone V%@",app_Version];
    versionLable.textColor = [UIColor colorFromHex:0x666666];
    versionLable.font = CUSFONT(12);
    versionLable.textAlignment = NSTextAlignmentRight;
    [footBgView addSubview:versionLable];
    
//        footBgView.userInteractionEnabled = true;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkVerisonHandle)];
//        [footBgView addGestureRecognizer:tap];
    
    UILabel *copyrightLable = [[UILabel alloc]initWithFrame:CGRectMake(0, isDebug ? mainScreenHeight - FitHeight(130.0) :mainScreenHeight - FitHeight(230.0) , mainScreenWidth, FitHeight(50.0))];
    copyrightLable.textColor = [UIColor colorFromHex:0x808080];
    copyrightLable.font = CUSFONT(12);
    copyrightLable.textAlignment = NSTextAlignmentCenter;
    copyrightLable.text = @"Copyright © 2016";
    [self.view addSubview:copyrightLable];
    
    UILabel *companyLable = [[UILabel alloc]initWithFrame:CGRectMake(0,copyrightLable.frame.origin.y + copyrightLable.frame.size.height, mainScreenWidth, FitHeight(50.0))];
    companyLable.textColor = [UIColor colorFromHex:0x808080];
    companyLable.font = CUSFONT(12);
    companyLable.textAlignment = NSTextAlignmentCenter;
    companyLable.text = @"成都欢乐汇电子商务有限公司";
    [self.view addSubview:companyLable];
}

#pragma mark - 分享
-(void)rightBarItemAction{//share
    if ( _shareMarkView != nil) {
        _shareMarkView.hidden = false;
        [self.view bringSubviewToFront:_shareMarkView];
    }else{
        _shareMarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
        _shareMarkView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.45];
        [[UIApplication sharedApplication].keyWindow addSubview:_shareMarkView];
        
        _shareMarkView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenShareMarkView)];
        [_shareMarkView addGestureRecognizer:tap];
    }
    
    if (_shareView != nil) {
        _shareView.hidden = false;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _shareView.frame;
            frame.origin.y -= FitHeight(600.0);
            _shareView.frame = frame;
        }];
    }else{
        _shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(600.0))];
        __weak typeof(self) weakSelf = self;
        _shareView.cancelHandle = ^(){
            [weakSelf hiddenShareMarkView];
        };
        _shareView.shareHandle = ^(NSInteger index){
            [weakSelf shareCotentWithIndex:index];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_shareView];
        UITapGestureRecognizer *singinVieTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareViewTap)];
        [_shareView addGestureRecognizer:singinVieTap];
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _shareView.frame;
            frame.origin.y -= FitHeight(600.0);
            _shareView.frame = frame;
        }];
    }
}

-(void)hiddenShareMarkView{
    _shareMarkView.hidden = true;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _shareView.frame;
        frame.origin.y = mainScreenHeight;
        _shareView.frame = frame;
    }];
}

-(void)shareViewTap{
    
}

-(void)shareCotentWithIndex:(NSInteger)index{
    NSArray *imgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"share_icon"], nil];
    NSString *url = [NSString stringWithFormat:@"%@download/index",BaseUrl];
    if (index == 5) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = url;
        [self.view makeToast:@"已复制到剪贴板,快去分享给您的朋友吧"];
        return;
    }
    NSString *title =@"哆集APP";
    NSString *contenText = @"哆集主要经营网上国际贸易代理，网上销售日用品，化妆品，服装鞋帽，主要针对女性服务的一个电子商务平台";
    SSDKPlatformType PlatformType  = SSDKPlatformSubTypeWechatSession;
    if (index == 0) {
        PlatformType = SSDKPlatformSubTypeWechatSession;
    }
    if (index == 1) {
        PlatformType = SSDKPlatformSubTypeWechatTimeline;
    }
    if (index == 2) {
        PlatformType = SSDKPlatformTypeSinaWeibo;
    }
    if (index == 3) {
        PlatformType = SSDKPlatformSubTypeQQFriend;
    }
    if (index == 4) {
        PlatformType = SSDKPlatformSubTypeQZone;
    }
    if (PlatformType == SSDKPlatformTypeSinaWeibo) {
        contenText = [NSString stringWithFormat:@"%@\n%@",title,url];
    }
    [Utils sharePlateType:PlatformType ImageArray:imgArr contentText:contenText shareURL:url shareTitle:title andViewController:self success:^(SSDKPlatformType plateType) {
        //
    }];
}

-(void)checkVerisonHandle{
    [self checkAppVersion];
}

-(void)checkAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *urlStr = [NSString stringWithFormat:@"homepage/app-version?deviceType=ios&currentVersion=%@",app_Version];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if ([responseDic objectForKey:@"object"] &&[[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]] ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"status"]) {
                    NSString *statusStr = [objDic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[objDic objectForKey:@"status"]] : @"0";
                    if (statusStr.integerValue == 1) {
                        if ([objDic objectForKey:@"topNewVersion"] &&[[objDic objectForKey:@"topNewVersion"] isKindOfClass:[NSDictionary class]] ) {
                            NSDictionary *versionDic = [objDic objectForKey:@"topNewVersion"];
                            TopNewVersion *versionData = [TopNewVersion dataForDictionary:versionDic];
                            [self handleVersionWithTopNewVersionData:versionData];
                        }
                    }else{
                        [self.view makeToast:@"当前已经是最新版本，谢谢您的支持!"];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 版本更新检查
-(void)handleVersionWithTopNewVersionData:(TopNewVersion *)versionData{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本" message:versionData.appExplain preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *update = [UIAlertAction actionWithTitle:@"马上更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"https://itunes.apple.com/app/id1216153232"]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/app/id1216153232"]];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:update];
    if (!versionData.forcedUpdating) {
        [alertController addAction:cancel];
    }
    [self presentViewController:alertController animated:true completion:nil];
}


@end
