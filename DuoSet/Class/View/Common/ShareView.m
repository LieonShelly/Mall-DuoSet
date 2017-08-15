//
//  ShareView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShareView.h"

@interface ShareView()

@property(nonatomic,strong) UILabel *tipLable;
@property(nonatomic,strong) UIButton *wechatBtn;
@property(nonatomic,strong) UIButton *pengyouquanBtn;
@property(nonatomic,strong) UIButton *sniaBtn;
@property(nonatomic,strong) UIButton *qqBtn;
@property(nonatomic,strong) UIButton *qqZoneBtn;
@property(nonatomic,strong) UIButton *copylinkBtn;
@property(nonatomic,strong) NSMutableArray *btnArr;
@property(nonatomic,strong) NSArray *btnImgVArr;
@property(nonatomic,strong) NSArray *btnNameVArr;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIButton *cancelBtn;

@end

@implementation ShareView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _tipLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(74.0))];
        _tipLable.textAlignment = NSTextAlignmentCenter;
        _tipLable.font = [UIFont systemFontOfSize:15];
        _tipLable.textColor = [UIColor colorFromHex:0x808080];
        _tipLable.text = @"分享到";
        [self addSubview:_tipLable];
        
        _btnImgVArr = @[@"share_wechat",@"share_pengyouquan",@"share_sina",@"share_qq",@"share_qqzone",@"share_link",];
        _btnNameVArr = @[@"微信好友",@"朋友圈",@"新浪微博",@"QQ好友",@"QQ空间",@"复制链接",];
        
        _btnArr = [NSMutableArray array];
        _wechatBtn = [[UIButton alloc]init];
        [_btnArr addObject:_wechatBtn];
        _pengyouquanBtn = [[UIButton alloc]init];
        [_btnArr addObject:_pengyouquanBtn];
        _sniaBtn = [[UIButton alloc]init];
        [_btnArr addObject:_sniaBtn];
        _qqBtn = [[UIButton alloc]init];
        [_btnArr addObject:_qqBtn];
        _qqZoneBtn = [[UIButton alloc]init];
        [_btnArr addObject:_qqZoneBtn];
        _copylinkBtn = [[UIButton alloc]init];
        [_btnArr addObject:_copylinkBtn];
        
        for (int i = 0; i < _btnArr.count; i++) {
            UIImageView *imgV = [[UIImageView alloc]init];
            imgV.image = [UIImage imageNamed:_btnImgVArr[i]];
            UILabel *lable = [[UILabel alloc]init];
            lable.text = _btnNameVArr[i];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont systemFontOfSize:13];
            UIButton *btn = _btnArr[i];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            if (i < 4) {
                imgV.frame = CGRectMake(FitWith(58.0) + FitWith(170.0) * i , _tipLable.frame.origin.y + _tipLable.frame.size.height, FitHeight(120.0), FitHeight(120.0));
                
                lable.frame = CGRectMake(FitWith(44.0) + FitWith(170.0) * i , imgV.frame.origin.y + imgV.frame.size.height, FitWith(150.0), FitHeight(60.0));
                btn.frame = CGRectMake(FitWith(48.0) + FitWith(170.0) * i , _tipLable.frame.origin.y + _tipLable.frame.size.height, FitHeight(170.0), FitHeight(176.0));
            }else{
                imgV.frame = CGRectMake(FitWith(58.0) + FitWith(170.0) * (i - 4) , FitHeight(274.0), FitHeight(120.0), FitHeight(120.0));
                
                lable.frame = CGRectMake(FitWith(44.0) + FitWith(170.0) * (i - 4) , FitHeight(224.0) + FitHeight(130.0) + FitHeight(40.0), FitWith(150.0), FitHeight(60.0));
                btn.frame = CGRectMake(FitWith(48.0) + FitWith(170.0) * (i - 4) , FitHeight(264.0) , FitHeight(170.0), FitHeight(176.0));
            }
            [self addSubview:imgV];
            [self addSubview:lable];
            [self addSubview:btn];
        }
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - FitHeight(100.0), mainScreenWidth, 0.5)];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self addSubview:_line];
        
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _line.frame.origin.y + _line.frame.size.height, mainScreenWidth, FitHeight(100.0))];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAciton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
        
    }
    return self;
}

-(void)btnAction:(UIButton *)btn{
    ShareBtnActionBlock block = _shareHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)cancelBtnAciton{
    CancelBtnActionBlock block = _cancelHandle;
    if (block) {
        block();
    }
}

@end
