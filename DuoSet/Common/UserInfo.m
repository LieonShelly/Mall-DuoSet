//
//  UserInfo.m
//  BossApp
//
//  Created by fanfans on 5/12/16.
//  Copyright © 2016 ZDJY. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic valueForKey:@"avastar"]) {
            _avatar = [NSString stringWithFormat:@"%@",[dic valueForKey:@"avastar"]];
        }
        if ([dic valueForKey:@"id"]) {
            _userId = [NSString stringWithFormat:@"%@",[dic valueForKey:@"id"]];
        }
        if ([dic valueForKey:@"nickName"]) {
            _name = [dic valueForKey:@"nickName"];
        }
        if ([dic valueForKey:@"phone"]) {
            _phone = [dic valueForKey:@"phone"];
        }
    }
    return self;
}

+(instancetype)dataForDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.refreshToken = [aDecoder decodeObjectForKey:@"refreshToken"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.uuid = [aDecoder decodeObjectForKey:@"uuid"];
        self.refreshTokenDate = [aDecoder decodeObjectForKey:@"refreshTokenDate"];
        self.expiresIn = [aDecoder decodeObjectForKey:@"expiresIn"];
        self.currentProvince = [aDecoder decodeObjectForKey:@"currentProvince"];
        self.currentCity = [aDecoder decodeObjectForKey:@"currentCity"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.refreshToken forKey:@"refreshToken"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.uuid forKey:@"uuid"];
    [aCoder encodeObject:self.refreshTokenDate forKey:@"refreshTokenDate"];
    [aCoder encodeObject:self.expiresIn forKey:@"expiresIn"];
    [aCoder encodeObject:self.currentProvince forKey:@"currentProvince"];
    [aCoder encodeObject:self.currentCity forKey:@"currentCity"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
}


@end
