//
//  PiazzaInputView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaInputView.h"

@interface PiazzaInputView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *sendBtn;
@property(nonatomic,strong) UIView *bgView;

@end

@implementation PiazzaInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHex:0xf0f2f5];
//        self.userInteractionEnabled = true;
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(80.0))];
        _title.text = @"写评论";
        _title.textColor = [UIColor colorFromHex:0x222222];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = CUSFONT(13);
        [self addSubview:_title];
        
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, FitWith(90.0), FitHeight(80.0))];
        _cancelBtn.titleLabel.font = CUSFONT(12);
        [_cancelBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.tag = 0;
        [_cancelBtn addTarget:self action:@selector(btnActions:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
        
        _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(90.0) , 0, FitWith(90.0), FitHeight(80.0))];
        _sendBtn.titleLabel.font = CUSFONT(12);
        [_sendBtn setTitleColor:[UIColor colorFromHex:0xed0831] forState:UIControlStateNormal];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(btnActions:) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.tag = 1;
        [self addSubview:_sendBtn];
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(FitWith(20.0), _cancelBtn.frame.origin.y + _cancelBtn.frame.size.height, mainScreenWidth - FitWith(45.0), FitHeight(235.0))];
        [self addSubview:_bgView];
        
        _inputTexeView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height)];
        _inputTexeView.backgroundColor = [UIColor whiteColor];
        _inputTexeView.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        _inputTexeView.layer.cornerRadius = 3;
        _inputTexeView.layer.borderWidth = 0.5;
        _inputTexeView.font = CUSFONT(14);
        [_bgView addSubview:_inputTexeView];
    }
    return self;
}

-(void)btnActions:(UIButton *)btn{
    BtnActionIndexBlock block = _btnActionHandle;
    if (block) {
        block(btn.tag);
    }
}

//- (void)updateConstraints{
//    if (!_didUpdateConstraints) {
//        _didUpdateConstraints = YES;
//    }
//    [super updateConstraints];
//}
@end
