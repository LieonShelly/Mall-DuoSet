//
//  UserCenterInfoCell.m
//  DuoSet
//
//  Created by lieon on 2017/6/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserCenterInfoCell.h"
#import "UIFont+Name.h"

@interface UserCenterInfoCell()
@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIButton *levelBtn;
@property(nonatomic, strong) NSMutableArray<UILabel*> *countLabelArray;
@property(nonatomic, strong) NSMutableArray<NSString*> *countNumArray;
@property(nonatomic, strong) NSMutableArray<UILabel*> *classnameLabel;
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *shadowView;
@property(nonatomic, strong) UIImageView *redView;
@property (nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic, strong) UIView *iconShadowView;
@property(nonatomic, strong) NSMutableArray<UILabel*>  *actionLabel;
@end

@implementation UserCenterInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf3f3f3];
        [self.contentView addSubview:self.shadowView];
        [self.contentView addSubview:self.redView];
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.iconShadowView];
        [self.iconShadowView addSubview:self.iconView];
        [self.bgView addSubview:self.nameLabel];
        [self.bgView addSubview:self.levelBtn];
        for (UILabel* label in self.countLabelArray) {
            [self.bgView addSubview:label];
        }
        for (UILabel * label in self.classnameLabel) {
            [self.bgView addSubview:label];
        }
        for (UILabel * label in self.actionLabel) {
            [self.bgView addSubview:label];
        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return  self;
}

-(void)avtarAciton{
    UserCenterAvatarTapBlock block = _avatarHandle;
    if (block) {
        block();
    }
}

-(void)accountAction{
    UserCenterAccountTapBlock block = _accountHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
       [self.redView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.redView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [self.redView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [self.redView autoSetDimension:ALDimensionHeight toSize:40];
        
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
        
        [self.shadowView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
        [self.shadowView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [self.shadowView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        [self.shadowView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
        
        [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        
        [self.iconShadowView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [self.iconShadowView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.iconShadowView autoSetDimensionsToSize:CGSizeMake(FitWith(120), FitWith(120))];
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconShadowView withOffset:25];
        [self.nameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.iconShadowView];
        [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:100];
        [self.levelBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [self.levelBtn autoSetDimension:ALDimensionWidth toSize:80];
        [self.levelBtn autoSetDimension:ALDimensionHeight toSize:25];
        [self.levelBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
        for (int i = 0 ; i < 4; i++) {
            UILabel *countLable = _countLabelArray[i];
            [countLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth/4) * i - 10];
            [countLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.iconShadowView withOffset:15];
            [countLable autoSetDimension:ALDimensionWidth toSize:mainScreenWidth/4];
            
            UILabel *classLable = _classnameLabel[i];
            [classLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth / 4) *i - 10];
            [classLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:countLable withOffset:5];
            [classLable autoSetDimension:ALDimensionWidth toSize:mainScreenWidth/4];
            
            UILabel * actionLabel = _actionLabel[i];
             [actionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:countLable withOffset:0];
             [actionLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:countLable withOffset:0];
             [actionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:countLable withOffset:0];
             [actionLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:classLable withOffset:0];
    
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)setupInfoWithUserCenterMainData:(UserCenterMainData *)item{
    UserInfo *info = [Utils getUserInfo];
    if (info.name) {
       self.nameLabel.text = info.name;
    }else{
        self.nameLabel.text = @"登录/注册";
    }
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:placeholderImage_avatar options:0];
    NSString *balanceStr = @"";
    if (item.balance.floatValue == 0.0) {
        balanceStr = @"0";
    }else{
        balanceStr = [NSString stringWithFormat:@"%.2lf",item.balance.floatValue];
    }
   _countNumArray = [NSMutableArray arrayWithObjects:item.pointCount,item.couponCodeCount,item.collectCount,balanceStr, nil];
    for (int i = 0; i < 4; i++) {
        UILabel *countLable = self.countLabelArray[i];
        countLable.text = _countNumArray[i];
    }
    _levelBtn.hidden = false;
    if (item.vipLevel.integerValue == 1) {//铜牌
        [_levelBtn setImage:[UIImage imageNamed:@"user_center_vip_copper_seletced"] forState:UIControlStateNormal];
        [_levelBtn setTitle:@"铜牌会员" forState:UIControlStateNormal];
    }
    if (item.vipLevel.integerValue == 2) {//银牌
        [_levelBtn setImage:[UIImage imageNamed:@"user_center_vip_silver_seletced"] forState:UIControlStateNormal];
        [_levelBtn setTitle:@"银牌会员" forState:UIControlStateNormal];
    }
    if (item.vipLevel.integerValue == 3) {//金牌
        [_levelBtn setImage:[UIImage imageNamed:@"user_center_vip_gold_seletced"] forState:UIControlStateNormal];
        [_levelBtn setTitle:@"金牌会员" forState:UIControlStateNormal];
    }
    if (item.vipLevel.integerValue == 4) {//钻石
        [_levelBtn setImage:[UIImage imageNamed:@"user_center_vip_diamond_seletced"] forState:UIControlStateNormal];
        [_levelBtn setTitle:@"钻石会员" forState:UIControlStateNormal];
    }
    if (item.vipLevel.integerValue == 5) {//皇冠
        [_levelBtn setImage:[UIImage imageNamed:@"user_center_vip_king_seletced"] forState:UIControlStateNormal];
        [_levelBtn setTitle:@"皇冠会员" forState:UIControlStateNormal];
    }
    
}

-(void)clearUserCountData{
    _countNumArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    for (int i = 0; i < 4; i++) {
        UILabel *countLable = _countLabelArray[i];
        countLable.text = _countNumArray[i];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.contentView.bounds.size.height - 20, self.contentView.bounds.size.width - 2 * 12, 5)].CGPath;
}

- (UIImageView *)redView {
    if (_redView == nil) {
        _redView = [UIImageView newAutoLayoutView];
        _redView.image = [UIImage imageNamed:@"piazza_header_bgView"];
        _redView.clipsToBounds = true;
    }
    return _redView;
}

- (UIView *)iconShadowView {
    if (_iconShadowView == nil) {
        _iconShadowView = [UIView newAutoLayoutView];
        _iconShadowView.backgroundColor = [UIColor clearColor];
        _iconShadowView.layer.shadowColor = [UIColor grayColor].CGColor;
        _iconShadowView.layer.shadowRadius = 5;
        _iconShadowView.layer.shadowOpacity = 0.5;
        _iconShadowView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _iconShadowView;
}

- (UIView *)shadowView {
    if (_shadowView == nil) {
        _shadowView = [UIView newAutoLayoutView];
        _shadowView.backgroundColor = [UIColor redColor];
        UIColor *clr = [UIColor blueColor];
        _shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
        _shadowView.layer.shadowRadius = 5;
        _shadowView.layer.shadowOpacity = 0.3;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _shadowView;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        UIColor *clr = [UIColor grayColor];
        _bgView.clipsToBounds = false;
        
    }
    return _bgView;
}

- (UIImageView *)iconView {
    if (_iconView == nil) {
         UserInfo *info = [Utils getUserInfo];
        _iconView = [UIImageView newAutoLayoutView];
        [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:placeholderImage_avatar options:0];
        _iconView.layer.cornerRadius = FitWith(120) * 0.5;
        _iconView.layer.borderWidth = 2;
        _iconView.layer.masksToBounds = true;
        _iconView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:1].CGColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avtarAciton)];
        _iconView.userInteractionEnabled = true;
        [_iconView addGestureRecognizer:tap];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel newAutoLayoutView];
        UserInfo *info = [Utils getUserInfo];
        if (info.name) {
            _nameLabel.text = info.name;
        }else{
            _nameLabel.text = @"登录/注册";
        }
        _nameLabel.font = [UIFont boldSystemFontOfSize:13];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor colorFromHex:0x222222];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(accountAction)];
        [_nameLabel addGestureRecognizer:tap];
        _nameLabel.userInteractionEnabled = true;
    }
    return _nameLabel;
}

- (UIButton *)levelBtn {
    if (_levelBtn == nil) {
       
        _levelBtn = [UIButton newAutoLayoutView];
        _levelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _levelBtn.titleLabel.textColor = [UIColor colorFromHex:0xfffefe];
        _levelBtn.contentMode = UIViewContentModeCenter;
        _levelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5 * 2, 0, 0);
        [_levelBtn setBackgroundImage:[UIImage imageNamed:@"user_center_level_bg"] forState:UIControlStateNormal];
        [_levelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_levelBtn addTarget:self action:@selector(vipAction) forControlEvents:UIControlEventTouchUpInside];
        _levelBtn.hidden = true;
    }
    return _levelBtn;
}

- (NSMutableArray<NSString *> *)countNumArray {
    if (_countNumArray == nil) {
        _countNumArray = [NSMutableArray arrayWithArray:@[@"0", @"0", @"0", @"0"]];
    }
    return _countNumArray;
}

- (NSMutableArray<UILabel *> *)countLabelArray {
    if (_countLabelArray == nil) {
        _countLabelArray = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            UILabel * label = [UILabel newAutoLayoutView];
            label.font = [UIFont fontWithPingFang_SC_MediumAndsize:13];
            label.textColor = [UIColor colorFromHex:0x222222];
            label.text = self.countNumArray[i];
            label.textAlignment = NSTextAlignmentCenter;
            [_countLabelArray addObject:label];
        }
    }
    return _countLabelArray;
}

- (NSMutableArray<UILabel *> *)actionLabel {
    if (_actionLabel == nil) {
        _actionLabel = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            UILabel * label = [UILabel newAutoLayoutView];
            label.tag = i;
            label.userInteractionEnabled = true;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(orderChoice:)];
            [label addGestureRecognizer:tap];
            [_actionLabel addObject:label];
        }
    }
    return _actionLabel;
}

- (NSMutableArray<UILabel *> *)classnameLabel {
    if (_classnameLabel == nil) {
          _classnameLabel = [NSMutableArray array];
        NSArray  *classNameArr = @[@"我的哆豆", @"优惠券", @"收藏关注", @"我的钱包"];
        for (int i = 0; i < 4; i++ ) {
            UILabel * label = [UILabel newAutoLayoutView];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor colorFromHex:0x222222];
            label.text = classNameArr[i];
            label.tag = i;
            label.userInteractionEnabled = true;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(orderChoice:)];
            [label addGestureRecognizer:tap];
            [_classnameLabel addObject:label];
            label.textAlignment = NSTextAlignmentCenter;
        }
    }
    return _classnameLabel;
}

-(void)vipAction{
    UserCentervipTapBlock block = _vipHandle;
    if (block) {
        block();
    }
}

-(void)orderChoice:(UITapGestureRecognizer* )tap{
    ItemActionBlock block = _itemTapHandle;
    if (block) {
        UILabel *label = tap.view;
        block(label.tag);
    }
}

-(void)clearUserInfo{
    _iconView.image = placeholderImage_avatar;
    _nameLabel.text = @"登录/注册";
    _levelBtn.hidden = true;
}
@end
