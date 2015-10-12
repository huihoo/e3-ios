//
//  CartProductCollectionViewCell.h
//  E3
//
//  Created by 王亮 on 15/8/31.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellForSuperProtocol.h"

@class CartProductModel;

@interface CartProductCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)CartProductModel *productModel;
@property(nonatomic,assign)id<CellForSuperProtocol> delegate;
@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)NSInteger row;

@end
