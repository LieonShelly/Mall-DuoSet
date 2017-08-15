//
//  OrderCancelResionView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CancelResionData.h"

typedef void(^CloseBlock)();
typedef void(^AgreeBlock)(NSString *resion);

@interface OrderCancelResionView : UIView

@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UILabel *resiontipsLable;
@property(nonatomic,copy) CloseBlock closeHandle;
@property(nonatomic,copy) AgreeBlock agreeHandle;

-(void)setupInfoWithCancelResionDataArr:(NSMutableArray *)items;

@end
