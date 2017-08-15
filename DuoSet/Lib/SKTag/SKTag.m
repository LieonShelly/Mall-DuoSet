//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTag.h"

static const CGFloat kDefaultFontSize = 13.0;

@implementation SKTag

- (instancetype)init {
    self = [super init];
    if (self) {
        _fontSize = kDefaultFontSize;
        _textColor = [UIColor blackColor];
//        _bgColor = [UIColor whiteColor];
        _enable = YES;
    }
    return self;
}

- (nonnull instancetype)initWithProductPropertyDetails:(nonnull ProductPropertyDetails *)propertyItem{
    self = [self init];
    if (self) {
        _itemId = propertyItem.itemId;
        _selected = propertyItem.selected;
        _text = propertyItem.name;
    }
    return self;
}

- (instancetype)initWithText: (NSString *)text {
    self = [self init];
    if (self) {
        _text = text;
    }
    return self;
}

+ (instancetype)tagWithText: (NSString *)text {
    return [[self alloc] initWithText: text];
}

@end
