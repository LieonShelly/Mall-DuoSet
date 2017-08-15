//
//  AddressChoiceCell.h
//  DuoSet
//
//  Created by fanfans on 2017/2/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellTapBlock)();
@interface AddressChoiceCell : UITableViewCell

@property (nonatomic,strong) UILabel *tipsLable;
@property (nonatomic,strong) UIImageView *arrowImgV;
@property (nonatomic,strong) UITextField *rightSubLable;
@property (nonatomic,strong) CellTapBlock cellTapHandle;

@end
