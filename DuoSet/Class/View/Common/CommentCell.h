//
//  CommentCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentData.h"

typedef void(^CommentlikeBtnActionBlock)(UIButton *);
typedef void(^CommentImgVTapBlock)(NSInteger);

@interface CommentCell : UITableViewCell

-(void)setupInfoWithCommentData:(CommentData *)item;

@property(nonatomic,copy)CommentlikeBtnActionBlock lickBtnActionHandle;
@property(nonatomic,copy)CommentImgVTapBlock imgVTapActionHandle;

@end
