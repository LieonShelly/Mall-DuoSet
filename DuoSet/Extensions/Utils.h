//
//  Utils.h
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import <ShareSDK/ShareSDK.h>
#import "SearchData.h"
#import <CoreLocation/CoreLocation.h>


@interface Utils : NSObject

+(void)setUserInfo:(UserInfo *)userinfo;

+(UserInfo *)getUserInfo;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+(NSString *)jonStrWithDictionary:(NSMutableDictionary *)dic;

+(NSString *)arrayToJSONString:(NSArray *)array;

+(CGSize)getImageSizeWithURLStr:(id)imageURL;

+(CGSize)getImageSizeWithURLString:(NSString *)imageUrlStr;

+ (UIImage*)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

+(NSString *)getUUID;

+(NSString *)getDeviceOs;

+ (void)setDeviceOs:(NSString *)deviceOs;

+(NSString *)getIphoneType;

+(NSString *)md5:(NSString *)input;

+(NSString *)genRandomStringLenth:(NSInteger)length;

+(NSString *)getCacheSize;

+(void)clearFile;

+(BOOL)isIncludeSpecialCharact: (NSString *)str;

+ (void)sharePlateType:(SSDKPlatformType)plateType ImageArray:(NSArray *)imgArray contentText:(NSString *)content shareURL:(NSString *)url shareTitle:(NSString *)title andViewController:(UIViewController *)controller success:(void(^)(SSDKPlatformType plateType))success;


//+(void)setSearchHistoryWithSearchData:(SearchData *)item;

+(NSArray *)getSearchAllHistory;

+(void)removeAllHistory;

+(BOOL)IsEmailAdress:(NSString *)Email;

/** 校验身份证*/
+(BOOL)IsIdentityCard:(NSString *)IDCardNumber;

+ (CLLocationCoordinate2D)GCJ02FromBD09:(CLLocationCoordinate2D)coor;
+ (CLLocationCoordinate2D)BD09FromGCJ02:(CLLocationCoordinate2D)coor;

@end
