//
//  WaterFallFlowCollectionViewFlowLayout.h
//  WaterFallFlow
//
//  Created by colin liao on 15/6/12.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>


//当default的时候为false
typedef enum : NSUInteger {
    SupplementType_Default,
    SupplementType_Left,
    SupplementType_Right,
    SupplementType_LeftRight,
    SupplementType_ALL,
} SupplementType;

@interface WaterFallFlowCollectionViewFlowLayout : UICollectionViewFlowLayout
@property(nonatomic)NSMutableArray* sectionItemArray;

-(instancetype)initWithSectionArray:(NSMutableArray*)sectionItemArray;
@end


@interface SectionItem : NSObject
@property(nonatomic)NSInteger section;//必需
@property(nonatomic)CGFloat minimumSectionLineSpacing;//最下section间距
@property(nonatomic)UIEdgeInsets insets;
@property(nonatomic)CGFloat minimumInteritemSpacing;
@property(nonatomic)CGFloat minimumLineSpacing;
@property(nonatomic)NSInteger listAmount;//必需
@property(nonatomic)SupplementType headerType;
@property(nonatomic)SupplementType footerType;
@property(nonatomic)NSArray* itemArray;//必需
@property(nonatomic)CGSize headerSize;
@property(nonatomic)CGSize footerSize;
@end



@interface Item : NSObject
@property(nonatomic)CGFloat width;
@property(nonatomic)CGFloat height;
@end