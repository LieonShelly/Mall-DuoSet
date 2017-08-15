//
//  RequestManager.h
//  DuoSet
//
//  Created by fanfans on 2017/2/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

+ (void)requestWithMethod:(NetRequestWay)way  WithUrlPath:(NSString *)urlPath params:(NSDictionary *)params from:(UIViewController *)controller showHud:(BOOL)showHud loadingText:(NSString *)loadingText enableUserActions:(BOOL)enableUserActions success:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail;


+(void)showAlertFrom:(UIViewController *)controller title:(NSString *)title mesaage:(NSString *)msg doneActionTitle:(NSString *)done handle:(void (^)())handle;

+(void)showAlertFrom:(UIViewController *)controller title:(NSString *)title mesaage:(NSString *)msg success:(void (^)())success;

+(void)showHud:(BOOL)show showString:(NSString *)text enableUserActions:(BOOL)enableUserActions withViewController:(UIViewController *)controller;

+(void)refershTokenSuccess:(void (^)())successHandle;

@end
