//
//  NewProductCommentController.h
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CommentSucceedBlock)();

@interface NewProductCommentController : UIViewController

@property(nonatomic,copy) CommentSucceedBlock commentedHanld;
-(instancetype)initWithDetailId:(NSString *)detailId;

@end
