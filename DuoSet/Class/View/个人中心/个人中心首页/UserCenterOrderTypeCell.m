//
//  UserCenterOrderTypeCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserCenterOrderTypeCell.h"

@interface UserCenterOrderTypeCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *btnArr;
@property (nonatomic,strong) NSMutableArray *btnNameArr;
@property (nonatomic,strong) NSArray *btnImgArr;
@property (nonatomic,strong) NSMutableArray *unredCountArr;
@property(nonatomic, strong) UIView *bgView;
@end

@implementation UserCenterOrderTypeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bgView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf3f3f3];
        _btnArr = [NSMutableArray array];
        _btnNameArr = [NSMutableArray arrayWithObjects:@"待付款",@"待收货",@"待评价",@"退换货",@"全部订单", nil];
        _btnImgArr = @[@"user_center_waitPay", @"user_center_waitting_send", @"user_center_wait_comment", @"user_center_exchange", @"user_center_allorder"];
        
        _unredCountArr = [NSMutableArray array];
        for (int i = 0 ; i < _btnNameArr.count; i++) {
            UIButton *btn = [UIButton newAutoLayoutView];
            btn.contentMode = UIViewContentModeCenter;
            btn.titleLabel.font = CUSFONT(11);
            btn.tag = i;
            [btn setTitle:_btnNameArr[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:_btnImgArr[i]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
            
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-FitHeight(20.0), 0, 0, -FitWith(110.0))];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -FitWith(30.0), -FitWith(100.0), 0)];
            if (i == 4) {
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -FitWith(60.0), -FitWith(100.0), 0)];
            }
            if (IS_IPHONE5) {
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -FitWith(50.0), -FitWith(100.0), 0)];
                if (i == 4) {
                    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -FitWith(65.0), -FitWith(100.0), 0)];
                }
            }
            [_btnArr addObject:btn];
            [btn addTarget:self action:@selector(orderChoice:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:btn];
            
            UILabel *label = [UILabel newAutoLayoutView];
            label.backgroundColor = [UIColor mainColor];
            label.textColor = [UIColor whiteColor];
            label.font = CUSFONT(8);
            label.adjustsFontSizeToFitWidth = true;
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.cornerRadius = FitWith(40.0) * 0.5;
            label.layer.masksToBounds = true;
            label.hidden = true;
            [btn addSubview:label];
            [_unredCountArr addObject:label];

        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)orderChoice:(UIButton *)btn{
    OrderTypeChoiceBlock block = _choiceHanlde;
    if (block) {
        block(btn.tag);
    }
}

-(void)clearCount{
    for (int i = 0; i < _btnNameArr.count; i++) {
        UILabel *label = _unredCountArr[i];
        label.hidden = true;
    }
}

-(void)setupInfoWithUserCenterMainData:(UserCenterMainData *)item{
    NSArray *arr = @[item.waitPayCount,item.waitResiveCount,item.waitCommentCount,item.exchangeAndReturnCount];
    for (int i = 0; i < _btnNameArr.count - 1; i++) {
        UILabel *label = _unredCountArr[i];
        if (((NSString *)arr[i]).integerValue == 0) {
            label.hidden = true;
        }else{
            label.hidden = false;
            if (((NSString *)arr[i]).integerValue > 99) {
                label.text = @"99+";
            }else{
                label.text = arr[i];
            }
        }
    }
  
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
        for (int i = 0 ; i < _btnNameArr.count; i++) {
            UIButton *btn = _btnArr[i];
            [btn autoSetDimension:ALDimensionWidth toSize:mainScreenWidth/5];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth/5) * i - 20];
            
            UILabel *label = _unredCountArr[i];
            [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(40.0)];
            [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
            [label autoSetDimension:ALDimensionWidth toSize:FitWith(40.0)];
            [label autoSetDimension:ALDimensionHeight toSize:FitWith(40.0)];
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.bgView.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.contentView.bounds.size.height - 20, self.contentView.bounds.size.width - 2 * 12, 5)].CGPath;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
//        UIColor *clr = [UIColor grayColor];
//        _bgView.layer.shadowColor = clr.CGColor;
//        _bgView.layer.shadowOffset = CGSizeMake(0,0);
//        _bgView.layer.shadowOpacity = 0.5;
//        _bgView.layer.shadowRadius = 2;
//        _bgView.layer.shadowColor = [UIColor grayColor].CGColor;
//        _bgView.layer.shadowRadius = 5;
//        _bgView.layer.shadowOpacity = 0.3;
//        _bgView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _bgView;
}

@end
