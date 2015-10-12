//
//  NSDictionary+Category.h
//  Mallike
//
//  Created by wangliang on 15/4/22.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)

//将null转化为@""
- (instancetype)nullValueToEmpty;

- (NSString *)dictionaryToString;

@end
