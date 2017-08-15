//
//  ModifyNameController.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ModifyNameController.h"
#import "ModiFyNameCell.h"

@interface ModifyNameController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;


@end

@implementation ModifyNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    [self configNavView];
    [self creatUI];
}

-(void)configNavView{
    UIButton *publicBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publicBtn];
    publicBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    publicBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [publicBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [publicBtn addTarget: self action:@selector(publicAction:) forControlEvents:UIControlEventTouchDown];
    [publicBtn setTitle: @"确定" forState:UIControlStateNormal];
}

- (void)creatUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.scrollEnabled = false;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ModiFyNameCellID = @"ModiFyNameCellID";
    ModiFyNameCell * cell = [_tableView dequeueReusableCellWithIdentifier:ModiFyNameCellID];
    if (cell == nil) {
        cell = [[ModiFyNameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ModiFyNameCellID];
    }
    cell.inputTF.placeholder = @"请输入您的昵称";
    cell.inputTF.delegate = self;
    cell.inputTF.returnKeyType = UIReturnKeyDone;
    cell.inputTF.tintColor = [UIColor mainColor];
    [cell.inputTF addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    cell.selectionStyle = indexPath.row == 0 ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
    return cell;
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(106.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    ModiFyNameCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.inputTF resignFirstResponder];
    return true;
}

-(void)textFieldValueChange:(UITextField *)textFiled{
    bool isChinese;
    if ([[[UIApplication sharedApplication]textInputMode].primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = false;
    }else{
        isChinese = true;
    }
    NSString *str = [textFiled.text stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [textFiled markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textFiled positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            NSLog(@"输入的是汉字");
            if ( str.length>=11) {
                NSString *strNew = [NSString stringWithString:str];
                [textFiled setText:[strNew substringToIndex:11]];
            }
        }else{
            NSLog(@"英文还没有转化为汉字");
        }
    }else{
        if ([str length]>=11) {
            NSString *strNew = [NSString stringWithString:str];
            [textFiled setText:[strNew substringToIndex:11]];
        }
    }
}


-(void)publicAction:(UIButton *)btn{
    ModiFyNameCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell.inputTF.text.length == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:1] forKey:@"type"];
    [params setObject:cell.inputTF.text forKey:@"value"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/info" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [self.view makeToast:@"昵称修改设置成功"];
            UserInfo *info = [Utils getUserInfo];
            info.name = cell.inputTF.text;
            [Utils setUserInfo:info];
            NameModifyBlock block = _nameChangeHandle;
            if (block) {
                block();
            }
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        //
    }];
}

@end
