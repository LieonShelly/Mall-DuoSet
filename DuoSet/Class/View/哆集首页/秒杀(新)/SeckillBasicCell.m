//
//  SeckillBasicCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillBasicCell.h"

@interface SeckillBasicCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *productImgV;
@property (nonatomic,strong) UILabel *productName;
@property (nonatomic,strong) UILabel *originalPriceLable;
@property (nonatomic,strong) UILabel *countLable;
@property (nonatomic,strong) UILabel *priceLable;
@property (nonatomic,strong) UIView *cutdownBgView;
@property (nonatomic,strong) UILabel *cutdownLable;
@property (nonatomic,strong) UIButton *buyBtn;
@property (nonatomic,strong) UIView *line;
@property(nonatomic,retain) dispatch_source_t timer;


@end

@implementation SeckillBasicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        _productImgV.layer.masksToBounds = true;
        [self.contentView addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.font = CUSFONT(13);
        _productName.textAlignment = NSTextAlignmentLeft;
        _productName.numberOfLines = 2;
        [self.contentView addSubview:_productName];
        
        _originalPriceLable = [UILabel newAutoLayoutView];
        _originalPriceLable.textColor = [UIColor colorFromHex:0x666666];
        _originalPriceLable.font = CUSFONT(12);
        _originalPriceLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_originalPriceLable];
        
        _countLable = [UILabel newAutoLayoutView];
        _countLable.textColor = [UIColor colorFromHex:0x666666];
        _countLable.font = CUSFONT(11);
        _countLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_countLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor colorFromHex:0x222222];
        _priceLable.font = CUSFONT(16);
        _priceLable.textAlignment = NSTextAlignmentLeft;
        _priceLable.numberOfLines = 1;
        [self.contentView addSubview:_priceLable];
        
        _cutdownBgView = [UIView newAutoLayoutView];
        _cutdownBgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_cutdownBgView];
        
        
        _cutdownLable = [UILabel newAutoLayoutView];
        _cutdownLable.text = @"00:54:39";
        _cutdownLable.textColor = [UIColor mainColor];
        _cutdownLable.font = CUSFONT(12);
        _cutdownLable.textAlignment = NSTextAlignmentCenter;
        [_cutdownBgView addSubview:_cutdownLable];
        
        _buyBtn = [UIButton newAutoLayoutView];
        _buyBtn.titleLabel.font = CUSFONT(13);
        [_buyBtn setTitle:@"已结束" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        _buyBtn.userInteractionEnabled = false;
        [_cutdownBgView addSubview:_buyBtn];
        
        _line = [UILabel newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithSeckillListData:(SeckillListData *)item{
    if (_timer != nil) {
        _timer = nil;
    }
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(13),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
    _productName.attributedText = attributedString;
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2lf",item.price.floatValue];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldPrice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
    [attrStr setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                             NSBaselineOffsetAttributeName : @0,
                             NSStrikethroughColorAttributeName : [UIColor colorFromHex:0x666666]
                             }
                     range:NSMakeRange(0, length)];
    _originalPriceLable.attributedText = attrStr;
//    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2lf",item.price.floatValue];
//    NSUInteger length = [oldPrice length];
//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
//    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorFromHex:0x666666] range:NSMakeRange(0, length)];
//    [_originalPriceLable setAttributedText:attri];
    
    
    
    _countLable.text = [NSString stringWithFormat:@"剩余%ld",item.count.integerValue - item.buyCount.integerValue];
    _countLable.hidden = item.status == SecKillisEnd;
    
    if (item.status == SeckillisOver) {//抢完了
        NSString *text = [NSString stringWithFormat:@"￥ %@",item.robPrice];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:CUSFONT(13) range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x222222] range:NSMakeRange(text.length - 2, 2)];
        }
        _priceLable.attributedText = attributeString;
        _cutdownBgView.layer.borderWidth = 0;
        [_buyBtn setTitle:@"已抢完" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buyBtn.backgroundColor = [UIColor colorFromHex:0x808080];
        _buyBtn.layer.cornerRadius = 3;
        _buyBtn.layer.borderWidth = 1;
        _buyBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        _countLable.text = @"剩余 0";
        _cutdownLable.hidden = true;
    }
    
    if (item.status == SecKillisEnd) {
        NSString *text = [NSString stringWithFormat:@"￥ %@",item.robPrice];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:CUSFONT(13) range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x222222] range:NSMakeRange(text.length - 2, 2)];
        }
        _priceLable.attributedText = attributeString;
        _cutdownBgView.layer.borderWidth = 0;
        _priceLable.textColor = [UIColor colorFromHex:0x222222];
        
        _buyBtn.layer.cornerRadius = 0;
        _buyBtn.layer.borderWidth = 0;
        
        _buyBtn.backgroundColor = [UIColor whiteColor];
        [_buyBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        [_buyBtn setTitle:@"已结束" forState:UIControlStateNormal];
        
        _cutdownLable.hidden = true;
    }
    if (item.status == SecKillWillBegin) {
        NSString *text = [NSString stringWithFormat:@"￥ %@",item.robPrice];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:CUSFONT(13) range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x222222] range:NSMakeRange(text.length - 2, 2)];
        }
        _priceLable.attributedText = attributeString;
        _priceLable.textColor = [UIColor colorFromHex:0x222222];
        _cutdownBgView.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        _cutdownBgView.layer.cornerRadius = 3;
        _cutdownBgView.layer.borderWidth = 1;
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn setTitle:@"未开始" forState:UIControlStateNormal];
        _buyBtn.layer.cornerRadius = 0;
        _buyBtn.backgroundColor = [UIColor colorFromHex:0x808080];
        _cutdownLable.textColor = [UIColor colorFromHex:0x808080];
        _cutdownLable.text = item.startTimeStr;
        
        long long int nowSec = item.systemTime.longLongValue/1000;
        long long int startSec = item.startTime.longLongValue/1000;
        [self countDownWithStratTimeStamp:nowSec finishTimeStamp:startSec completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            if (day == 0 && hour == 0 && minute == 0 && second == 0) {
                _cutdownBgView.layer.borderColor = [UIColor mainColor].CGColor;
                _cutdownBgView.layer.cornerRadius = 3;
                _cutdownBgView.layer.borderWidth = 1;
                [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_buyBtn setTitle:@"马上抢" forState:UIControlStateNormal];
                _buyBtn.backgroundColor = [UIColor mainColor];
                _priceLable.textColor = [UIColor mainColor];
                [self seckillStartHandleWithSeckillListData:item];
            }
        }];
    }
    if (item.status == SecKillBedoing) {
        NSString *text = [NSString stringWithFormat:@"￥ %@",item.robPrice];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:CUSFONT(13) range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
        }
        _priceLable.attributedText = attributeString;
        _priceLable.textColor = [UIColor mainColor];
        _cutdownBgView.layer.borderColor = [UIColor mainColor].CGColor;
        _cutdownBgView.layer.cornerRadius = 3;
        _cutdownBgView.layer.borderWidth = 1;
        _buyBtn.layer.cornerRadius = 0;
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn setTitle:@"马上抢" forState:UIControlStateNormal];
        _buyBtn.backgroundColor = [UIColor mainColor];
        [self seckillStartHandleWithSeckillListData:item];
        _cutdownLable.textColor = [UIColor mainColor];
        _cutdownLable.hidden = false;
    }
}

-(void)seckillStartHandleWithSeckillListData:(SeckillListData *)item{
    long long int nowSec = item.systemTime.longLongValue/1000;
    long long int endSec = item.endTime.longLongValue/1000;
    [self countDownWithStratTimeStamp:nowSec finishTimeStamp:endSec completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        if (day == 0 && hour == 0 && minute == 0 && second == 0) {
            _priceLable.textColor = [UIColor colorFromHex:0x222222];
            _cutdownBgView.layer.borderWidth = 0;
            [_buyBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
            [_buyBtn setTitle:@"已结束" forState:UIControlStateNormal];
            _buyBtn.backgroundColor = [UIColor whiteColor];
            _cutdownLable.hidden = true;
            _countLable.hidden = true;
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
        _cutdownLable.text = allStr;
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
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(24.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(220.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(220.0)];
        
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(30.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_originalPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_originalPriceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productName withOffset:FitHeight(30.0)];
        
        [_countLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_originalPriceLable];
        [_countLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(550.0)];
        
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_priceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_originalPriceLable withOffset:FitHeight(30.0)];
        
        [_cutdownBgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_cutdownBgView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_priceLable];
        [_cutdownBgView autoSetDimension:ALDimensionWidth toSize:FitWith(250.0)];
        [_cutdownBgView autoSetDimension:ALDimensionHeight toSize:FitHeight(70.0)];
        
        [_buyBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_buyBtn autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_buyBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(70.0)];
        [_buyBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:1];
        
        [_cutdownLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_buyBtn];
        [_cutdownLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_buyBtn];
        [_cutdownLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_buyBtn withOffset:0];
        [_cutdownLable autoSetDimension:ALDimensionWidth toSize:FitWith(130.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    
    [super updateConstraints];
}
@end
