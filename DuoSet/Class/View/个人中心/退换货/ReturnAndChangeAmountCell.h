//
//  ReturnAndChangeAmountCell.h
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

typedef void(^ChangeProductAmountBlock)(NSInteger);

@interface ReturnAndChangeAmountCell : UITableViewCell

@property(nonatomic,copy) ChangeProductAmountBlock amountChangeHandle;
@property(nonatomic,strong) PPNumberButton *numBtn;

@end
