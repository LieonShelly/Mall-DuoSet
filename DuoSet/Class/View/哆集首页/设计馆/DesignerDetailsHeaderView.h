//
//  DesignerDetailsHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerData.h"

typedef void(^LikeBtnActionBlock)(UIButton *);

@interface DesignerDetailsHeaderView : UIView

@property(nonatomic,copy) LikeBtnActionBlock likehandle;

-(void)setupInfoWithDesignerData:(DesignerData *)item;

@end
