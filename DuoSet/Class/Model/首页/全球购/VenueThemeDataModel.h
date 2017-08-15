//
//  VenueThemeDataModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/16.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VenueThemeDataModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, assign) NSUInteger prePrice;
@property (nonatomic, assign) NSUInteger price;
@property (nonatomic, copy) NSString *smallImg;

@end
