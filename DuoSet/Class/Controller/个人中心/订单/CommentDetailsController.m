//
//  CommentDetailsController.m
//  DuoSet
//
//  Created by fanfans on 2017/4/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentDetailsController.h"
#import "CommentDetailsData.h"
#import "CommentDetailsCell.h"
#import "CommentImageCell.h"

@interface CommentDetailsController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,copy) NSString *num;
@property(nonatomic,copy) NSString *detailId;
@property(nonatomic,strong) CommentDetailsData *commentData;
@property(nonatomic,strong) NSMutableDictionary *hightDic;

@property(nonatomic,strong) UITableView *tableView;


@end

@implementation CommentDetailsController

-(instancetype)initWithOrderNum:(NSString *)num detailId:(NSString *)detailId{
    self = [super init];
    if (self) {
        _num = num;
        _detailId = detailId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价详情";
    self.view.backgroundColor = [UIColor whiteColor];
    _hightDic = [NSMutableDictionary dictionary];
    [self creatUI];
    [self configData];
}

-(void)configData{
    NSString *urlStr = [NSString stringWithFormat:@"user/order/%@/%@/comment",_num,_detailId];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                _commentData = [CommentDetailsData dataForDictionary:objDic];
                [_tableView reloadData];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void)creatUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _commentData == nil ? 0 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return _commentData.pics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{//CommentImageCell
    if (indexPath.section == 0) {
        static NSString *CommentDetailsCellID = @"CommentDetailsCellID";
        CommentDetailsCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommentDetailsCellID];
        if (cell == nil) {
            cell = [[CommentDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentDetailsCellID commentData:_commentData];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CommentImageCellID = @"CommentImageCellID";
        CommentImageCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommentImageCellID];
        if (cell == nil) {
            cell = [[CommentImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentImageCellID];
        }
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:_commentData.pics[indexPath.row]] placeholderImage:placeholderImage_702_420 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                CGSize size = image.size;
                CGFloat scale = size.height / size.width;
                CGFloat hight = mainScreenWidth * scale;
                if (![_hightDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                    [_hightDic setObject:[NSNumber numberWithFloat:hight] forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                    [_tableView reloadData];
                }
            }
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return _commentData.cellHight;
    }else{
        if ([_hightDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
            NSNumber *num = [_hightDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
            CGFloat hight = num.floatValue;
            return hight;
        }else{
            return FitHeight(400.0);
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        ScanPictureViewController *picVC = [[ScanPictureViewController alloc]initWithPhotosUrl:_commentData.pics WithCurrentIndex:indexPath.row];
        [self.navigationController presentViewController:picVC animated:true completion:nil];
    }
}

@end
