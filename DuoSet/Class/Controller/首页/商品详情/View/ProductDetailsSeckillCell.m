//
//  ProductDetailsSeckillCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/4.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailsSeckillCell.h"

@interface ProductDetailsSeckillCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIView *seckillBgView;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *originalPriceLable;
@property(nonatomic,strong) UILabel *buyCountLable;
@property(nonatomic,strong) UILabel *texLable;
@property(nonatomic,strong) UIImageView *teximgV;
@property(nonatomic,strong) UIButton *taxBtn;

@property(nonatomic,strong) UIView *countDownView;
@property(nonatomic,strong) UILabel *cutDownTipLable;
@property(nonatomic,strong) UILabel *cutDownTimeLable;


@property(nonatomic,retain) dispatch_source_t timer;

@property(nonatomic,strong) UILabel *productNameLable;
@property(nonatomic,strong) UILabel *productSubLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation ProductDetailsSeckillCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _seckillBgView = [UIView newAutoLayoutView];
        _seckillBgView.backgroundColor = [UIColor mainColor];
        [self.contentView addSubview:_seckillBgView];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor whiteColor];
        _priceLable.textAlignment = NSTextAlignmentLeft;
        _priceLable.font = CUSNEwFONT(22);
        [_seckillBgView addSubview:_priceLable];
        
        _originalPriceLable = [UILabel newAutoLayoutView];
        _originalPriceLable.textColor = [UIColor whiteColor];
        _originalPriceLable.textAlignment = NSTextAlignmentLeft;
        _originalPriceLable.font = CUSNEwFONT(16);
        [_seckillBgView addSubview:_originalPriceLable];
        
        _buyCountLable = [UILabel newAutoLayoutView];
        _buyCountLable.textColor = [UIColor whiteColor];
        _buyCountLable.textAlignment = NSTextAlignmentLeft;
        _buyCountLable.font = CUSNEwFONT(12);
        [_seckillBgView addSubview:_buyCountLable];
        
        _texLable = [UILabel newAutoLayoutView];
        _texLable.font = CUSNEwFONT(14);
        _texLable.textColor = [UIColor whiteColor];
        _texLable.hidden = true;
        _texLable.textAlignment = NSTextAlignmentLeft;
        [_seckillBgView addSubview:_texLable];
        
        _teximgV = [UIImageView newAutoLayoutView];
        _teximgV.image = [UIImage imageNamed:@"global_question_des_white"];
        _teximgV.hidden = true;
        [_seckillBgView addSubview:_teximgV];
        
        _taxBtn = [UIButton newAutoLayoutView];
        [_taxBtn addTarget:self action:@selector(texBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _taxBtn.hidden = true;
        [_seckillBgView addSubview:_taxBtn];
        
        _countDownView = [UIView newAutoLayoutView];
        _countDownView.backgroundColor = [UIColor colorFromHex:0xff7b33];
        [_seckillBgView addSubview:_countDownView];
        
        _cutDownTipLable = [UILabel newAutoLayoutView];
        _cutDownTipLable.textColor = [UIColor whiteColor];
        _cutDownTipLable.font = CUSNEwFONT(16);
        _cutDownTipLable.text = @"哆集秒杀";
        _cutDownTipLable.textAlignment = NSTextAlignmentCenter;
        [_countDownView addSubview:_cutDownTipLable];
        
        _cutDownTimeLable = [UILabel newAutoLayoutView];
        _cutDownTimeLable.textColor = [UIColor whiteColor];
        _cutDownTimeLable.font = CUSNEwFONT(14);
        _cutDownTimeLable.textAlignment = NSTextAlignmentCenter;
        [_countDownView addSubview:_cutDownTimeLable];
        
        _productNameLable = [UILabel newAutoLayoutView];
        _productNameLable.textColor = [UIColor colorFromHex:0x222222];
        _productNameLable.numberOfLines = 2;
        [self.contentView addSubview:_productNameLable];
        
        _productSubLable = [UILabel newAutoLayoutView];
        _productSubLable.textColor = [UIColor mainColor];
        _productSubLable.numberOfLines = 0;
        _productSubLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_productSubLable];
        
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
    
    RobProductData *robData = item.productNewRobResponse;

    NSString *text = [NSString stringWithFormat:@"￥%.2lf",robData.curDetailResponse.robPrice.floatValue];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(18) range:NSMakeRange(text.length - 2, 2)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 2, 2)];
    _priceLable.attributedText = attributeString;
    
    _buyCountLable.text = [NSString stringWithFormat:@"已抢%@件",item.productNewRobResponse.totalSellCount];
    if (item.robSessionResponse.countDown.length == 0) {
        _cutDownTimeLable.text = @"正在抢购中";
    }else{
        [self seckillStartHandleWithRobSessionData:item.robSessionResponse];
    }
    
    
    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",item.price];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldPrice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
    [attrStr setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                             NSBaselineOffsetAttributeName : @0,
                             NSStrikethroughColorAttributeName : [UIColor whiteColor]
                             }
                     range:NSMakeRange(0, length)];
    _originalPriceLable.attributedText = attrStr;
//    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",item.price];
//    NSUInteger length = [oldPrice length];
//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
//    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, length)];
//    [_originalPriceLable setAttributedText:attri];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSNEwFONT(17),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
    self.productNameLable.attributedText = attributedString;
    
    self.productSubLable.text = item.productSubName;
    
    if (item.isGlobal) {
        _taxBtn.hidden = false;
        _teximgV.hidden = false;
        _texLable.hidden = false;
        _texLable.text = [NSString stringWithFormat:@"进口税率：%@",item.tax];
    }
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
        NSString *allStr = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
        _cutDownTimeLable.text = [NSString stringWithFormat:@"距结束%@",allStr];
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
        
        [_seckillBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_seckillBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_seckillBgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_seckillBgView autoSetDimension:ALDimensionHeight toSize:FitHeight(100.0)];
        
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_priceLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_buyCountLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_priceLable withOffset:FitWith(30.0)];
        [_buyCountLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        [_originalPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_buyCountLable];
        [_originalPriceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_buyCountLable withOffset:-FitHeight(10.0)];
        
        [_texLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_buyCountLable];
        [_texLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_buyCountLable withOffset:FitWith(50.0)];
        
        [_teximgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_texLable];
        [_teximgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_texLable withOffset:FitWith(10.0)];
        
        [_taxBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_buyCountLable];
        [_taxBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_texLable];
        [_taxBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_teximgV];
        [_taxBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_countDownView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_countDownView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_countDownView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_countDownView autoSetDimension:ALDimensionWidth toSize:FitWith(214.0)];
        
        [_cutDownTipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20)];
        [_cutDownTipLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_cutDownTimeLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10)];
        [_cutDownTimeLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_productNameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_seckillBgView withOffset:FitHeight(30.0)];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_productSubLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productNameLable withOffset:FitHeight(20.0)];
        [_productSubLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productSubLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
