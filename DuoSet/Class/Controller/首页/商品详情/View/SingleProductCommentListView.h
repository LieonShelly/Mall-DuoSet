//
//  SingleProductCommentListView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//  商品详情评论列表

#import <UIKit/UIKit.h>
#import "CommentListHeaderView.h"
#import "CommentData.h"

typedef void(^CommentHeaderBtnActionBlock)(NSInteger index);
typedef void(^ImageViewTapBlock)(CommentData *item,NSInteger index);
typedef void(^LikeButtonActionBlock)(NSIndexPath *indexPath,CommentData *item,UIButton *btn);

@interface SingleProductCommentListView : UIView

@property(nonatomic,strong) CommentListHeaderView *headerView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) CommentHeaderBtnActionBlock headerBtnHandle;
@property(nonatomic,copy) ImageViewTapBlock imgVTapHandle;
@property(nonatomic,copy) LikeButtonActionBlock likeBtnHandle;

-(instancetype)initWithFrame:(CGRect)frame AndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock;

-(void)setupInfoWithCommentArr:(NSMutableArray *)commentArr;

@end
