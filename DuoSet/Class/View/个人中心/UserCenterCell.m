//
//  UserCenterCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "UserCenterCell.h"

@implementation UserCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UserInfo *info = [Utils getUserInfo];
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:[UIImage imageNamed:@"testAvatar.jpg"] options:0];
    _iconImgView.layer.cornerRadius = FitWith(100.0) *0.5;
    _iconImgView.layer.masksToBounds = true;
    
    [_nameLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nameLabel setTitle:info.name forState:UIControlStateNormal];
    [_manageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_VIPBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _VIPBtn.titleLabel.font = CUSFONT(10);
    [_VIPBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [_VIPBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
}

-(void)reSetUserinfo{
    UserInfo *info = [Utils getUserInfo];
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:[UIImage imageNamed:@"testAvatar.jpg"] options:0];
    [_nameLabel setTitle:info.name forState:UIControlStateNormal];
}

- (IBAction)accountManageAction:(id)sender {
    if (self.accountManager){
        self.accountManager();
    }
}



@end
