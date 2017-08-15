//
//  ActivityDetailsController.m
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "ActivityDetailsController.h"

@interface ActivityDetailsController ()

@property(nonatomic,copy) NSString *activityId;

@end

@implementation ActivityDetailsController

-(instancetype)initWithAcyivityId:(NSString *)activityId{
    self = [super init];
    if (self) {
        _activityId = activityId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
