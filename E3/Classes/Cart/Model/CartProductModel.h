//
//  CartProductModel.h
//  E3
//
//  Created by 王亮 on 15/8/31.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartProductModel : NSObject


@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,strong)NSDictionary *productDic;

@end
