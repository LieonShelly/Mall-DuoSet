//
//  OrderDetailBottomView.m
//  DuoSet
//
//  Created by mac on 2017/1/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderDetailBottomView.h"

@interface OrderDetailBottomView()

@property(nonatomic,strong) NSMutableArray *btnArr;
@property(nonatomic,strong) UILabel *cutDownLable;
@property(nonatomic,retain) dispatch_source_t timer;

@end

@implementation OrderDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self addSubview:line];
        
        CGFloat btnW = FitWith(150.0);
        CGFloat btnH = frame.size.height - FitHeight(40.0);
        
        _btnArr = [NSMutableArray array];
        
        for (int i = 0; i < 4; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(70.0) + (FitWith(168.0) * i), FitHeight(20), btnW, btnH)];
            btn.tag = i;
            btn.titleLabel.font = CUSNEwFONT(16);
            btn.backgroundColor = [UIColor clearColor];
            btn.layer.cornerRadius = 3;
            btn.layer.borderWidth = 1;
            btn.layer.masksToBounds = true;
            if (i == 3) {
                [btn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
                btn.layer.borderColor = [UIColor mainColor].CGColor;
            }else{
                [btn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateNormal];
                btn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
            }
            [btn addTarget:self action:@selector(bottomBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [_btnArr addObject:btn];
        }
        
        _cutDownLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(30.0), FitHeight(10.0), FitWith(220.0), FitHeight(40.0))];
        _cutDownLable.textAlignment = NSTextAlignmentLeft;
        _cutDownLable.text = @"剩余付款时间:";
        _cutDownLable.font = CUSNEwFONT(14);
        _cutDownLable.textColor = [UIColor colorFromHex:0x808080];
        _cutDownLable.hidden = true;
        [self addSubview:_cutDownLable];
        
        _cutDownTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(30.0), _cutDownLable.frame.origin.y + _cutDownLable.frame.size.height, FitWith(300.0), FitHeight(40.0))];
        _cutDownTimeLable.textAlignment = NSTextAlignmentLeft;
        _cutDownTimeLable.font = CUSNEwFONT(15);
        _cutDownTimeLable.textColor = [UIColor mainColor];
        _cutDownTimeLable.hidden = true;
        [self addSubview:_cutDownTimeLable];
        
    }
    return self;
}

-(void)setupInfoWithDuojiOrderData:(DuojiOrderData *)item{
    if (item.orderState == OrderStatesCreate) {
        [self endPayCutdownTimeWithDuojiOrderData:item];
        _cutDownLable.hidden = false;
        _cutDownTimeLable.hidden = false;
        for (int i = 0; i < 4; i++) {
            UIButton *btn = _btnArr[i];
            if (i <= 1) {
                btn.hidden = true;
            }else{
                if (i == 2) {
                    [btn setTitle:@"取消订单" forState:UIControlStateNormal];
                }
                if (i == 3) {
                    [btn setTitle:@"去支付" forState:UIControlStateNormal];
                }
            }
        }
    }
    if (item.orderState == OrderStatesBeforSendCancel) {
        for (int i = 0; i < 4; i++) {
            UIButton *btn = _btnArr[i];
            if (i <= 2) {
                btn.hidden = true;
            }else{
                if (i == 3) {
                    [btn setTitle:@"再次购买" forState:UIControlStateNormal];
                }
            }
        }
    }
    if (item.orderState == OrderStatesPaid) {
        for (int i = 0; i < 4; i++) {
            UIButton *btn = _btnArr[i];
            if (item.isGlobal) {
                if (i <= 2) {
                    btn.hidden = true;
                }else{
                    if (i == 3) {
                        [btn setTitle:@"再次购买" forState:UIControlStateNormal];
                    }
                }
            }else{
                if (i <= 1) {
                    btn.hidden = true;
                }else{
                    if (i == 2) {
                        [btn setTitle:@"申请退款" forState:UIControlStateNormal];
                        btn.hidden = item.isChange;
                    }
                    if (i == 3) {
                        [btn setTitle:@"再次购买" forState:UIControlStateNormal];
                    }
                }
            }
        }
    }
    if (item.orderState == OrderStatesSend) {
        for (int i = 0; i < 4; i++) {
            UIButton *btn = _btnArr[i];
            if (item.isGlobal) {
                if (i <= 2) {
                    btn.hidden = true;
                }else{
                    if (i == 3) {
                        [btn setTitle:@"再次购买" forState:UIControlStateNormal];
                    }
                }
            }else{
                if (i <= 1) {
                    btn.hidden = true;
                }else if (i == 2){
                    [btn setTitle:@"申请售后" forState:UIControlStateNormal];
                }else{
                    [btn setTitle:@"再次购买" forState:UIControlStateNormal];
                }
            }
        }
    }
    if (item.orderState == OrderStatesWaitComment) {
        for (int i = 0; i < 4; i++) {
            UIButton *btn = _btnArr[i];
            if (item.isGlobal) {
                if (i == 0) {
                    btn.hidden = true;
                }
                if (i == 1) {
                    [btn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if (i == 2) {
                    [btn setTitle:@"再次购买" forState:UIControlStateNormal];
                }
                if (i == 3) {
                    [btn setTitle:@"评价晒单" forState:UIControlStateNormal];
                }
            }else{
                if (i == 0) {
                    [btn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if (i == 1) {
                    [btn setTitle:@"申请售后" forState:UIControlStateNormal];
                }
                if (i == 2) {
                    [btn setTitle:@"再次购买" forState:UIControlStateNormal];
                }
                if (i == 3) {
                    [btn setTitle:@"评价晒单" forState:UIControlStateNormal];
                }
            }
        }
    }
    if (item.orderState == OrderStatesDone) {
        for (int i = 0; i < 4; i++) {
            UIButton *btn = _btnArr[i];
            if (i == 0) {
                btn.hidden = true;
            }
            if (item.isGlobal) {
                if (i == 1) {
                    btn.hidden = true;
                }
                if (i == 2) {
                    [btn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if (i == 3) {
                    [btn setTitle:@"再次购买" forState:UIControlStateNormal];
                }
            }else{
                if (i == 1) {
                    [btn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if (i == 2) {
                    [btn setTitle:@"申请售后" forState:UIControlStateNormal];
                }
                if (i == 3) {
                    [btn setTitle:@"再次购买" forState:UIControlStateNormal];
                }
            }
        }
    }
    if (item.orderState == OrderStatesCancel) {
        for (int i = 0; i < 4; i++) {
            UIButton *btn = _btnArr[i];
            if (i == 0 || i == 1) {
                btn.hidden = true;
            }
            if (i == 2) {
                [btn setTitle:@"删除订单" forState:UIControlStateNormal];
            }
            if (i == 3) {
                [btn setTitle:@"再次购买" forState:UIControlStateNormal];
            }
        }
    }
}

-(void)bottomBtnsAction:(UIButton *)btn{
    BottomBtnsActionBlock block = _btnActionHandle;
    if (block) {
        block(btn);
    }
}

-(void)relessTimer{
    if (_timer != nil) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}


-(void)endPayCutdownTimeWithDuojiOrderData:(DuojiOrderData *)item{
    [self countDownWithFinishTimeStamp:item.remainTime.longLongValue completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        if (day == 0 && hour == 0 && minute == 0 && second == 0) {
            BottomCutDownTimeEndBlock block = _cutdownEndHandle;
            if (block) {
                block();
            }
        }
        NSString *hourStr = @"";
        NSString *minuteStr = @"";
        NSString *secondStr = @"";
        if (hour<10) {
            hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
        }else{
            hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
        }
        if (minute<10) {
            minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
        }else{
            minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
        }
        if (second<10) {
            secondStr= [NSString stringWithFormat:@"0%ld",(long)second];
        }else{
            secondStr= [NSString stringWithFormat:@"%ld",(long)second];
        }
        NSString *allStr = @"";
        if (hourStr.integerValue == 0) {
            allStr = [NSString stringWithFormat:@"%@分%@秒",minuteStr,secondStr];
        }else{
            allStr = [NSString stringWithFormat:@"%@小时%@分%@秒",hourStr,minuteStr,secondStr];
        }
        _cutDownTimeLable.text = allStr;
    }];
}


-(void)countDownWithFinishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer==nil) {
        NSTimeInterval timeInterval = finishTimeStamp/1000;
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

@end
