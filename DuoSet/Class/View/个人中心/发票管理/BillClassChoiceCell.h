//
//  BillClassChoiceCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BillChoiceClassBlock)(NSInteger);

@interface BillClassChoiceCell : UITableViewCell

@property(nonatomic,copy) BillChoiceClassBlock choiceHandle;

@property(nonatomic,strong) UIButton *paperBillBtn;
@property(nonatomic,strong) UIButton *electronBillBtn;
@property(nonatomic,strong) UIButton *moreBillBtn;

-(void)setUpBtnSeletcedWithBillChoiceStyle:(BillChoiceStyle)billStatus;

@end
