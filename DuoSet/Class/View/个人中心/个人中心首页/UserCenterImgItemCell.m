//
//  UserCenterImgItemCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserCenterImgItemCell.h"

@interface UserCenterImgItemCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *btnArr;
@property (nonatomic,strong) NSArray *btnNameArr;
@property (nonatomic,strong) NSArray *btnImgArr;

@end

@implementation UserCenterImgItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _btnArr = [NSMutableArray array];
        _btnNameArr = @[@"浏览记录", @"全部活动", @"客服帮助",@"社区"];
//        _btnNameArr = @[@"浏览记录", @"全部活动", @"客服帮助",@"会员中心"];
        _btnImgArr = @[@"user_look_history", @"user_myactivity", @"user_center_server", @"user_center_paizza"];
//        _btnImgArr = @[@"user_look_history", @"user_myactivity", @"user_center_server", @"user_center_vip"];
        
        for (int i = 0 ; i < _btnNameArr.count; i++) {
            UIButton *btn = [UIButton newAutoLayoutView];
            btn.titleLabel.font = CUSFONT(11);
            btn.tag = i;
            [btn setTitle:_btnNameArr[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:_btnImgArr[i]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-FitHeight(40.0), 0, 0, -FitWith(120.0))];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -FitWith(55.0), -FitHeight(60.0), 0)];
            if (i == 0) {
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-FitHeight(40.0), -FitWith(30.0), 0, -FitWith(120.0))];
            }
            if (i == _btnNameArr.count - 1) {
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-FitHeight(40.0), FitWith(50.0), 0, 0)];
                if (IS_IPHONE5) {
                    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -FitWith(80.0), -FitHeight(60.0), 0)];
                }else{
                    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -FitWith(70.0), -FitHeight(60.0), 0)];
                }
            }
            [_btnArr addObject:btn];
            [btn addTarget:self action:@selector(itemChoice:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)itemChoice:(UIButton *)btn{ 
    ImgItemActionBlock block = _itemTapHandle;
    if (block) {
        block(btn.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        for (int i = 0 ; i < _btnNameArr.count; i++) {
            UIButton *btn = _btnArr[i];
            [btn autoSetDimension:ALDimensionWidth toSize:mainScreenWidth/4];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth/4) * i];
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
