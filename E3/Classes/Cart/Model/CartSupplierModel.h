//
//  CartSupplierModel.h
//  E3
//
//  Created by 王亮 on 15/8/31.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartSupplierModel : NSObject

@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,strong)NSDictionary *suppilerDic;
@property(nonatomic,strong)NSMutableArray *productList;

@end
