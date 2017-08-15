//
//  BillNeedChoiceCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BillNeedChoiceBlock)(UIButton *);

@interface BillNeedChoiceCell : UITableViewCell

@property(nonatomic,copy) BillNeedChoiceBlock choiceHanlde;

-(void)setUpBtnSeletcedWithBillChoiceStyle:(BillChoiceStyle)billStatus;

@end
