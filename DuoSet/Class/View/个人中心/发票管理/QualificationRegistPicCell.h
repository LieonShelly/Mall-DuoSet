//
//  QualificationRegistPicCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QualificationRegistPicBlock)();
typedef void(^QualificationRegistDeletedBlock)();

@interface QualificationRegistPicCell : UITableViewCell

@property(nonatomic,copy) QualificationRegistPicBlock showbigPicHandle;
@property(nonatomic,copy) QualificationRegistDeletedBlock deletedPicHandle;
@property(nonatomic,strong) UIImageView *picView;
@property(nonatomic,strong) UIButton *deletedBtn;

@end
