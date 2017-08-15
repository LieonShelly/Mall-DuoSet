//
//  ServiceViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/7.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLable;
@property (weak, nonatomic) IBOutlet UIButton *chatWithServerBtn;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系客服";
    _coverImgView.image = [UIImage imageNamed:@"chatServer"];
    _chatWithServerBtn.backgroundColor = [UIColor mainColor];
    _textLable.text = @"如果您对于我们的产品有任何问题，欢迎致电028-12345678";
}
- (IBAction)kefuAction:(id)sender {
}
@end
