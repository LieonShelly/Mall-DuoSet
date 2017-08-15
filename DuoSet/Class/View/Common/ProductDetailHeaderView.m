//
//  ProductDetailHeaderView.m
//  DuoSet
//
//  Created by mac on 2017/1/20.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailHeaderView.h"
#import "SDCycleScrollView.h"
#import "ProductDetailsSeckillData.h"

@interface ProductDetailHeaderView()<SDCycleScrollViewDelegate>

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) SDCycleScrollView *headerImgV;

@property(nonatomic,strong) UIView *seckillBgView;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *originalPriceLable;
@property(nonatomic,strong) UILabel *buyCountLable;

@property(nonatomic,strong) UILabel *countDownTimeLable;
@property(nonatomic,strong) UIView *countDownView;
@property(nonatomic,strong) UILabel *buiedPercentLable;
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,retain) dispatch_source_t timer;

@end

static NSInteger autoScrollTime = 3;

@implementation ProductDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame AndProductDetailStyle:(ProductDetailStyle)status{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headerImgV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(690.0)) delegate:self placeholderImage:placeholderImage_372_440];
        _headerImgV.backgroundColor = [UIColor whiteColor];
        _headerImgV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headerImgV.pageDotColor = [UIColor whiteColor];
        _headerImgV.currentPageDotColor = [UIColor mainColor];
        _headerImgV.autoScrollTimeInterval = autoScrollTime;
        [self addSubview:_headerImgV];
        
        if (status == ProductDetailSeckill) {
            
            _headerImgV.pageControlBottomOffset = FitHeight(100.0);
            
            _seckillBgView = [UIView newAutoLayoutView];
            _seckillBgView.backgroundColor = [UIColor mainColor];
            [self addSubview:_seckillBgView];
            
            _priceLable = [UILabel newAutoLayoutView];
            _priceLable.textColor = [UIColor whiteColor];
            _priceLable.textAlignment = NSTextAlignmentLeft;
            _priceLable.font = CUSFONT(22);
            [_seckillBgView addSubview:_priceLable];
            
            _originalPriceLable = [UILabel newAutoLayoutView];
            _originalPriceLable.textColor = [UIColor whiteColor];
            _originalPriceLable.textAlignment = NSTextAlignmentLeft;
            _originalPriceLable.font = CUSFONT(8);
            [_seckillBgView addSubview:_originalPriceLable];
            
            _buyCountLable = [UILabel newAutoLayoutView];
            _buyCountLable.textColor = [UIColor whiteColor];
            _buyCountLable.textAlignment = NSTextAlignmentLeft;
            _buyCountLable.font = CUSFONT(8);
            [_seckillBgView addSubview:_buyCountLable];
            
            _countDownTimeLable = [UILabel newAutoLayoutView];
            _countDownTimeLable.textColor = [UIColor yellowColor];
            _countDownTimeLable.textAlignment = NSTextAlignmentRight;
            _countDownTimeLable.font = CUSFONT(9);
            [_seckillBgView addSubview:_countDownTimeLable];
            
            _countDownView = [UIView newAutoLayoutView];
            _countDownView.backgroundColor = [UIColor yellowColor];
            _countDownView.layer.cornerRadius = 2;
            _countDownView.layer.masksToBounds = true;
            [_seckillBgView addSubview:_countDownView];
            
            _buiedPercentLable = [UILabel newAutoLayoutView];
            _buiedPercentLable.textColor = [UIColor mainColor];
            _buiedPercentLable.textAlignment = NSTextAlignmentCenter;
            _buiedPercentLable.font = CUSFONT(8);
            [_countDownView addSubview:_buiedPercentLable];
            
            _imgV = [UIImageView newAutoLayoutView];
            _imgV.image = [UIImage imageNamed:@"lighting"];
            [_seckillBgView addSubview:_imgV];
            
            [self updateConstraints];
        }
    }
    return self;
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DetailImgChickBlock block = _imgTapHandle;
    if (block) {
        block(index);
    }
}

-(void)setupinfoWithImgArr:(NSArray *)imgArr{
    _headerImgV.imageURLStringsGroup = imgArr;
}

-(void)setupinfoWithProductDetailsData:(ProductDetailsData *)item{
    ProductDetailsSeckillData *seckillData = item.robResponse;
    _headerImgV.imageURLStringsGroup = item.showPics;
    
    NSString *text = [NSString stringWithFormat:@"￥%@",seckillData.robPrice];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSFONT(15) range:NSMakeRange(text.length - 2, 2)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 2, 2)];
    _priceLable.attributedText = attributeString;
    
    _buyCountLable.text = [NSString stringWithFormat:@"已抢%@件",item.buyedCount];
    CGFloat percent = (seckillData.buyCount.floatValue / seckillData.count.floatValue) *100;
    _buiedPercentLable.text = [NSString stringWithFormat:@"已抢%.2f%%",percent];
    [self seckillStartHandleWithProductDetailsSeckillData:seckillData];
    
    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",item.price];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, length)];
    [_originalPriceLable setAttributedText:attri];
}

-(void)seckillStartHandleWithProductDetailsSeckillData:(ProductDetailsSeckillData *)item{
    long long int nowSec = item.systemTime.longLongValue/1000;
    long long int endSec = item.endTime.longLongValue/1000;
    [self countDownWithStratTimeStamp:nowSec finishTimeStamp:endSec completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        if (day == 0 && hour == 0 && minute == 0 && second == 0) {
            _headerImgV.pageControlBottomOffset = 0;
            _seckillBgView.hidden = true;
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
        NSString *allStr = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
        _countDownTimeLable.text = [NSString stringWithFormat:@"距离结束%@",allStr];
    }];
}

-(void)countDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer==nil) {
        NSTimeInterval timeInterval = finishTimeStamp - starTimeStamp;
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

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_seckillBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_seckillBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_seckillBgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_seckillBgView autoSetDimension:ALDimensionHeight toSize:FitHeight(100.0)];
        
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        [_buyCountLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_priceLable withOffset:-FitWith(5)];
        [_buyCountLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_priceLable withOffset:FitWith(10.0)];
        
        [_originalPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_buyCountLable];
        [_originalPriceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_buyCountLable withOffset:-FitWith(5.0)];
        
        [_countDownTimeLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(50.0)];
        [_countDownTimeLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_countDownView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_countDownTimeLable];
        [_countDownView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(50.0)];
        [_countDownView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_countDownTimeLable withOffset:FitHeight(5)];
        [_countDownView autoSetDimension:ALDimensionHeight toSize:FitHeight(20.0)];
        
        [_buiedPercentLable autoPinEdgesToSuperviewEdges];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_countDownTimeLable withOffset:FitWith(5)];
        [_imgV autoSetDimension:ALDimensionWidth toSize:FitWith(20.0)];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
