//
//  MessageListController.h
//  DuoSet
//
//  Created by fanfans on 2017/2/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

@interface MessageListController : UIViewController

-(instancetype)initWithMessageType:(MessageType)type andTypeName:(NSString *)typeName andTypeId:(NSString *)typeId;

@end
