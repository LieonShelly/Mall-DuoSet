//
//  PiazzaDetailsCollectionViewCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaItemData.h"

typedef void(^ReSetCollectionViewSizeBlock)(CGSize size);
typedef void(^PiazzaDetailsCollectionViewCellBlock)(NSInteger index);
typedef void(^PiazzaDetailsCollectionViewCellLikeBlock)(UIButton *btn,NSIndexPath *indexPath);


@interface PiazzaDetailsCollectionViewCell : UITableViewCell

@property(nonatomic,copy) ReSetCollectionViewSizeBlock sizeBlock;
@property(nonatomic,copy) PiazzaDetailsCollectionViewCellBlock cellBlock;
@property(nonatomic,copy) PiazzaDetailsCollectionViewCellLikeBlock cellLikeBlock;

-(void)setupInfoWithPiazzaItemDataArr:(NSMutableArray *)dataArr;

@end
