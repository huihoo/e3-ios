//
//  NSDictionary+Category.m
//  Mallike
//
//  Created by wangliang on 15/4/22.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

- (instancetype)nullValueToEmpty {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self];
    for (NSString *key in self.allKeys) {
        
        dic[key] = [dic[key] isKindOfClass:[NSNull class]] ? @"" : dic[key];
        
        if ([dic[key] isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *cellArray = [NSMutableArray array];
            for (NSDictionary *cellDic in dic[key]) {
                
                [cellArray addObject:[cellDic nullValueToEmpty]];
            }
            dic[key] = cellArray;
        }
    }
    return dic;
}

- (NSString *)dictionaryToString {
    
    
    NSMutableString *string = [NSMutableString stringWithFormat:@"{"];
    for (NSString *key in self.allKeys) {
        
        if (![string isEqual:@"{"]) {
            
            [string appendString:@","];
        }
        NSString *oneStr = [NSString stringWithFormat:@"%@:%@",key,self[key]];
        [string appendString:oneStr];
    }
    [string appendString:@"}"];
    return string;
}

@end
