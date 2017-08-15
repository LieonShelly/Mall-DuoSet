//
//  AddressEditCell.h
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditCellActionBlock)(UIButton *);

@interface AddressEditCell : UITableViewCell

@property (nonatomic,strong) UIButton *defaultbtn;
@property (nonatomic,copy) EditCellActionBlock editBtnHandle;

@end
