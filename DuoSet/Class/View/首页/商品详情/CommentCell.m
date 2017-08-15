//
//  CommentCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}
- (void) initViews {
    _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    [self.contentView addSubview:_iconImgView];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImgView.frame.size.height+_iconImgView.frame.origin.x+10, 10, mainScreenWidth-(_iconImgView.frame.size.height+_iconImgView.frame.origin.x+10), 20)];
    _nameLabel.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    [self.contentView addSubview:_nameLabel];
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _iconImgView.frame.size.height+_iconImgView.frame.origin.y+20, mainScreenWidth-20, 20)];
    _commentLabel.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    [self.contentView addSubview:_commentLabel];
    
    _coverImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, _commentLabel.frame.origin.y+_commentLabel.frame.size.height+10, 60, 60)];
    [self.contentView addSubview:_coverImgView];
    
    _gradeLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, _coverImgView.frame.origin.y+_coverImgView.frame.size.height+20, 90, 20)];
    _gradeLabel1.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    [self.contentView addSubview:_gradeLabel1];
    
    _gradeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(_gradeLabel1.frame.origin.x+_gradeLabel1.frame.size.width+10, _coverImgView.frame.origin.y+_coverImgView.frame.size.height+20, 90, 20)];
    _gradeLabel2.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    [self.contentView addSubview:_gradeLabel2];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_gradeLabel2.frame.origin.x+_gradeLabel2.frame.size.height+10, _coverImgView.frame.origin.y+_coverImgView.frame.size.height+20, mainScreenWidth-(_gradeLabel2.frame.origin.x+_gradeLabel2.frame.size.height+10), 20)];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    [self.contentView addSubview:_timeLabel];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 
    
}

@end
