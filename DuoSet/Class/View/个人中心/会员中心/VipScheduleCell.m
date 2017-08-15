//
//  VipScheduleCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "VipScheduleCell.h"

@interface VipScheduleCell()

@property(nonatomic,strong) UIButton *copperImg;
@property(nonatomic,strong) UILabel *copperLablel;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIButton *silverImg;
@property(nonatomic,strong) UILabel *silverLablel;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIButton *glodImg;
@property(nonatomic,strong) UILabel *glodLablel;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) UIButton *diamondImg;
@property(nonatomic,strong) UILabel *diamondLablel;
@property(nonatomic,strong) UIView *line4;

@property(nonatomic,strong) UIButton *kingImg;
@property(nonatomic,strong) UILabel *kingLablel;
@property(nonatomic,strong) UIView *fillView;


@property(nonatomic,strong) NSMutableArray *imgVArr;
@property(nonatomic,strong) NSArray *normalImgVArr;
@property(nonatomic,strong) NSArray *seletcedImgVArr;
@property (nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation VipScheduleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _imgVArr = [NSMutableArray array];
        
        _copperImg = [[UIButton alloc]init];
        [_imgVArr addObject:_copperImg];
        _silverImg = [[UIButton alloc]init];
        [_imgVArr addObject:_silverImg];
        _glodImg = [[UIButton alloc]init];
        [_imgVArr addObject:_glodImg];
        _diamondImg = [[UIButton alloc]init];
        [_imgVArr addObject:_diamondImg];
        _kingImg = [[UIButton alloc]init];
        [_imgVArr addObject:_kingImg];
        
        _normalImgVArr = @[@"user_center_vip_copper_normal",@"user_center_vip_silver_normal",@"user_center_vip_gold_normal",@"user_center_vip_diamond_normal",@"user_center_vip_king_normal"];
        _seletcedImgVArr = @[@"user_center_vip_copper_seletced",@"user_center_vip_silver_seletced",@"user_center_vip_gold_seletced",@"user_center_vip_diamond_seletced",@"user_center_vip_king_seletced"];
        
        for (int i = 0; i < 5; i++) {
            UIButton *btn = _imgVArr[i];
            [btn setBackgroundImage:[UIImage imageNamed:@"vip_bg_enalble"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"vip_bg_normal"] forState:UIControlStateSelected];
            btn.tag = i + 1;
            [btn setImage:[UIImage imageNamed:_normalImgVArr[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:_seletcedImgVArr[i]] forState:UIControlStateSelected];
            btn.frame = CGRectMake(FitWith(26.0) + (FitWith(160.0) * i), FitHeight(44.0), FitHeight(50.0), FitHeight(50.0));
            [self.contentView addSubview:btn];
        }
        CGFloat line1x = _copperImg.frame.origin.x + _copperImg.frame.size.width;
        CGFloat y = _copperImg.center.y;
        CGFloat w = FitWith(110.0);
        CGFloat h = 2;
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(line1x, y, w, h)];
        _line1.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [self addSubview:_line1];
        
        CGFloat line2x = _silverImg.frame.origin.x + _silverImg.frame.size.width;
        _line2 = [[UIView alloc]initWithFrame:CGRectMake(line2x, y, w, h)];
        _line2.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [self addSubview:_line2];
        
        CGFloat line3x = _glodImg.frame.origin.x + _glodImg.frame.size.width;
        _line3 = [[UIView alloc]initWithFrame:CGRectMake(line3x, y, w, h)];
        _line3.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [self addSubview:_line3];
        
        CGFloat line4x = _diamondImg.frame.origin.x + _diamondImg.frame.size.width;
        _line4 = [[UIView alloc]initWithFrame:CGRectMake(line4x, y, w, h)];
        _line4.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [self addSubview:_line4];
        
        _copperLablel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, FitWith(100.0), FitHeight(36.0))];
        _copperLablel.center = CGPointMake(_copperImg.center.x, FitHeight(130.0));
        _copperLablel.font = CUSFONT(12);
        _copperLablel.textAlignment = NSTextAlignmentCenter;
        _copperLablel.textColor = [UIColor colorFromHex:0x222222];
        _copperLablel.text = @"铜牌";
        [self addSubview:_copperLablel];
        
        _silverLablel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, FitWith(100.0), FitHeight(36.0))];
        _silverLablel.center = CGPointMake(_silverImg.center.x, FitHeight(130.0));
        _silverLablel.font = CUSFONT(12);
        _silverLablel.textColor = [UIColor colorFromHex:0x222222];
        _silverLablel.text = @"银牌";
        _silverLablel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_silverLablel];
        
        _glodLablel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, FitWith(100.0), FitHeight(36.0))];
        _glodLablel.center = CGPointMake(_glodImg.center.x, FitHeight(130.0));
        _glodLablel.font = CUSFONT(12);
        _glodLablel.textColor = [UIColor colorFromHex:0x222222];
        _glodLablel.text = @"金牌";
        _glodLablel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_glodLablel];
        
        _diamondLablel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, FitWith(100.0), FitHeight(36.0))];
        _diamondLablel.center = CGPointMake(_diamondImg.center.x, FitHeight(130.0));
        _diamondLablel.font = CUSFONT(12);
        _diamondLablel.textColor = [UIColor colorFromHex:0x222222];
        _diamondLablel.text = @"钻石";
        _diamondLablel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_diamondLablel];
        
        _kingLablel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, FitWith(100.0), FitHeight(36.0))];
        _kingLablel.center = CGPointMake(_kingImg.center.x, FitHeight(130.0));
        _kingLablel.font = CUSFONT(12);
        _kingLablel.textColor = [UIColor colorFromHex:0x222222];
        _kingLablel.text = @"皇冠";
        _kingLablel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_kingLablel];
        
    }
    return self;
}

-(void)setupInfoWithVipData:(VipData *)item{
    switch (item.vipLevel.integerValue) {//0xf75d2d
        case 1:{
            _line1.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
            if (item.vipLevels.count < 2) {
                break;
            }
            VipLevelData *level = item.vipLevels[1];
            long end = level.endValue;
            CGFloat fillLineW = ((CGFloat)item.vipValue/end) * _line1.frame.size.width ;
            _fillView = [[UIView alloc]init];
            _fillView.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _fillView.frame = CGRectMake(_line1.frame.origin.x, _line1.frame.origin.y,fillLineW, 2);
            [self addSubview:_fillView];
            break;
            }
        case 2:{
            _line1.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            if (item.vipLevels.count < 3) {
                break;
            }
            VipLevelData *level = item.vipLevels[2];
            long end = level.endValue - level.startValue;
            CGFloat fillLineW = ((CGFloat)(item.vipValue - level.startValue)/end) * _line1.frame.size.width ;
            _fillView = [[UIView alloc]init];
            _fillView.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _fillView.frame = CGRectMake(_line2.frame.origin.x, _line2.frame.origin.y,fillLineW, 2);
            [self addSubview:_fillView];
        }
            break;
        case 3:{
            _line1.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _line2.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            if (item.vipLevels.count < 4) {
                break;
            }
            VipLevelData *level = item.vipLevels[3];
            long end = level.endValue - level.startValue;
            CGFloat fillLineW = ((CGFloat)(item.vipValue - level.startValue)/end) * _line1.frame.size.width ;
            _fillView = [[UIView alloc]init];
            _fillView.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _fillView.frame = CGRectMake(_line3.frame.origin.x, _line3.frame.origin.y,fillLineW, 2);
            [self addSubview:_fillView];
        }
            break;
        case 4:{
            _line1.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _line2.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _line3.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            if (item.vipLevels.count < 4) {
                break;
            }
            VipLevelData *level = item.vipLevels[3];
            long end = level.endValue - level.startValue;
            CGFloat fillLineW = ((CGFloat)(item.vipValue - level.startValue)/end) * _line1.frame.size.width ;
            _fillView = [[UIView alloc]init];
            _fillView.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _fillView.frame = CGRectMake(0,0,fillLineW, 2);
            [_line4 addSubview:_fillView];
            break;
        }
            break;
        case 5:{
            _line1.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _line2.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _line3.backgroundColor = [UIColor colorFromHex:0xf75d2d];
            _line4.backgroundColor = [UIColor colorFromHex:0xf75d2d];
        }
            break;
            
        default:
            break;
    }
    for (int i = 0 ; i < 5; i++) {
        UIButton *btn = _imgVArr[i];
        btn.selected = btn.tag <= item.vipLevel.integerValue;
        if (btn.tag == item.vipLevel.integerValue) {
            [btn setBackgroundImage:[UIImage imageNamed:@"vip_bg_seletced"] forState:UIControlStateSelected];
            btn.frame = CGRectMake(FitWith(26.0) + (FitWith(160.0) * i), FitHeight(34.0), FitHeight(70.0), FitHeight(70.0));
            [self bringSubviewToFront:btn];
        }
    }
}

@end
