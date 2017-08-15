//
//  StandarCountChoiceCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

typedef void(^ChangeProductAmountBlock)(NSInteger);

@interface StandarCountChoiceCell : UITableViewCell

@property (nonatomic,strong) PPNumberButton *numBtn;
@property (nonatomic,copy) ChangeProductAmountBlock amountChangeHandle;

@end
