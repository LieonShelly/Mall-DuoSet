//
//  BillNameChoiceCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BillNameChoiceBlock)(NSInteger);

@interface BillNameChoiceCell : UITableViewCell

@property(nonatomic,copy) BillNameChoiceBlock nameChoiceHandle;

-(void)setUpBtnSeletcedWithBillChoiceStyle:(BillChoiceStyle)billStatus;

@end
