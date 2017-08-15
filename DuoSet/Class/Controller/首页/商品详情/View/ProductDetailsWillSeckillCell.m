//
//  ProductDetailsWillSeckillCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailsWillSeckillCell.h"

@interface ProductDetailsWillSeckillCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *productNameLable;
@property(nonatomic,strong) UILabel *productSubLable;
@property(nonatomic,strong) UILabel *productPriceLable;
@property(nonatomic,strong) UILabel *texLable;
@property(nonatomic,strong) UIImageView *teximgV;
@property(nonatomic,strong) UIButton *taxBtn;
@property(nonatomic,strong) UILabel *payCountLable;
@property(nonatomic,strong) UILabel *seckillTagView;
@property(nonatomic,strong) UILabel *tipLable;
@property(nonatomic,strong) UILabel *hourLable;
@property(nonatomic,strong) UILabel *cutLable;
@property(nonatomic,strong) UILabel *minLable;
@property(nonatomic,strong) UILabel *cutLable2;
@property(nonatomic,strong) UILabel *secLable;

@property(nonatomic,strong) UIView *line;
@property(nonatomic,retain) dispatch_source_t timer;

@end

@implementation ProductDetailsWillSeckillCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _productNameLable = [UILabel newAutoLayoutView];
        _productNameLable.textColor = [UIColor colorFromHex:0x222222];
        _productNameLable.numberOfLines = 2;
        [self.contentView addSubview:_productNameLable];
        
        _productSubLable = [UILabel newAutoLayoutView];
        _productSubLable.textColor = [UIColor mainColor];
        _productSubLable.numberOfLines = 0;
        _productSubLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_productSubLable];
        
        _productPriceLable = [UILabel newAutoLayoutView];
        _productPriceLable.textColor = [UIColor mainColor];
        _productPriceLable.font = CUSFONT(18);
        _productPriceLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_productPriceLable];
        
        _texLable = [UILabel newAutoLayoutView];
        _texLable.font = CUSNEwFONT(14);
        _texLable.hidden = true;
        _texLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_texLable];
        
        _teximgV = [UIImageView newAutoLayoutView];
        _teximgV.image = [UIImage imageNamed:@"global_question_des"];
        _teximgV.hidden = true;
        [self.contentView addSubview:_teximgV];
        
        _taxBtn = [UIButton newAutoLayoutView];
        [_taxBtn addTarget:self action:@selector(texBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _taxBtn.hidden = true;
        [self.contentView addSubview:_taxBtn];
        
        _payCountLable = [UILabel newAutoLayoutView];
        _payCountLable.textAlignment = NSTextAlignmentRight;
        _payCountLable.font = CUSFONT(11);
        _payCountLable.textColor = [UIColor colorFromHex:0x808080];
        [self.contentView addSubview:_payCountLable];
        
        _seckillTagView = [UILabel newAutoLayoutView];
        _seckillTagView.text = @"哆集秒杀";
        _seckillTagView.textColor = [UIColor mainColor];
        _seckillTagView.font = CUSNEwFONT(13);
        _seckillTagView.layer.borderColor = [UIColor mainColor].CGColor;
        _seckillTagView.layer.borderWidth = 0.5;
        _seckillTagView.layer.cornerRadius = 2;
        [self.contentView addSubview:_seckillTagView];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.text = @"距本场开始时间";
        _tipLable.textColor = [UIColor mainColor];
        _tipLable.font = CUSNEwFONT(14);
        [self.contentView addSubview:_tipLable];
        
        _hourLable = [UILabel newAutoLayoutView];
        _hourLable.textAlignment = NSTextAlignmentCenter;
        _hourLable.backgroundColor = [UIColor mainColor];
        _hourLable.textColor = [UIColor whiteColor];
        _hourLable.font = CUSNEwFONT(14);
        _hourLable.layer.cornerRadius = 2;
        _hourLable.layer.masksToBounds = true;
        _hourLable.adjustsFontSizeToFitWidth = true;
        [self addSubview:_hourLable];
        
        _cutLable = [UILabel newAutoLayoutView];
        _cutLable.text = @":";
        _cutLable.textAlignment = NSTextAlignmentCenter;
        _cutLable.textColor = [UIColor mainColor];
        _cutLable.backgroundColor = [UIColor whiteColor];
        [self addSubview:_cutLable];
        
        _minLable = [UILabel newAutoLayoutView];
        _minLable.backgroundColor = [UIColor mainColor];
        _minLable.textAlignment = NSTextAlignmentCenter;
        _minLable.textColor = [UIColor whiteColor];
        _minLable.font = CUSNEwFONT(14);
        _minLable.layer.cornerRadius = 2;
        _minLable.layer.masksToBounds = true;
        _minLable.adjustsFontSizeToFitWidth = true;
        [self addSubview:_minLable];
        
        _cutLable2 = [UILabel newAutoLayoutView];
        _cutLable2.text = @":";
        _cutLable2.textColor = [UIColor mainColor];
        _cutLable2.backgroundColor = [UIColor whiteColor];
        _cutLable2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_cutLable2];
        
        _secLable = [UILabel newAutoLayoutView];
        _secLable.backgroundColor = [UIColor mainColor];
        _secLable.textAlignment = NSTextAlignmentCenter;
        _secLable.textColor = [UIColor whiteColor];
        _secLable.font = CUSNEwFONT(16);
        _secLable.layer.cornerRadius = 2;
        _secLable.layer.masksToBounds = true;
        _secLable.adjustsFontSizeToFitWidth = true;
        [self addSubview:_secLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)texBtnAction{
    TexButtonActionBlock block = _texBtnHandle;
    if (block) {
        block();
    }
}

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSNEwFONT(17),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
    self.productNameLable.attributedText = attributedString;
    
    if (item.productSubName.length > 0) {
        NSMutableParagraphStyle *subparagraphStyle = [[NSMutableParagraphStyle alloc] init];
        subparagraphStyle.lineSpacing = 3;
        NSDictionary *subAttributes = @{
                                        NSFontAttributeName:CUSNEwFONT(15),
                                        NSParagraphStyleAttributeName:paragraphStyle
                                        };
        
        NSMutableAttributedString *subAttributedString =  [[NSMutableAttributedString alloc] initWithString:item.productSubName attributes:subAttributes];
        [subAttributedString addAttribute:NSParagraphStyleAttributeName value:subparagraphStyle range:NSMakeRange(0,item.productSubName.length)];
        self.productSubLable.attributedText = subAttributedString;
    }else{
        self.productSubLable.text = @"";
    }
    
    NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSFONT(14) range:NSMakeRange(text.length - 2, 2)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 2, 2)];
    _productPriceLable.attributedText = attributeString;
    _payCountLable.text = [NSString stringWithFormat:@"%@人付款",item.buyedCount];
    
    if (item.isGlobal) {
        _taxBtn.hidden = false;
        _teximgV.hidden = false;
        _texLable.hidden = false;
        _texLable.text = [NSString stringWithFormat:@"进口税率：%@",item.tax];
    }
    
    [self seckillStartHandleWithRobSessionData:item.robSessionResponse];
}

-(void)seckillStartHandleWithRobSessionData:(RobSessionData *)item{
    [self countDownWithFinishTimeStamp:item.countDown.longLongValue completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
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
        _secLable.text = secondStr;
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

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_productSubLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productNameLable withOffset:FitHeight(10.0)];
        [_productSubLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productSubLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_productPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productNameLable];
        [_productPriceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productSubLable withOffset:FitHeight(10.0)];
        
        [_texLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPriceLable];
        [_texLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(250.0)];
        
        [_teximgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_texLable];
        [_teximgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_texLable withOffset:FitWith(10.0)];
        
        [_taxBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPriceLable];
        [_taxBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_texLable];
        [_taxBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_teximgV];
        [_taxBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_payCountLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPriceLable];
        [_payCountLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_seckillTagView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_seckillTagView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productPriceLable withOffset:FitHeight(22.0)];
        
        [_tipLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seckillTagView];
        [_tipLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_seckillTagView withOffset:FitWith(38.0)];
        
        [_hourLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tipLable withOffset:FitWith(30.0)];
        [_hourLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seckillTagView];
        [_hourLable autoSetDimension:ALDimensionWidth toSize:FitWith(36.0)];
        [_hourLable autoSetDimension:ALDimensionHeight toSize:FitHeight(31.0)];
        
        [_cutLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_hourLable];
        [_cutLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seckillTagView];
        [_cutLable autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_hourLable];
        [_cutLable autoSetDimension:ALDimensionWidth toSize:FitWith(10.0)];
        
        [_minLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_cutLable];
        [_minLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seckillTagView];
        [_minLable autoSetDimension:ALDimensionWidth toSize:FitWith(36.0)];
        [_minLable autoSetDimension:ALDimensionHeight toSize:FitHeight(31.0)];
        
        [_cutLable2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_minLable];
        [_cutLable2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seckillTagView];
        [_cutLable2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_hourLable];
        [_cutLable2 autoSetDimension:ALDimensionWidth toSize:FitWith(10.0)];
        
        [_secLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_cutLable2];
        [_secLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seckillTagView];
        [_secLable autoSetDimension:ALDimensionWidth toSize:FitWith(36.0)];
        [_secLable autoSetDimension:ALDimensionHeight toSize:FitHeight(31.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
