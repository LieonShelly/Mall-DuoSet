//
//  ScanPictureViewController.h
//  BossApp
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 ZDJY. All rights reserved.
//

#import "BaseViewController.h"
#import "LDJScrollView.h"
#import "LDJImageScrollView.h"

typedef void(^QrScanBlock)(NSString *qrStr);
@interface ScanPictureViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSArray *photosUrl;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) LDJScrollView *scrollView;
@property (nonatomic, assign) BOOL hiddenNumLabel;
@property (nonatomic, copy) QrScanBlock qrScanHandle;

- (instancetype)initWithPhotosUrl:(NSArray *)photoUrl WithCurrentIndex:(NSInteger)index;

@end
