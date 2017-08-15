//
//  RuleViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/7.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "RuleViewController.h"

@interface RuleViewController ()

@end

@implementation RuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void) creatUI {
    UIView *headerView = [[UIView alloc] init];
    [self.view addSubview:headerView];
    headerView.backgroundColor = [UIColor grayColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 18, 12, 12)];
    [headerView addSubview:imgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.origin.x+imgView.frame.size.width+5, 18, 100, 12)];
    nameLabel.text = @"签到规则";
    nameLabel.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    [headerView addSubview:nameLabel];
    
    NSString *str = @"签到是哆集用户获取积分的一种方式，不同级别会员货到积分数量不同：积分可兑换哆票，从而抵消部分或全部消费金额";
//    CGSize *strSize = [str boundingRectWithSize:CGSizeMake(mainScreenWidth-36, 10000) options:<#(NSStringDrawingOptions)#> attributes:<#(nullable NSDictionary<NSString *,id> *)#> context:<#(nullable NSStringDrawingContext *)#>]
    
    UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, imgView.frame.origin.y+imgView.frame.size.height+10, mainScreenWidth-36, 70)];
    describeLabel.text = str;
    describeLabel.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    describeLabel.numberOfLines = 0;
    [headerView addSubview:describeLabel];
    
    headerView.frame = CGRectMake(0, 64, mainScreenWidth, describeLabel.frame.origin.y+describeLabel.frame.size.height+18);
    UIView *view1 = [[UIView alloc] init];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 6, mainScreenWidth-30, 22)];
    [view1 addSubview:label1];
    label1.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    label1.text = @"注册用户";
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(30, label1.frame.origin.y+label1.frame.size.height+2, mainScreenWidth-30, 22)];
    label2.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    label2.text = @"单日签到积1分，连续签到7天奖励20分";
    [view1 addSubview:label2];
    
    
    
    view1.frame = CGRectMake(0, headerView.frame.size.height+64, mainScreenWidth, label2.frame.origin.y+label2.frame.size.height+6);
    [self.view addSubview:view1];
    
    
    
    UIView *view2 = [[UIView alloc] init];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 6, mainScreenWidth-30, 22)];
    [view2 addSubview:label3];
    label3.text = @"注册用户";
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(30, label3.frame.origin.y+label3.frame.size.height+2, mainScreenWidth-30, 22)];
    label4.text = @"单日签到积1分，连续签到7天奖励20分";
    [view2 addSubview:label4];
    
    view2.frame = CGRectMake(0, view1.frame.size.height+view1.frame.origin.y+15, mainScreenWidth, label4.frame.origin.y+label4.frame.size.height+6);
    [self.view addSubview:view2];
    
    
    UIView *view3 = [[UIView alloc] init];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(30, 6, mainScreenWidth-30, 22)];
    [view3 addSubview:label5];
    label5.text = @"注册用户";
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(30, label5.frame.origin.y+label5.frame.size.height+2, mainScreenWidth-30, 22)];
    label6.text = @"单日签到积1分，连续签到7天奖励20分";
    [view3 addSubview:label6];
    
    view3.frame = CGRectMake(0, view2.frame.size.height+view2.frame.origin.y+15, mainScreenWidth, label6.frame.origin.y+label6.frame.size.height+6);
    [self.view addSubview:view3];

    
    
    UIView *view4 = [[UIView alloc] init];
    
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(30, 6, mainScreenWidth-30, 22)];
    [view4 addSubview:label7];
    label7.text = @"注册用户";
    
    UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(30, label7.frame.origin.y+label7.frame.size.height+2, mainScreenWidth-30, 22)];
    label8.text = @"单日签到积1分，连续签到7天奖励20分";
    [view4 addSubview:label8];
    
    view4.frame = CGRectMake(0, view3.frame.size.height+view3.frame.origin.y+15, mainScreenWidth, label8.frame.origin.y+label8.frame.size.height+6);
    [self.view addSubview:view4];

    
    
    UIView *view5 = [[UIView alloc] init];
    
    UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(30, 6, mainScreenWidth-30, 22)];
    [view5 addSubview:label9];
    label9.text = @"注册用户";
    
    UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(30, label9.frame.origin.y+label9.frame.size.height+2, mainScreenWidth-30, 22)];
    label10.text = @"单日签到积1分，连续签到7天奖励20分";
    [view5 addSubview:label10];
    
    view5.frame = CGRectMake(0, view4.frame.size.height+view4.frame.origin.y+15, mainScreenWidth, label10.frame.origin.y+label10.frame.size.height+6);
    [self.view addSubview:view5];

    
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
