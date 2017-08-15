//
//  CommentDetailsCell.h
//  DuoSet
//
//  Created by fanfans on 2017/4/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentDetailsData.h"

typedef void(^CommentTapBlock)(NSInteger index);

typedef void(^ImageShowBlock)(CommentDetailsData *item);

@interface CommentDetailsCell : UITableViewCell

@property(nonatomic,copy) CommentTapBlock tapHandle;
@property(nonatomic,copy) ImageShowBlock imgHandle;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier commentData:(CommentDetailsData *)item;

//-(void)setupInfoWithCommentDetailsData:(CommentDetailsData *)item;

@end
