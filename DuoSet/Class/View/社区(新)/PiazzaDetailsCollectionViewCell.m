//
//  PiazzaDetailsCollectionViewCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaDetailsCollectionViewCell.h"
#import "CustomCollectionViewLayout.h"
#import "PiazzaContentItemCell.h"

@interface PiazzaDetailsCollectionViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,FFCollectionLayoutDelegate>

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,assign) CGSize collectionViewContentSize;
@property(nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation PiazzaDetailsCollectionViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc]init];
        layout.columnMargin = FitWith(30.0);
        layout.rowMargin = FitHeight(20.0);
        layout.columnsCount = 2;
        layout.sectionInset = UIEdgeInsetsMake(-FitHeight(20.0), FitWith(20.0), 0, FitWith(20.0));
        layout.delegate = self;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, self.bounds.size.height) collectionViewLayout:layout];
        [_collectionView registerClass:[PiazzaContentItemCell class] forCellWithReuseIdentifier:@"PiazzaContentItemCellIdentifier"];
        _collectionView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        [self.contentView addSubview:_collectionView];
    }
    return self;
}

-(void)setupInfoWithPiazzaItemDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PiazzaContentItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PiazzaContentItemCellIdentifier" forIndexPath:indexPath];
    PiazzaItemData *item = _dataArr[indexPath.row];
    [cell setupInfoWithPiazzaItemData:item imgVloadEndHandle:^{
        //
    }];
    cell.allowHandle = ^(UIButton *btn){
        if ([Utils getUserInfo].token.length == 0) {
            [MQToast showToast:@"您还没有登录哦" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return ;
        }
        if (btn.selected) {
            [MQToast showToast:@"您已经点过赞了哦" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return;
        }else{
            item.isLike = true;
            NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
            item.likeCount = newLikeCount;
            [btn setTitle:newLikeCount forState:UIControlStateNormal];
            btn.selected = true;
        }
        PiazzaDetailsCollectionViewCellLikeBlock block = _cellLikeBlock;
        if (block) {
            block(btn,indexPath);
        }
    };
    return cell;
}

- (CGFloat)flowLayout:(CustomCollectionViewLayout *)flowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemData *item = _dataArr[indexPath.row];
    return item.cellHight;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PiazzaDetailsCollectionViewCellBlock block = _cellBlock;
    if (block) {
        block(indexPath.row);
    }
}





//PiazzaDetailsCollectionViewCellLikeBlock cellLikeBlock

-(void)reSteCollectionViewContentSize:(CGSize)size{
    if (_collectionViewContentSize.height != size.height) {
        _collectionViewContentSize = size;
        _collectionView.frame = CGRectMake(0, 0, mainScreenWidth, size.height);
        ReSetCollectionViewSizeBlock block = _sizeBlock;
        if (block) {
            block(size);
        }
    }
}

@end
