//
//  QiandaoHeaderView.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/2.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "QiandaoHeaderView.h"

@implementation QiandaoHeaderView
//- (IBAction)qiandaoAction:(id)sender {
//}
//
//+(instancetype)headerView{
//    return [[[NSBundle mainBundle] loadNibNamed:@"QiandaoHeaderView" owner:nil options:nil] lastObject];
//}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if ([super initWithFrame:frame]){
//        
//        [self initViews];
//        
//        
//    }
//    return self;
//}
//
//-(void) initViews{
//    _iconImg = [[UIImageView alloc] init];
//    _coverImg = [[UIImageView alloc] init];
//    _qiandaoBtn = [[UIButton alloc] init];
//    _nameLabel = [[UILabel alloc] init];
//    _titleLabel = [[UILabel alloc] init];
//    _coverImg.image = [UIImage imageNamed:@"替代1"];
//    [self addSubview:_coverImg];
//    [self addSubview:_titleLabel];
//    [self addSubview:_iconImg];
//    
//    [self addSubview:_qiandaoBtn];
//    [self addSubview:_nameLabel];
//    
//    
//
//    
//    
//    
//}
//
//
//-(void)layoutSubviews{
//    CGFloat W = self.frame.size.width;
//    CGFloat H = self.frame.size.height;
//    CGFloat iconX = 15;
//    CGFloat iconY = 80;
//    CGFloat iconW = 80;
//    CGFloat iconH = 80;
//    _iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
//    _iconImg.layer.cornerRadius = 40;
//    CGFloat nameX = 30+iconW;
//    CGFloat nameY = iconY;
//    CGFloat nameW = 120;
//    CGFloat nameH = 20;
//    _nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
//    CGFloat subX = nameX;
//    CGFloat subY = nameY+nameH+15;
//    CGFloat subW = nameW;
//    CGFloat subH = nameH;
//    _titleLabel.frame = CGRectMake(subX, subY, subW, subH);
//    
//    _coverImg.frame = CGRectMake(0, 0, W, H);
//    CGFloat qiandaoW = 80;
//    CGFloat qiandaoH = 40;
//    CGFloat qiandaoX = W-qiandaoW-15;
//    CGFloat qiandaoY = nameY+15;
//    _qiandaoBtn.frame = CGRectMake(qiandaoX, qiandaoY, qiandaoW, qiandaoH);
//    

- (IBAction)qiandaoAction:(id)sender {
    if (self.qiandaoActiom) {
        self.qiandaoActiom();
    }
    
}
    


@end
