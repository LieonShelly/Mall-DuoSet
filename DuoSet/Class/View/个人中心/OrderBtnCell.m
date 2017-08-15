//
//  OrderBtnCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "OrderBtnCell.h"

@implementation OrderBtnCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initViews];
    }
    return self;
}
- (void) initViews{
    _btnTitleArray = @[@"待付款", @"待发货", @"待收货", @"待评价", @"退换货"];
    _btnImgArray = @[@"待付款png", @"待发货png", @"待收货png", @"待评价png", @"退换货png"];
    CGFloat btnW = (mainScreenWidth - 60*AdapterWidth())/_btnImgArray.count;
    CGFloat btnH = self.frame.size.height*3/5;
    int index = 101;
    for (int i = 0; i < _btnTitleArray.count; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10+(btnW+10)*i, 10, btnW, btnH)];
        [btn setImage: IMAGE_NAME(_btnImgArray[i]) forState:UIControlStateNormal
         ];
        btn.tag = index;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:btn];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10+(btnW+10)*i, btnH+15, btnW, self.frame.size.height*2/5)];
        label.font = [UIFont systemFontOfSize:14*AdapterWidth()];
        [self.contentView addSubview:label];
        label.text = _btnTitleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        index++;
    }
}
#pragma mark - responds events
- (void) btnAction: (UIButton *) btn{
       if(btn.tag == 101){
        if (self.weifukuan){
            self.weifukuan();
        }
    }
    if (btn.tag == 102){
        if (self.weifahuo){
            self.weifahuo();
        }
    }
    if (btn.tag == 103){
        if (self.weishouhuo){
            self.weishouhuo();
        }
    }
    if (btn.tag == 104){
        if (self.weipingjia){
            self.weipingjia();
        }
    }
    if (btn.tag == 105){
        if (self.tuihuanhuo){
            self.tuihuanhuo();
        }
    }
}

@end
