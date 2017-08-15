//
//  SecondCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initViews];
        
    }
    return self;
    
}
- (void) initViews{
    CGFloat labelW = (mainScreenWidth-20)/2;
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, labelW, 20)];
    _commentLabel.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    _commentLabel.textColor = [UIColor colorWithHexString:@"222222"];
    [self.contentView addSubview:_commentLabel];
    _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_commentLabel.frame.origin.x+_commentLabel.frame.size.width, 10, labelW, 20)];
    _percentLabel.textAlignment = NSTextAlignmentRight;
    _percentLabel.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    _percentLabel.textColor = [UIColor colorWithHexString:@"222222"];
    [self.contentView addSubview:_percentLabel];
}


@end
