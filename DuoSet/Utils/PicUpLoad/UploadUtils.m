//
//  UploadUtils.m
//  DuoSet
//
//  Created by fanfans on 2017/2/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UploadUtils.h"
#import "UpYunFormUploader.h"
#import "UPYUNConfig.h"
#import "UpYun.h"

@implementation UploadUtils

+(void)upLoadMultimediaWithData:(NSData *)sourceData uploadReturnStr:(void (^)(NSString *uploadSuccessStr))uploadReturnStr success:(void (^)(NSString *mediaStr))success fail:(void (^)(NSString *errStr))fail  progress:(void(^)(NSString *progressStr))progress{
    UpYunFormUploader *up = [[UpYunFormUploader alloc] init];
    NSString *bucketName = upyunName;
    NSString *dateStr = [NSString dateFormToday];
    NSString *uuid = [Utils genRandomStringLenth:32];
    NSString *photoStr = isDebug ? [NSString stringWithFormat:@"%@%@/%@.jpg",UpLoadimgUrl,dateStr,uuid] : [NSString stringWithFormat:@"%@%@/%@.jpg",UpLoadimgUrl,dateStr,uuid];
    
    NSString *uploadSuccessStr = [NSString stringWithFormat:@"%@/%@.jpg",dateStr,uuid];
    uploadReturnStr(uploadSuccessStr);
    
    [RequestManager showHud:true showString:@"图片上传中" enableUserActions:true withViewController:nil];
    if (underiOS9) {
        [UPYUNConfig sharedInstance].DEFAULT_BUCKET = bucketName;
        [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = upyun_passcode;
        __block UpYun *uy = [[UpYun alloc] init];
        [uy uploadFile:sourceData saveKey:photoStr fileName:photoStr extParams:nil];
        uy.successBlocker = ^(NSURLResponse *response, id responseData) {
            NSLog(@"上传成功 responseBody：%@", responseData);
            NSString *str = [NSString stringWithFormat:@"%@",[responseData objectForKey:@"url"]];
            NSString *newStr = [str stringByReplacingOccurrencesOfString:UpLoadimgUrl withString:@""];
            success(newStr);
            [RequestManager showHud:false showString:@"图片上传中" enableUserActions:true withViewController:nil];
        };
        uy.failBlocker = ^(NSError * error) {
            [RequestManager showHud:false showString:@"图片上传中" enableUserActions:true withViewController:nil];
            NSLog(@"上传失败 error：%@", error);
                fail(error.description);
        };
        uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
            NSLog(@"percent:%.2lf",percent);
        };
    }else{
        [up uploadWithBucketName:bucketName
                        operator:upyunId
                        password:upyunSecret
                        fileData:sourceData
                        fileName:nil
                         saveKey:photoStr
                 otherParameters:nil
                         success:^(NSHTTPURLResponse *response,
                                   NSDictionary *responseBody) {
                             NSLog(@"上传成功 responseBody：%@", responseBody);
                             NSString *str = [NSString stringWithFormat:@"%@",[responseBody objectForKey:@"url"]];
                             NSString *newStr = [str stringByReplacingOccurrencesOfString:UpLoadimgUrl withString:@""];
                             success(newStr);
                             [RequestManager showHud:false showString:@"图片上传中" enableUserActions:true withViewController:nil];
                         }
                         failure:^(NSError *error,
                                   NSHTTPURLResponse *response,
                                   NSDictionary *responseBody) {
                             [RequestManager showHud:false showString:@"图片上传中" enableUserActions:true withViewController:nil];
                             NSLog(@"上传失败 error：%@", error);
                             NSLog(@"上传失败 responseBody：%@", responseBody);
                             NSLog(@"上传失败 message：%@", [responseBody objectForKey:@"message"]);
                             //主线程刷新ui
                             dispatch_async(dispatch_get_main_queue(), ^(){
                                 NSString *message = [responseBody objectForKey:@"message"];
                                 if (!message) {
                                     message = [NSString stringWithFormat:@"%@", error.localizedDescription];
                                 }
                                 fail(message);
                             });
                         }
         
                        progress:^(int64_t completedBytesCount,
                                   int64_t totalBytesCount) {
                            NSString *progress = [NSString stringWithFormat:@"%lld / %lld", completedBytesCount, totalBytesCount];
                            NSString *progress_rate = [NSString stringWithFormat:@"upload %.1f %%", 100 * (float)completedBytesCount / totalBytesCount];
                            NSLog(@"upload progress: %@", progress);
                            NSLog(@"upload progress_rate: %@", progress_rate);
                            //主线程刷新ui
                            dispatch_async(dispatch_get_main_queue(), ^(){
                                //                            progress(progress_rate);
                            });
        }];
    }
}

+(void)upLoadMultimediaWithData:(NSData *)sourceData success:(void (^)(NSString *mediaStr))success fail:(void (^)(NSString *errStr))fail  progress:(void(^)(NSString *progressStr))progress{
    UpYunFormUploader *up = [[UpYunFormUploader alloc] init];
    NSString *bucketName = upyunName;
    NSString *dateStr = [NSString dateFormToday];
    NSString *uuid = [Utils genRandomStringLenth:32];
    NSString *photoStr = isDebug ? [NSString stringWithFormat:@"%@%@/%@.jpg",UpLoadimgUrl,dateStr,uuid] : [NSString stringWithFormat:@"%@%@/%@.jpg",UpLoadimgUrl,dateStr,uuid];
    [RequestManager showHud:true showString:@"图片上传中" enableUserActions:true withViewController:nil];
    if (underiOS9) {
        [UPYUNConfig sharedInstance].DEFAULT_BUCKET = bucketName;
        [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = upyun_passcode;
        __block UpYun *uy = [[UpYun alloc] init];
        [uy uploadFile:sourceData saveKey:photoStr fileName:photoStr extParams:nil];
        uy.successBlocker = ^(NSURLResponse *response, id responseData) {
            NSLog(@"上传成功 responseBody：%@", responseData);
            NSString *str = [NSString stringWithFormat:@"%@",[responseData objectForKey:@"url"]];
            NSString *newStr = [str stringByReplacingOccurrencesOfString:UpLoadimgUrl withString:@""];
            success(newStr);
            [RequestManager showHud:false showString:@"图片上传中" enableUserActions:true withViewController:nil];
        };
        uy.failBlocker = ^(NSError * error) {
            [RequestManager showHud:false showString:@"图片上传中" enableUserActions:true withViewController:nil];
            NSLog(@"上传失败 error：%@", error);
            fail(error.description);
        };
        uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
            NSLog(@"percent:%.2lf",percent);
        };
    }else{
        [up uploadWithBucketName:bucketName
                        operator:upyunId
                        password:upyunSecret
                        fileData:sourceData
                        fileName:nil
                         saveKey:photoStr
                 otherParameters:nil
                         success:^(NSHTTPURLResponse *response,
                                   NSDictionary *responseBody) {
                             NSLog(@"上传成功 responseBody：%@", responseBody);
                             NSString *str = [NSString stringWithFormat:@"%@",[responseBody objectForKey:@"url"]];
                             NSString *newStr = [str stringByReplacingOccurrencesOfString:UpLoadimgUrl withString:@""];
                             success(newStr);
                             [RequestManager showHud:false showString:@"图片上传中" enableUserActions:true withViewController:nil];
                         }
                         failure:^(NSError *error,
                                   NSHTTPURLResponse *response,
                                   NSDictionary *responseBody) {
                             [RequestManager showHud:false showString:@"图片上传中" enableUserActions:true withViewController:nil];
                             NSLog(@"上传失败 error：%@", error);
                             NSLog(@"上传失败 responseBody：%@", responseBody);
                             NSLog(@"上传失败 message：%@", [responseBody objectForKey:@"message"]);
                             //主线程刷新ui
                             dispatch_async(dispatch_get_main_queue(), ^(){
                                 NSString *message = [responseBody objectForKey:@"message"];
                                 if (!message) {
                                     message = [NSString stringWithFormat:@"%@", error.localizedDescription];
                                 }
                                 fail(message);
                             });
                         }
         
                        progress:^(int64_t completedBytesCount,
                                   int64_t totalBytesCount) {
                            NSString *progress = [NSString stringWithFormat:@"%lld / %lld", completedBytesCount, totalBytesCount];
                            NSString *progress_rate = [NSString stringWithFormat:@"upload %.1f %%", 100 * (float)completedBytesCount / totalBytesCount];
                            NSLog(@"upload progress: %@", progress);
                            NSLog(@"upload progress_rate: %@", progress_rate);
                            //主线程刷新ui
                            dispatch_async(dispatch_get_main_queue(), ^(){
                                //                            progress(progress_rate);
                            });
                        }];
    }
}

+(void)upLoadMultimediaWithDataArr:(NSArray *)sourceDataArr success:(void (^)(NSArray *mediaStrs))success fail:(void (^)(NSString *errStr))fail  progress:(void(^)(NSString *progressStr))progress{
    NSMutableArray *urlStrArr = [NSMutableArray array];
    NSMutableArray *uploadEndStrArr = [NSMutableArray array];
    for (NSData *data in sourceDataArr) {
        [self upLoadMultimediaWithData:data uploadReturnStr:^(NSString *uploadSuccessStr) {
            [urlStrArr addObject:uploadSuccessStr];
        } success:^(NSString *mediaStr) {
            [uploadEndStrArr addObject:mediaStr];
            if (uploadEndStrArr.count == sourceDataArr.count) {
                success(urlStrArr);
            }
        } fail:^(NSString *errStr) {
            //
        } progress:^(NSString *progressStr) {
            //
        }];
    }
}

+(void)downImageWithUrlStrArr:(NSMutableArray *)urlArr success:(void (^)(NSArray *imgArr))success errorBlock:(void (^)(NSError *error))errorBlock{
    NSMutableArray *downimgArr = [NSMutableArray array];
    [RequestManager showHud:true showString:@"图片获取中..." enableUserActions:true withViewController:nil];
    for (int i = 0; i < urlArr.count; i++) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlArr[i]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (error) {
                errorBlock(error);
                [RequestManager showHud:false showString:@"图片获取中..." enableUserActions:true withViewController:nil];
            }
            if (image){
                [downimgArr addObject:image];
            }
            if (downimgArr.count == urlArr.count) {
                success(downimgArr);
                [RequestManager showHud:false showString:@"图片获取中..." enableUserActions:true withViewController:nil];
            }
        }];
    }
}

@end
