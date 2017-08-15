//
//  CommentProductCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/4.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentData.h"

typedef void(^CommentImgVTapBlock)(NSInteger index);

@interface CommentProductCell : UITableViewCell

-(void)setupInfoWithCommentData:(CommentData *)item;

@property(nonatomic,copy)CommentImgVTapBlock imgVTapActionHandle;

@end
