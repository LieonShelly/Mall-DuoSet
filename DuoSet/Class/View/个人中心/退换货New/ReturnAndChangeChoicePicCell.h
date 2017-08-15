//
//  ReturnAndChangeChoicePicCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureView.h"

@interface ReturnAndChangeChoicePicCell : UITableViewCell

@property (nonatomic,strong) PictureView *picView;

- (void)updateFrameAndPicWithThumbnailsArray:(NSMutableArray *)thumbnailsArray;

@end
