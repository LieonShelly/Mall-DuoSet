//
//  OrderSureGlobalInputCell.h
//  DuoSet
//
//  Created by fanfans on 2017/6/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IdentityInfoSaveBlock)(NSString *realName,NSString *identityCard,UIButton *btn);
typedef void(^IdentityInfoChangeBlock)(NSString *realName,NSString *identityCard);

typedef void(^EditSaveBlock)(UIButton *btn);

@interface OrderSureGlobalInputCell : UITableViewCell

@property(nonatomic,copy) IdentityInfoSaveBlock saveHandle;
@property(nonatomic,copy) EditSaveBlock editHandle;
@property(nonatomic,copy) IdentityInfoChangeBlock changeHandle;
@property (nonatomic,strong) UITextField *nameInputTextFiled;
@property (nonatomic,strong) UITextField *numInputTextFiled;

-(void)setupRealName:(NSString *)realName AndIdentityCard:(NSString *)identityCard andIsEdit:(BOOL)isEdit;

@end
