//
//  BillChoiceController.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^BillInfoChoiceBlock)(NSInteger,NSString *,NSString *,NSString *);

@interface BillChoiceController : BaseViewController

@property(nonatomic,copy) BillInfoChoiceBlock choiceHandle;

@property (nonatomic, copy) NSString *invoiceName;
@property (nonatomic, copy) NSString *phoneStr;
@property (nonatomic, copy) NSString *emailStr;

-(instancetype)initWithBillChoiceStyle:(BillChoiceStyle)billStatus;

@end
