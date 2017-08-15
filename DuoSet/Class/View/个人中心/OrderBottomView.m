//
//  OrderBottomView.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/6.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "OrderBottomView.h"

@implementation OrderBottomView
- (IBAction)deleAction:(id)sender {
    [_delegate pushVC: sender];
    
    
}
- (IBAction)fanxiuAction:(id)sender {
    [_delegate pushVC: sender];
}
- (IBAction)commentAction:(id)sender {
    [_delegate pushVC: sender];
}

- (IBAction)buyAgainAction:(id)sender {
    [_delegate pushVC: sender];
}


@end
