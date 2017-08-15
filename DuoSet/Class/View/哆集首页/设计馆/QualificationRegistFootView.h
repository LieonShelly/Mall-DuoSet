//
//  QualificationRegistFootView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QualificationData.h"

typedef void(^CommitBtnAcitonBlock)();

typedef void(^DownImageBlock)();

@interface QualificationRegistFootView : UIView

@property(nonatomic,copy) CommitBtnAcitonBlock commitHandle;
@property(nonatomic,copy) DownImageBlock downHandle;

-(void)setupInfoWithQualificationData:(QualificationData *)item;

@end
