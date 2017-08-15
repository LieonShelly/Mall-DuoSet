//
//  ThemeProModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/15.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeProModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger soldAmout;
@property (nonatomic, copy) NSString *smallImg;

@end
