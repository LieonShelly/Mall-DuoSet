//
//  AHTagsLabel.h
//  AutomaticHeightTagTableViewCell
//
//  Created by WEI-JEN TU on 2016-07-16.
//  Copyright © 2016 Cold Yam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHTag.h"

typedef void(^SeletcedTagBlock)(NSMutableArray *);

typedef void (^SeletcedMaxBlock)();

@interface AHTagsLabel : UILabel

@property (nonatomic, strong) NSArray<AHTag *> *tags;

@property (nonatomic,copy) SeletcedTagBlock seletceBlock;
@property (nonatomic,copy) SeletcedMaxBlock maxSeletcedBlock;

@property (nonatomic,strong) NSMutableArray *seletedArr;

@end
