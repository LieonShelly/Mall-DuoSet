//
//  ReturnAndChangeChoiceTypeCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewReturnAndChangeData.h"

typedef void(^CellButtonActionBlock)(NSInteger index);

@interface ReturnAndChangeChoiceTypeCell : UITableViewCell

@property(nonatomic,copy) CellButtonActionBlock btnHandle;

-(void)setupInfoWithNewReturnAndChangeData:(NewReturnAndChangeData *)item;

-(void)setupBtnSeletcedWithIndex:(NSInteger)index;

@end
