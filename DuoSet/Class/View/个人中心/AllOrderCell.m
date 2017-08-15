//
//  AllOrderCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "AllOrderCell.h"

@implementation AllOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void) initViews{
    _headerLabel = [[UIButton alloc] initWithFrame:CGRectMake(15, 5, 60*AdapterWidth(), self.frame.size.height-10)];
    [self.contentView addSubview:_headerLabel];
    [_headerLabel setTitle:@"全部订单" forState:UIControlStateNormal];
//    _headerLabel.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 220);
    _headerLabel.titleLabel.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    [_headerLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_headerLabel addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
}
- (void) btnAction: (UIButton *) btn{
    if (self.allOrderBtn){
        self.allOrderBtn();
    }
}
@end
