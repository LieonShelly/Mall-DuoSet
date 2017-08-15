//
//  UserInfoController.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserInfoController.h"
#import "ModifyUserAvatarCell.h"
#import "OrderDetailNextActionCell.h"
#import "ModifyNameController.h"

@interface UserInfoController ()<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSData *imageData;

@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self creatUI];
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
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *ModifyUserAvatarCellID = @"ModifyUserAvatarCellID";
        ModifyUserAvatarCell * cell = [_tableView dequeueReusableCellWithIdentifier:ModifyUserAvatarCellID];
        if (cell == nil) {
            cell = [[ModifyUserAvatarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ModifyUserAvatarCellID];
        }
        cell.tipsLable.text = @"头像";
        UserInfo *info = [Utils getUserInfo];
        [cell.avatarImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:placeholderImage_avatar options:0];
        return cell;
    }else{
        static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID";
        OrderDetailNextActionCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
        if (cell == nil) {
            cell = [[OrderDetailNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
        }
        cell.tipsLable.text = @"昵称";
        UserInfo *info = [Utils getUserInfo];
        cell.rightSubLable.text = info.name;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 0 ? FitHeight(120.0) : FitHeight(106.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self modifieAvatar];
    }
    if (indexPath.row == 1) {
        ModifyNameController *modifyNameVC = [[ModifyNameController alloc]init];
        modifyNameVC.nameChangeHandle = ^(){
            [tableView reloadData];
            InfoModifyBlock block = _modifyHandle;
            if (block) {
                block();
            }
        };
        [self.navigationController pushViewController:modifyNameVC animated:true];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - 更换头像
-(void)modifieAvatar{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设置头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        }
        
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [self presentViewController:pickerImage animated:YES completion:^{
        }];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        ModifyUserAvatarCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.avatarImgV.image = image;
        NSData *imageData = UIImageJPEGRepresentation(image,1.0);
        CGFloat sizeOriginKB = imageData.length / 1024.0;
        if (sizeOriginKB <= 200.0) {
            _imageData = imageData;
        }else{
            NSData *data = [NSData reSizeImageData:image maxImageSize:800 maxSizeWithKB:200];
            _imageData = data;
        }
        [UploadUtils upLoadMultimediaWithData:_imageData success:^(NSString *mediaStr) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:[NSNumber numberWithInteger:0] forKey:@"type"];
            [params setObject:mediaStr forKey:@"value"];
            [RequestManager requestWithMethod:POST WithUrlPath:@"user/info" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
                NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                if ([resultCode isEqualToString:@"ok"]) {
                    [self.view makeToast:@"头像设置成功"];
                    UserInfo *info = [Utils getUserInfo];
                    info.avatar = mediaStr;
                    [Utils setUserInfo:info];
                    InfoModifyBlock block = _modifyHandle;
                    if (block) {
                        block();
                    }
                }
            } fail:^(NSError *error) {
                [self.view makeToast:@"上传失败"];
            }];
        } fail:^(NSString *errStr) {
            
        } progress:^(NSString *progressStr) {
            [self.view makeToast:@"上传失败"];
        }];
    }];
}

@end
