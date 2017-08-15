//
//  ChoicenessProductsCell.h
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChoicenessProductsCellBlock)(NSInteger);

@interface ChoicenessProductsCell : UITableViewCell

@property(nonatomic,copy) ChoicenessProductsCellBlock cellHandle;

@end
