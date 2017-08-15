//
//  RecommendToYou.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/13.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "RecommendToYou.h"

@implementation RecommendToYou
+ (NSString *)recommendToYouGetNetData: (NSDictionary *) dict{
    [WebRequest webRequestWithURLGetMethod:RecommendToYou_Url params:dict success:^(id result) {
        
    } fail:^(NSString *result) {
        
    }];
    
    return @"2";
}

+ (NSString *) styleChoiceTypeGetNetData:(NSDictionary *)dict{
    
    //WebRequest webRequestWithURLGetMethod:<#(NSString *)#> params:<#(id)#> success:<#^(id result)success#> fail:<#^(NSString *result)fail#>
    return @"1";
}
@end
