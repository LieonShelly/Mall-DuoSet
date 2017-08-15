//
//  modifiPassWordController.h
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifiPassWordController : BaseViewController

-(instancetype)initWithTitleName:(NSString *)titleName;

@property(nonatomic,copy) NSString *phoneStr;
@property(nonatomic,assign) BOOL isFromBindingAccount;

@end
