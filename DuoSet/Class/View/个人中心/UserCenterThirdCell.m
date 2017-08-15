//
//  UserCenterThirdCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "UserCenterThirdCell.h"

@implementation UserCenterThirdCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void) initViews {
    CGFloat btnw = (mainScreenWidth - 3)/4;
    CGFloat bgViewH = 70*AdapterWidth();
    NSArray *btnArray = @[@"哆豆", @"优惠券", @"商品关注", @"我的钱包"];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, bgViewH)];
    [self.contentView addSubview:view1];
    for (int i = 0; i < btnArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((btnw+1)*i, 0, btnw, bgViewH/2)];
        [view1 addSubview:label];
        label.tag = 101+i;
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14*AdapterWidth()];
        UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(btnw+(btnw+1)*i, 0, 1, bgViewH)];
        divisionView.backgroundColor = LGBgColor;
        [view1 addSubview:divisionView];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((btnw+1)*i, bgViewH/2, btnw, bgViewH/2)];
        btn.tag = 201+i;
        [btn addTarget:self action:@selector(secondBtnAction:) forControlEvents:UIControlEventTouchDown];
        [view1 addSubview:btn];
        NSDictionary * dict = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:14*AdapterWidth()]};
        NSAttributedString * titleStr = [[NSAttributedString alloc]initWithString:btnArray[i] attributes:dict];
        [btn setAttributedTitle:titleStr forState:UIControlStateNormal];
    }
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, bgViewH+15, mainScreenWidth, bgViewH)];
    [self.contentView addSubview:view2];
    NSArray *titleArray = @[@"浏览记录", @"我的活动", @"联系客服"];
    NSArray *btnImgArray = @[@"浏览记录png", @"我的记录png", @"联系客服png"];
    for (int j = 0; j< titleArray.count; j++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((btnw+1)*j, 0, btnw, bgViewH/2)];
        btn.tag = 205+j;
        [view2 addSubview:btn];
        [btn setImage:IMAGE_NAME(btnImgArray[j]) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(firstBtnAction:) forControlEvents:UIControlEventTouchDown];
        UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(btnw+(btnw+1)*j, 0, 1, bgViewH)];
        divisionView.backgroundColor = LGBgColor;
        [view2 addSubview:divisionView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((btnw+1)*j, bgViewH/2, btnw, bgViewH/2)];
        [view2 addSubview:label];
        label.text = titleArray[j];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    }
}
#pragma mark - responds events
- (void) secondBtnAction:(UIButton *) btn{
    if (btn.tag == 201){
        if (self.duoDouBtn){
            self.duoDouBtn();
        }
    }
    if (btn.tag == 202){
        if (self.youhuijuanBtn){
            self.youhuijuanBtn();
        }
    }
    if (btn.tag == 203){
        if (self.shangpinAttentionBtn){
            self.shangpinAttentionBtn();
        }
    }
    if (btn.tag == 204){
        if (self.walletBtn){
            self.walletBtn();
        }
    }
}

- (void) firstBtnAction:(UIButton *) btn{
    if (btn.tag == 205){
        if (self.historyBtn){
            self.historyBtn();
        }
    }
    if (btn.tag == 206){
        if(self.activityBtn){
            self.activityBtn();
        }
    }
    if (btn.tag == 207){
        if (self.kefuBtn){
            self.kefuBtn();
        }
    }
//    if (btn.tag == 208){
//    }
}
@end
