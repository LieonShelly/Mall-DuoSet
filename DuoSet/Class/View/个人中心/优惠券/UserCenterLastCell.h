//
//  UserCenterLastCell.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/13.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterLastCell : UITableViewCell
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSMutableArray *dataArray;

-(void)setupInfoWithDataArray:(NSMutableArray *)dataArray;
@end
