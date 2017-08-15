//
//  PiazzaContentItemCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaItemData.h"

typedef void(^AllowButtonActionBlock)(UIButton *btn);
typedef void(^ImgLoadEndBlock)();

@interface PiazzaContentItemCell : UICollectionViewCell

-(void)setupInfoWithPiazzaItemData:(PiazzaItemData *)item imgVloadEndHandle:(void (^)())imgVloadEndHandle;

-(void)setupInfoWithPiazzaItemData:(PiazzaItemData *)item imgVloadEndHandleBackImgHight:(void (^)(CGFloat imgHight))imgVloadEndHandleBackImgHight;

-(void)setupInfoCollectWithPiazzaItemData:(PiazzaItemData *)item;


@property (nonatomic,strong) UIImageView *cover;
@property(nonatomic,copy) AllowButtonActionBlock allowHandle;
@property(nonatomic,copy) ImgLoadEndBlock imageEndHandle;

@end
