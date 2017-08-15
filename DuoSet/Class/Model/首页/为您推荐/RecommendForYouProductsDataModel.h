//
//  RecommendForYouProductsDataModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendForYouProductsDataModel : NSObject

@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger price;
@property (nonatomic, copy) NSString *smallImg;
@property (nonatomic, assign) NSUInteger soldAmout;



@end
