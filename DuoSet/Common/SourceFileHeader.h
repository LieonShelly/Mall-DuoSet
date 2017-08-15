
//
//  SourceFileHeader.h
//  DuoSet
//
//  Created by fanfans on 12/26/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#ifndef SourceFileHeader_h
#define SourceFileHeader_h

//基控制器
#import "BaseViewController.h"
//参数配置
#import "DataConfig.h"
#import "Utils.h"
#import "CommonDatas.h"
#import "RequestManager.h"
#import "UploadUtils.h"
#import "TransitionAnimator.h"
#import "CallServiceViewController.h"

#define mainScreenWidth   [UIScreen mainScreen].bounds.size.width
#define mainScreenHeight  [UIScreen mainScreen].bounds.size.height
#define underiOS9 [UIDevice currentDevice].systemVersion.floatValue < 9.0
#define underiOS10 [UIDevice currentDevice].systemVersion.floatValue < 10.0
#define IS_IPHONE5 [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && mainScreenHeight == 568.0

#define FitWith(x) (x/750.0)*mainScreenWidth
#define FitHeight(x) (x/1334.0)*mainScreenHeight
#define CUSFONT(x)  [UIFont systemFontOfSize:x*(CGRectGetWidth([[UIScreen mainScreen] bounds])/320.f)]
//自适应字号
#define CUSNEwFONT(x)  [UIFont systemFontOfSize:x*(CGRectGetWidth([[UIScreen mainScreen] bounds])/414.f)]

#define LinkUrl @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"

#define isDebug 1

#define BaseUrl isDebug ? @"https://test.hlhdj.cn/app/" : @"https://app.hlhdj.cn/"
#define BaseImgUrl isDebug ? @"https://cdn.hlhdj.cn/test/photos/" : @"https://cdn.hlhdj.cn/photos/"
#define UpLoadimgUrl isDebug ? @"test/photos/" : @"photos/"
#define WebBaseUrl @"https://cdn.hlhdj.cn/"
//占位图
#define placeholderImageSize(w,h) [UIImage placeholderImageWithSize:CGSizeMake(w,h)]

#define placeholderImage_372_440 [UIImage imageNamed:@"placeholderImage_372_440.jpg"]
#define placeholderImage_702_420 [UIImage imageNamed:@"placeholderImage_702_420.jpg"]
#define placeholderImage_226_256 [UIImage imageNamed:@"placeholderImage_226_256.jpg"]
#define placeholderImage_avatar  [UIImage imageNamed:@"placeholderImage_avatar"]
//美洽
#import "MQServiceToViewInterface.h"
#import "MQChatViewController.h"
#import "MQToast.h"
//扩展
#import "NSString+Date.h"
#import "NSString+Extension.h"
#import "UIColor+colorFromHex.h"
#import "UIImage+Color.h"
#import "UIImage+Size.h"
#import "PureLayout.h"
#import "SGSegmentedControl.h"
#import "MJRefresh.h"
#import "FFGifHeader.h"
#import "IQKeyboardManager.h"
#import "UITextView+WZB.h"
#import "XHWebImageAutoSize.h"
#import "NSData+Limit.h"

#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIButton+CountDown.h"

#import "UMengStatisticsUtils.h"
#import "ScanPictureViewController.h"
#import "WebPageController.h"
#import "CommonDefeatedView.h"
#import "UIFont+Name.h"

#endif /* SourceFileHeader_h */
