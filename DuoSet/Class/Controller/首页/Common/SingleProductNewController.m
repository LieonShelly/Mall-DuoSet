//
//  SingleProductNewController.m
//  DuoSet
//
//  Created by fanfans on 2017/4/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SingleProductNewController.h"

@interface SingleProductNewController ()

@property(nonatomic,copy) NSString *productNum;

@end

@implementation SingleProductNewController

#pragma mark - init / viewWillAppear / viewWillDisappear / viewDidLoad
-(instancetype)initWithProductId:(NSString *)productNum{
    self = [super init];
    if (self) {
        _productNum = productNum;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
