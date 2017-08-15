//
//  SigninHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/2/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSignData.h"

typedef void(^SigninButtonActionBlock)(UIButton *);

@interface SigninHeaderView : UIView

@property(nonatomic,copy) SigninButtonActionBlock signinHandle;

-(void)setupinfoWithUserSignData:(UserSignData *)item;

@end
