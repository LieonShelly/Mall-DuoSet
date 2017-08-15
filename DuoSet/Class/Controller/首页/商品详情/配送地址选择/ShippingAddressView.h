//
//  ShippingAddressView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SeletcedBlock)(NSString *address);
typedef void(^CloseBlock)();

@interface ShippingAddressView : UIView

@property(nonatomic,copy) SeletcedBlock seletcedHandle;
@property(nonatomic,copy) CloseBlock closeHandle;

-(instancetype)initWithFrame:(CGRect)frame includeAddressAddressModel:(BOOL)includeAddressAddressModel;
-(void)setupInfoWithAddressModelInfoDataArr:(NSMutableArray *)items;

@end
