//
//  ProductDetailsImgsCell.h
//  DuoSet
//
//  Created by fanfans on 12/29/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsImgsCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withImgArr:(NSMutableArray *)imgArr andImgHightArr:(NSMutableArray *)imgsHightArr;

@end
