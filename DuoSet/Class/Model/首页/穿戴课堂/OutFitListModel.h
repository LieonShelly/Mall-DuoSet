//
//  OutFitListModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/13.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OutFitListModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *goodNum;
@property (nonatomic, copy) NSString *outFitid;
@property (nonatomic, copy) NSString *url;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
