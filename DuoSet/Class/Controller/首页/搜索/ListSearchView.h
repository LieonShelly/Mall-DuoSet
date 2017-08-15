//
//  ListSearchView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/25.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchData.h"

typedef void(^CloseBtnActionBlock)();
typedef void(^ChoiceSearchDataBlock)(SearchData *);
typedef void(^NoResultBlock)(NSString *);

@interface ListSearchView : UIView

@property(nonatomic,copy)CloseBtnActionBlock closeHanld;
@property(nonatomic,copy)ChoiceSearchDataBlock choiceHanld;
@property(nonatomic,copy)NoResultBlock noResultHanld;

@end
