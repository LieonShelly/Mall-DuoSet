//
//  WaitCommentAndChangeCell.h
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

#import "ReturnAndChangeData.h"

typedef void(^CellBtnActionsBlock)(NSInteger);

@interface WaitCommentAndChangeCell : UITableViewCell

@property(nonatomic,copy) CellBtnActionsBlock cellBtnActionHandle;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order;
-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item andDuojiOrderProductData:(DuojiOrderProductData *)productInfo;

-(void)setupInfoWithReturnAndChangeData:(ReturnAndChangeData *)item;

@end
