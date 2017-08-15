//
//  YouHuiJuanViewController.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/7.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TickSeletedBlock)(id);

@interface YouHuiJuanViewController : UIViewController

@property(nonatomic,copy)TickSeletedBlock seletedHandle;

@end
