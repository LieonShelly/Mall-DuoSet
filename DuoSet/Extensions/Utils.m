//
//  Utils.m
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "Utils.h"
#import <sys/utsname.h>
#import<CommonCrypto/CommonDigest.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@implementation Utils

+(void)setUserInfo:(UserInfo *)userinfo{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userinfo];
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"USERINFO"];
}

+(UserInfo *)getUserInfo{
    UserInfo *info = [[UserInfo alloc]init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERINFO"];
    if (data != nil) {
        info = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return info;
}


+ (void)setDeviceOs:(NSString *)deviceOs{
    [[NSUserDefaults standardUserDefaults] setValue:deviceOs forKey:@"DEVICEOS"];
}

+ (NSString *)getDeviceOs{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICEOS"];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSString *)jonStrWithDictionary:(NSMutableDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    if (!parseError) {
        return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return @"";
    }
}

+(NSString *)arrayToJSONString:(NSArray *)array{
    NSError *error = nil;
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    NSLog(@"json array is: %@", jsonResult);
    return jsonString;
}

+(CGSize)getImageSizeWithURLString:(NSString *)imageUrlStr{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlStr]];
    UIImage *image = [UIImage imageWithData:data];
    //#ifdef dispatch_main_sync_safe
    [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:imageUrlStr toDisk:YES];
    //#endif
    return image.size;
}

+(CGSize)getImageSizeWithURLStr:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
//        if (![imageURL containsString:@"@"]) {
//            imageURL = [imageURL stringByAppendingString:@"@100p"];
//        }
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    
    NSString* absoluteString = URL.absoluteString;
    
//#ifdef dispatch_main_sync_safe
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        //        UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:absoluteString];
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            //            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            //            image = [UIImage imageWithData:data];
            image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:absoluteString];
        }
        if(image)
        {
            return image.size;
        }
    }
//#endif
    
    return [self getImageSizeWithURLString:absoluteString];
    
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
//    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
//    
//    CGSize size = CGSizeZero;
//    if([pathExtendsion isEqualToString:@"png"]){
//        size =  [self downloadPNGImageSizeWithRequest:request];
//    }
//    else if([pathExtendsion isEqual:@"gif"])
//    {
//        size =  [self downloadGIFImageSizeWithRequest:request];
//    }
//    else{
//        size = [self downloadJPGImageSizeWithRequest:request];
//    }
//    if(CGSizeEqualToSize(CGSizeZero, size))
//    {
//        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
//        UIImage* image = [UIImage imageWithData:data];
//        if(image)
//        {
////#ifdef dispatch_main_sync_safe
//            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
////#endif
//            size = image.size;
//        }
//    }
//    return size;
}

+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

+ (UIImage*)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [[UIColor clearColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGFloat lengths[] = { 3, 1 };
    CGContextSetLineDash(context, 0, lengths, 1);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, size.width, 0.0);
    CGContextAddLineToPoint(context, size.width, size.height);
    CGContextAddLineToPoint(context, 0, size.height);
    CGContextAddLineToPoint(context, 0.0, 0.0);
    CGContextStrokePath(context);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(NSString *)genRandomStringLenth:(NSInteger)length{
    NSString *allCharacters = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [[NSMutableString alloc]initWithCapacity:length];
    for (int i = 0; i < length ; i++) {
        int len = (UInt32)allCharacters.length;
        int rand = arc4random_uniform(len) % len;
        [randomString appendFormat:@"%c",[allCharacters characterAtIndex:rand]];
    }
    return randomString;
}

+(NSString *)getUUID{
    UserInfo *userInfo = [Utils getUserInfo];
    NSString *uuid = userInfo.uuid;
    if (uuid == nil || uuid.length == 0 ) {
        uuid = [Utils genRandomStringLenth:32];
        userInfo.uuid = uuid;
        [Utils setUserInfo:userInfo];
    }
    return uuid;
}

+(NSString *)getIphoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

+(NSString *)md5:(NSString *)input{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

+(NSString *)getCacheSize{
    NSString *size = @"";
    float cacheSize = [self readCacheSize] *1024;
    size = [NSString stringWithFormat:@"%.1fKB",cacheSize];
    if (cacheSize > 1024) {
        cacheSize = cacheSize / 1024;
        size = [NSString stringWithFormat:@"%.1fM",cacheSize];
    }
    return size;
}

+(float)readCacheSize{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [self folderSizeAtPath :cachePath];
}

+(float) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
}

+(long long)fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

+(void)clearFile{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
}

+(BOOL)isIncludeSpecialCharact: (NSString *)str{
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

+ (void)sharePlateType:(SSDKPlatformType)plateType ImageArray:(NSArray *)imgArray contentText:(NSString *)content shareURL:(NSString *)url shareTitle:(NSString *)title andViewController:(UIViewController *)controller success:(void(^)(SSDKPlatformType plateType))success{
    if (plateType == SSDKPlatformSubTypeWechatSession || plateType == SSDKPlatformSubTypeWechatTimeline){//判断安装微信
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {//没安装微信
            [[UIApplication sharedApplication].keyWindow makeToast:@"未安装微信客服端，暂时不能分享"];
            return;
        }
    }
    if (plateType == SSDKPlatformSubTypeQQFriend || plateType == SSDKPlatformSubTypeQZone) {//QQ
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {//没安装微信
            [[UIApplication sharedApplication].keyWindow makeToast:@"未安装QQ客服端，暂时不能分享"];
            return;
        }
    }
    if (plateType == SSDKPlatformTypeSinaWeibo) {//微博
        if (![WeiboSDK isWeiboAppInstalled]) {
            [[UIApplication sharedApplication].keyWindow makeToast:@"未安装微博客服端，暂时不能分享"];
            return;
        }
//        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sina://wb2264393756"]]) {//没安装微信
//            return;
//        }
    }
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    for (NSObject *obj in imgArray) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *url = (NSString *)obj;
            if ([url hasPrefix:BaseImgUrl]) {
                UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
                if (image != nil){
                    UIImage *littleImage = [UIImage OriginImage:image scaleToSize:CGSizeMake(200,200)];
                    [imageArr addObject:littleImage];
                }else{
                    if (imgArray.count > 0) {
                        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                        UIImage *image= [UIImage imageWithData:data];
                        UIImage *littleImage = [UIImage OriginImage:image scaleToSize:CGSizeMake(200,200)];
                        [imageArr addObject:littleImage];
                    }
                }
            }else if ([obj isKindOfClass:[UIImage class]]){
                UIImage *image = (UIImage *)obj;
                UIImage *littleImage = [UIImage OriginImage:image scaleToSize:CGSizeMake(200,200)];
                [imageArr addObject:littleImage];
            }
        }else if ([obj isKindOfClass:[UIImage class]]){
            UIImage *image = (UIImage *)obj;
            UIImage *littleImage = [UIImage OriginImage:image scaleToSize:CGSizeMake(200,200)];
            [imageArr addObject:littleImage];
        }
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:imageArr
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    [shareParams SSDKEnableUseClientShare];
    
    [ShareSDK share:plateType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateBegin:
            {
                NSLog(@"开始");
                break;
            }
            case SSDKResponseStateSuccess:
            {
                success(plateType);
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@", error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateCancel:
            {
                NSLog(@"用户取消分享");
                break;
            }
            default:
                break;
        }
    }];
}
/*
 +(void)setUserInfo:(UserInfo *)userinfo{
 NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userinfo];
 [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"USERINFO"];
 }
 
 +(UserInfo *)getUserInfo{
 UserInfo *info = [[UserInfo alloc]init];
 NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERINFO"];
 if (data != nil) {
 info = [NSKeyedUnarchiver unarchiveObjectWithData:data];
 }
 return info;
 }
 */



//+(void)setSearchHistoryWithSearchData:(SearchData *)item{
//    NSArray *arr = [NSArray array];
//    arr = [self getSearchAllHistory];
//    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:arr];
//    for (NSString *str in arr) {
//        if ([str isEqualToString:keyWord]) {
//            [mutableArr removeObject:str];
//        }
//    }
//    [mutableArr insertObject:keyWord atIndex:0];
//    if (mutableArr.count > 10) {
//        arr = [mutableArr subarrayWithRange:NSMakeRange(0, 9)];
//    }else{
//        arr = [NSArray arrayWithArray:mutableArr];
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"AllSearchHistory"];
//}

/*
 +(UserInfo *)getUserInfo{
 UserInfo *info = [[UserInfo alloc]init];
 NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERINFO"];
 if (data != nil) {
 info = [NSKeyedUnarchiver unarchiveObjectWithData:data];
 }
 return info;
 }
 */

+(NSArray *)getSearchAllHistory{
    NSArray *arr = [NSArray array];
    arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"AllSearchHistory"];
    return arr;
}

+(void)removeAllHistory{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AllSearchHistory"];
}

+(BOOL)IsEmailAdress:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

+(BOOL)IsIdentityCard:(NSString *)IDCardNumber{
    if (IDCardNumber.length <= 0 || IDCardNumber.length < 18) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}

#pragma mark -- 百度坐标转高德坐标
+ (CLLocationCoordinate2D)GCJ02FromBD09:(CLLocationCoordinate2D)coor
{
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude - 0.0065, y = coor.latitude - 0.006;
    CLLocationDegrees z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    CLLocationDegrees gg_lon = z * cos(theta);
    CLLocationDegrees gg_lat = z * sin(theta);
    return CLLocationCoordinate2DMake(gg_lat, gg_lon);
}

#pragma mark -- 高德坐标转百度坐标
+ (CLLocationCoordinate2D)BD09FromGCJ02:(CLLocationCoordinate2D)coor
{
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude, y = coor.latitude;
    CLLocationDegrees z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    CLLocationDegrees bd_lon = z * cos(theta) + 0.0065;
    CLLocationDegrees bd_lat = z * sin(theta) + 0.006;
    return CLLocationCoordinate2DMake(bd_lat, bd_lon);
}

@end
