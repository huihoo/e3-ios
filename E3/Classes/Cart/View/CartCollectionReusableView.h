//
//  CartCollectionReusableView.h
//  E3
//
//  Created by 王亮 on 15/8/31.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellForSuperProtocol.h"
@class CartSupplierModel;
@interface CartCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property(nonatomic,strong)CartSupplierModel *model;
@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)id<CellForSuperProtocol> delegate;

@end
