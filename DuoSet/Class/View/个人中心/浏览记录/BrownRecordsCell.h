//
//  BrownRecordsCell.h
//  BrownRecords
//
//  Created by issuser on 16/12/20.
//  Copyright © 2016年 xiaodi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrownRecordsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopIcomImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *pricelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UIButton *sameBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraints;

- (void)updateFrame;
@end
