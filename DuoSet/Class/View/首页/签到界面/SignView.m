//
//  SignView.m
//  BrownRecords
//
//  Created by issuser on 16/12/22.
//  Copyright © 2016年 xiaodi. All rights reserved.
//

#import "SignView.h"
#import "UIButton+DLL.h"
@implementation SignView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    return self;
}
- (IBAction)btnAction:(id)sender {
    //签到1到5 sender.tag = 200 - 204
    //NSLog(@"%@",sender.tag);
    
}
- (void)updateBtnsLayout {
    if (self) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                [((UIButton *)view) setVerticalImageAndTitle:YES];
                [((UIButton *)view) setSpacing:5];
                
                
            }
        }
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
    [self removeFromSuperview];
}
@end
