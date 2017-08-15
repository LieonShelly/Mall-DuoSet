//
//  FeedbackUploadController.h
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    FeedbackWithSuggestForSys,
    FeedbackWithErrorWithApp,
    FeedbackWithErrorWithOrder
} FeedbackType;

@interface FeedbackUploadController : BaseViewController

-(instancetype)initWithFeedbackType:(FeedbackType)type andTitleName:(NSString *)titleName;

@end
