//
//  SearchData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SearchData.h"

@implementation SearchData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _obj_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.obj_id = [aDecoder decodeObjectForKey:@"obj_id"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.obj_id forKey:@"obj_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
}
@end
