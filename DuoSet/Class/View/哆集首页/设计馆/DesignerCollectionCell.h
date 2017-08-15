//
//  DesignerCollectionCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerData.h"

typedef void(^DesignerLikeBlock)(UIButton *);

@interface DesignerCollectionCell : UICollectionViewCell

-(void)setupInfoWithDesignerData:(DesignerData *)item;

@property(nonatomic,strong) UIButton *likeBtn;

@property(nonatomic,copy) DesignerLikeBlock likeHandle;

@end
