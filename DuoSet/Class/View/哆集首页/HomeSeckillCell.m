//
//  SeckillCell.m
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeSeckillCell.h"
#import "SeckillProductView.h"
#import "SeckillListData.h"

@interface HomeSeckillCell()

@property(nonatomic,strong) UIImageView *seckillImgV;
@property(nonatomic,strong) UILabel *sessionlable;
@property(nonatomic,strong) UILabel *hourLable;
@property(nonatomic,strong) UILabel *cutLable;
@property(nonatomic,strong) UILabel *minLable;
@property(nonatomic,strong) UILabel *cutLable1;
@property(nonatomic,strong) UILabel *secLaeble;
@property(nonatomic,strong) UILabel *rightLable;
@property(nonatomic,strong) UILabel *onlyOneLable;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSMutableArray *productViewArr;
@property(nonatomic,retain) dispatch_source_t timer;

@end

@implementation HomeSeckillCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:line];
        
        _seckillImgV = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(20.0), FitHeight(26.0), FitWith(130.0), FitHeight(30.0))];
        _seckillImgV.image = [UIImage imageNamed:@"seckill_img_home"];
        [self.contentView addSubview:_seckillImgV];
        
        _sessionlable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(170.0), FitHeight(26.0), FitWith(130.0), FitHeight(30.0))];
        _sessionlable.textColor = [UIColor blackColor];
        _sessionlable.textAlignment = NSTextAlignmentLeft;
        _sessionlable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [self.contentView addSubview:_sessionlable];
        
        _onlyOneLable = [[UILabel alloc]initWithFrame:CGRectMake(_sessionlable.frame.origin.x + _sessionlable.frame.size.width, FitHeight(22.0), 200, FitHeight(40.0))];
        _onlyOneLable.text = @"秒杀中";
        _onlyOneLable.textAlignment = NSTextAlignmentLeft;
        _onlyOneLable.font = [UIFont systemFontOfSize:13];
        _onlyOneLable.textColor = [UIColor mainColor];
        _onlyOneLable.hidden = true;
        [self.contentView addSubview:_onlyOneLable];
        
        _hourLable = [[UILabel alloc]initWithFrame:CGRectMake(_sessionlable.frame.origin.x + _sessionlable.frame.size.width, FitHeight(22.0), FitWith(40.0), FitHeight(40.0))];
        _hourLable.textColor = [UIColor whiteColor];
        _hourLable.textAlignment = NSTextAlignmentLeft;
        _hourLable.backgroundColor = [UIColor mainColor];
        _hourLable.layer.cornerRadius = 2;
        _hourLable.layer.masksToBounds = true;
        _hourLable.font = [UIFont systemFontOfSize:12];
        _hourLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_hourLable];
        
        _cutLable = [[UILabel alloc]initWithFrame:CGRectMake(_hourLable.frame.origin.x + _hourLable.frame.size.width + FitWith(6), _hourLable.frame.origin.y, FitWith(10.0), FitHeight(40.0))];
        _cutLable.text = @":";
        _cutLable.textAlignment = NSTextAlignmentCenter;
        _cutLable.textColor = [UIColor mainColor];
        _cutLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_cutLable];
        
        _minLable = [[UILabel alloc]initWithFrame:CGRectMake(_cutLable.frame.origin.x + _cutLable.frame.size.width + FitWith(6), _hourLable.frame.origin.y, FitWith(40.0), FitHeight(40.0))];
        _minLable.textColor = [UIColor whiteColor];
        _minLable.textAlignment = NSTextAlignmentLeft;
        _minLable.font = [UIFont systemFontOfSize:12];
        _minLable.backgroundColor = [UIColor mainColor];
        _minLable.layer.cornerRadius = 2;
        _minLable.layer.masksToBounds = true;
        _minLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_minLable];
        
        _cutLable1 = [[UILabel alloc]initWithFrame:CGRectMake(_minLable.frame.origin.x + _minLable.frame.size.width + FitWith(6), _hourLable.frame.origin.y, FitWith(10.0), FitHeight(40.0))];
        _cutLable1.text = @":";
        _cutLable1.textAlignment = NSTextAlignmentCenter;
        _cutLable1.textColor = [UIColor mainColor];
        _cutLable1.backgroundColor = [UIColor clearColor];
        [self addSubview:_cutLable1];
        
        _secLaeble = [[UILabel alloc]initWithFrame:CGRectMake(_cutLable1.frame.origin.x + _cutLable1.frame.size.width + FitWith(6), _hourLable.frame.origin.y, FitWith(40.0), FitHeight(40.0))];
        _secLaeble.textColor = [UIColor whiteColor];
        _secLaeble.textAlignment = NSTextAlignmentLeft;
        _secLaeble.font =[UIFont systemFontOfSize:12];
        _secLaeble.backgroundColor = [UIColor mainColor];
        _secLaeble.layer.cornerRadius = 2;
        _secLaeble.layer.masksToBounds = true;
        _secLaeble.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_secLaeble];
        
        UIImageView *rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(mainScreenWidth - FitHeight(60), FitHeight(16.0), FitHeight(60.0), FitHeight(60.0))];
        rightArrow.image = [UIImage imageNamed:@"home_seckill_right_red_arrow"];
        rightArrow.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:rightArrow];
        
        _rightLable = [[UILabel alloc]initWithFrame:CGRectMake(_secLaeble.frame.origin.x + _secLaeble.frame.size.width, FitHeight(16.0), FitWith(230.0),  FitHeight(60.0))];
        _rightLable.textColor = [UIColor mainColor];
        _rightLable.font = CUSNEwFONT(14);
        _rightLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightLable];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, FitHeight(80.0), mainScreenWidth, FitHeight(320))];
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.contentSize = CGSizeMake(FitWith(220) * 10, 0);
        [self.contentView addSubview:_scrollView];
        
        _productViewArr = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            SeckillProductView *view = [[SeckillProductView alloc]initWithFrame:CGRectMake(i * FitWith(220) , 0, FitWith(220), FitHeight(320))];
            view.tag = i;
            view.userInteractionEnabled = true;
            view.layer.masksToBounds = true;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [view addGestureRecognizer:singleRecognizer];
            [_scrollView addSubview:view];
            [_productViewArr addObject:view];
        }
    }
    return self;
}

-(void)setupInfoWithSeckillArr:(NSArray *)itemArr{//SeckillListData
    _scrollView.contentSize = CGSizeMake(FitWith(220) * itemArr.count, 0);
    for (int i = 0; i < 10; i++) {
        SeckillProductView *view = _productViewArr[i];
        if (i < itemArr.count) {
            view.hidden = false;
            SeckillListData *item = itemArr[i];
            [view setupInfoWithSeckillListData:item];
        }else{
            view.hidden = true;
        }
    }
}

-(void)setupInfoWithRobSessionData:(RobSessionData *)robSession andRobProductDataArr:(NSMutableArray *)robProductArr showCutDown:(BOOL)showCutDown{
    _scrollView.contentSize = CGSizeMake(FitWith(220) * robProductArr.count, 0);
    _sessionlable.text = [NSString stringWithFormat:@"%@场",robSession.robSessionDisplay];
    if (robSession.robSessionName.length > 0) {
        _rightLable.text = robSession.robSessionName;
    }
    if (showCutDown) {
        _onlyOneLable.hidden = true;
        _hourLable.hidden = false;
        _cutLable.hidden = false;
        _minLable.hidden = false;
        _cutLable1.hidden = false;
        _secLaeble.hidden = false;
        [self setupInfoWithRobSessionData:robSession];
    }else{
        _onlyOneLable.hidden = false;
        _hourLable.hidden = true;
        _cutLable.hidden = true;
        _minLable.hidden = true;
        _cutLable1.hidden = true;
        _secLaeble.hidden = true;
    }
    for (int i = 0; i < 10; i++) {
        SeckillProductView *view = _productViewArr[i];
        if (i < robProductArr.count) {
            view.hidden = false;
            RobProductData *item = robProductArr[i];
            [view setupInfoWithRobProductData:item];
        }else{
            view.hidden = true;
        }
    }
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    SeckillSingleItemChickBlock block = _singleItemTapHandle;
    if (block) {
        block(tap.view.tag);
    }
}


-(void)setupInfoWithRobSessionData:(RobSessionData *)robSession{
    [self countDownWithFinishTimeStamp:robSession.countDown.longLongValue completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        if (day == 0 && hour == 0 && minute == 0 && second == 0) {
            
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
        if (day > 0) {
            hourStr = [NSString stringWithFormat:@"%ld",(long)hour + 24*day];
        }
        _hourLable.text = hourStr;
        _minLable.text = minuteStr;
        _secLaeble.text = secondStr;
    }];
}

-(void)countDownWithFinishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer != nil) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
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
