//
//  InputAddressController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "InputAddressController.h"

@interface InputAddressController ()

@end

@implementation InputAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:1] forKey:@"id"];
    [RequestManager requestWithMethod:DELETE WithUrlPath:@"user/address" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        //
    } fail:^(NSError *error) {
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    if (_nameLabel.text.length == 0) {
        return;
    }
    if (_phoneLabel.text.length == 0) {
        return;
    }
    if (_addressLabel.text.length == 0) {
        return;
    }
    if (_detailAddressLabel.text.length == 0) {
        return;
    }
    NSUInteger customerId = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:customerId] forKey:@"customerId"];
    [params setObject:_nameLabel.text forKey:@"receiver"];
    [params setObject:_phoneLabel.text forKey:@"phone"];
    NSString *totalAddress = [NSString stringWithFormat:@"%@ %@",_addressLabel.text,_detailAddressLabel.text];
    [params setObject:totalAddress forKey:@"address"];
    NSString *str = [Utils jonStrWithDictionary:params];
    NSDictionary *dict = @{@"data":str};
    [WebRequest webRequestWithURLGetMethod:reviceAddress_edit_url params:dict success:^(id result) {
        NSLog(@"%@", result);
        NewAddressEditBlock block = _addressEditHandle;
        if (block) {
            block();
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSString *result) {
        NSLog(@"%@", result);
    }];
}

@end
