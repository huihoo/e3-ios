//
//  SearchModel.h
//  JingXingApp
//
//  Created by 王亮 on 15/9/10.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

+ (instancetype)share;
- (void)addObjToSearchList:(id)obj;

@property(nonatomic,strong)NSArray *searchList;

@end
