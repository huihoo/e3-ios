//
//  SearchModel.m
//  JingXingApp
//
//  Created by 王亮 on 15/9/10.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "SearchModel.h"

#define searchKey @"searchKey"

@implementation SearchModel

+ (instancetype)share {
    
    static SearchModel *model = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        model = [[SearchModel alloc] init];
    });
    return model;
}

- (NSArray *)searchList {
    
    NSArray *list = [[NSUserDefaults standardUserDefaults] objectForKey:searchKey];
    return list;
}


- (void)addObjToSearchList:(id)obj{
    
    NSMutableArray *oldArray = [NSMutableArray array];
    if (self.searchList) {
        
        //有数据
        [oldArray addObjectsFromArray:self.searchList];
        BOOL isHas = [oldArray containsObject:obj];
        if (isHas) {
            [oldArray removeObject:obj];
        }
        [oldArray insertObject:obj atIndex:0];
        
    }else {
        //无数据
        [oldArray addObject:obj];
    }
    [[NSUserDefaults standardUserDefaults] setObject:oldArray forKey:searchKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
