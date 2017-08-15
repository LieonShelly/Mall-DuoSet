//
//  DesigningHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/20.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerData.h"

typedef enum : NSUInteger {
    DesignerStatusNoUpload = -1,
    DesignerStatusChecking = 0,
    DesignerStatusCheckSucceed = 1,
    DesignerStatusCheckNoPass = 2,
} DesignerStatus;

typedef void(^DesignerBtnActionBlock)(NSInteger);
typedef void(^DesignerTopBtnBlock)(NSInteger);
typedef void(^DesignerChoiceBlock)(NSInteger);
typedef void(^AttentionBtnActionBlock)(UIButton *);

@interface DesigningHeaderView : UIView

@property(nonatomic,copy) DesignerBtnActionBlock designerHandle;
@property(nonatomic,copy) DesignerTopBtnBlock topHandle;
@property(nonatomic,copy) DesignerChoiceBlock designerChoiceHandle;
@property(nonatomic,copy) AttentionBtnActionBlock attentionBtnActionHandle;

-(void)setupInfoWithDesignerDataArr:(NSMutableArray *)items;
-(void)setupInfoWithDesignerStatus:(DesignerStatus)designerType andDesignerData:(DesignerData *)item;

@end
