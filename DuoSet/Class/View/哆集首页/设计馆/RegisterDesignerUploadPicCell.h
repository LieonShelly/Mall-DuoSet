//
//  RegisterDesignerUploadPicCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImgVTapBlock)(NSInteger);
typedef void(^ImgVDeletedBlock)(NSInteger);

@interface RegisterDesignerUploadPicCell : UITableViewCell

@property(nonatomic,copy) ImgVTapBlock imgVTapHandle;
@property(nonatomic,copy) ImgVDeletedBlock deletedHandle;

@property(nonatomic,strong) UIButton *leftDeletedBtn;
@property(nonatomic,strong) UIButton *rightDeletedBtn;
@property(nonatomic,strong) UIImageView *leftImgV;
@property(nonatomic,strong) UIImageView *rightImgV;

@end
