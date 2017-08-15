//
//  SignView.h
//  BrownRecords
//
//  Created by issuser on 16/12/22.
//  Copyright © 2016年 xiaodi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignView : UIView
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *towbtn;
@property (weak, nonatomic) IBOutlet UIButton *fiveBtn;

@property (weak, nonatomic) IBOutlet UIButton *forBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateOneLlabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateThreeLable;
@property (weak, nonatomic) IBOutlet UILabel *dateFourLahel;
@property (weak, nonatomic) IBOutlet UILabel *datefiveLabel;
- (void)updateBtnsLayout;
@end
