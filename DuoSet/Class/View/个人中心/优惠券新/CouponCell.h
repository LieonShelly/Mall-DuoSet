//
//  CouponCell.h
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouhuiJuanModel.h"

typedef void(^choiceBtnActionBlock)();

@interface CouponCell : UITableViewCell

@property(nonatomic,copy) choiceBtnActionBlock choiceHandle;
-(void)setupInfoWithYouhuiJuanModel:(YouhuiJuanModel *)item;

@end
