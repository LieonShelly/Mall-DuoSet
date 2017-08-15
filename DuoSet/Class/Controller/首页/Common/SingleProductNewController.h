//
//  SingleProductNewController.h
//  DuoSet
//
//  Created by fanfans on 2017/4/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleProductNewController : UIViewController

-(instancetype)initWithProductId:(NSString *)productNum;

-(instancetype)initWithProductId:(NSString *)productNum andCover:(NSString *)cover productTitle:(NSString *)productTitle productPrice:(NSString *)productPrice;

@end
