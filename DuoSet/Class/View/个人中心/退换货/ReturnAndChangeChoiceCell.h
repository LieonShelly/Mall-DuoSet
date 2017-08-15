//
//  ReturnAndChangeChoiceCell.h
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderProductData.h"

typedef void(^CellChoiceBtnActionBlock)(NSInteger);

@interface ReturnAndChangeChoiceCell : UITableViewCell

@property(nonatomic,copy) CellChoiceBtnActionBlock choiceHandle;

-(void)setBtnShowWithDuojiOrderProductData:(DuojiOrderProductData *)product;

@end
