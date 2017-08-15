//
//  DesginMainModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/18.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesginMainModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, assign) NSUInteger isBad;
@property (nonatomic, assign) NSUInteger isGood;
@property (nonatomic, assign) NSUInteger publishDate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *imgs;
@end
