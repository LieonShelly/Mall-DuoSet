//
//  AttentionProductCell.h
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListData.h"

typedef void(^BtnActionBlock)(UIButton *);

@interface AttentionProductCell : UITableViewCell

@property(nonatomic,copy) BtnActionBlock btnActionHandle;

-(void)setupInfoWithProductListData:(ProductListData *)item;

@end
