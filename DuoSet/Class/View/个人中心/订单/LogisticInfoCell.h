//
//  LogisticInfoCell.h
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReturnAndChangeDetailData.h"
#import "TraceData.h"

@interface LogisticInfoCell : UITableViewCell

@property (nonatomic,strong) UIView *upLine;
@property (nonatomic,strong) UIView *downLine;

-(void)setupInfoWithReturnAndChangeDetailData:(ReturnAndChangeDetailData *)item;

-(void)setupInfoWithTraceData:(TraceData *)item;

@end
