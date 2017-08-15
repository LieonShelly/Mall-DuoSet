//
//  BrownRecordsCell.m
//  BrownRecords
//
//  Created by issuser on 16/12/20.
//  Copyright © 2016年 xiaodi. All rights reserved.
//

#import "BrownRecordsCell.h"

@implementation BrownRecordsCell

- (void)updateFrame {
    _leftConstraints.constant = _leftConstraints.constant==10? 40 :10;
    _sameBtn.hidden = _sameBtn.hidden ? NO:YES;
    _statusImageView.hidden = _statusImageView.hidden ? NO:YES;
}

@end
