//
//  ItemCountModifyView.h
//  DuoSet
//
//  Created by fanfans on 2017/4/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCountModifyView : UIView

-(instancetype)initWithFrame:(CGRect)frame andMinusHandle:(void (^)(NSInteger minus))minusHandle andPlusHandle:(void (^)(NSInteger plus))plusHandle resultHandle:(void (^)(NSInteger result))resultHandle;

-(void)setupInfoWithCurrentCount:(NSString *)current andMaxCount:(NSString *)maxCount;

-(void)setupInfoWithCurrentCount:(NSString *)current;

@property (nonatomic,strong) UITextField *countTextField;

@end
