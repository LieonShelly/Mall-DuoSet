//
//  HistoryModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/20.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject
@property (nonatomic, assign) NSUInteger createDate;
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, assign) NSUInteger productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, assign) NSUInteger productPrice;
@property (nonatomic, copy) NSString *productSmallImg;
@end
