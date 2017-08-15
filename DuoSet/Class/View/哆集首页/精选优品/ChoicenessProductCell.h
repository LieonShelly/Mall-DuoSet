//
//  ChoicenessProductCell.h
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChoicenessProductBlock)(NSInteger);

@interface ChoicenessProductCell : UITableViewCell

@property(nonatomic,copy) ChoicenessProductBlock productHandle;


@end
