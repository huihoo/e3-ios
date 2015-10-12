//
//  WLBaseURLModel.m
//  lianwei
//
//  Created by scjh on 15/4/14.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "WLBaseURLModel.h"

#import "NSString+Category.h"

#define APP_KEY @"9e304d4e8df1b74cfa009913198428ab"

#define APP_SECRET @"4f4f8dd219bbdde0ae6bbe02be217c3a"

#define V @"v1.0"

#define SIGN_METHOD @"md5"

//#define Base_URL @"http://45.56.75.236:8888/api/router?"

#define Base_URL @"http://182.140.244.73:91/gateway/router?"


@implementation WLBaseURLModel


+ (NSString *)catUrlStringParameters:(NSDictionary *) signDic1 {
    
    NSMutableDictionary *signDic = [NSMutableDictionary dictionaryWithDictionary:signDic1];
    long someTime=[[NSDate date] timeIntervalSince1970];
    [signDic setValue:[NSString stringWithFormat:@"%ld",someTime] forKey:@"timestamp"];
    
    NSMutableString *urlString = [NSMutableString stringWithString:Base_URL];
    [urlString appendString:[NSString stringWithFormat:@"app_key=%@",APP_KEY]];
    [urlString appendString:[NSString stringWithFormat:@"&method=%@",signDic[@"method"]]];
    
    NSMutableDictionary *tempDic=[signDic mutableCopy];
    NSArray *keys=[tempDic allKeys];
    if ([keys containsObject:@"method"])
    {
        [tempDic removeObjectForKey:@"method"];
    }
    NSArray *tempArray=[[tempDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSRange rang={0,obj1.length-1};
        return [obj1 compare:obj2 options:NSLiteralSearch range:rang];
    }];
    for (NSString *key in tempArray) {
        
        [urlString appendString:[NSString stringWithFormat:@"&%@=%@",key,signDic[key]]];
    }
    
    NSString *md5Str = [[self getSignParameters:signDic] md5];
    [urlString appendString:[NSString stringWithFormat:@"&sign=%@",md5Str]];
    
    return urlString;
}


//排序应用级参数
+(NSString *) getSignParameters:(NSDictionary *) signDic1
{
    
    NSMutableDictionary *signDic = [NSMutableDictionary dictionaryWithDictionary:signDic1];
    long someTime=[[NSDate date] timeIntervalSince1970];
    [signDic setValue:[NSString stringWithFormat:@"%ld",someTime] forKey:@"timestamp"];
    
    NSMutableDictionary *tempDic=[signDic mutableCopy];
    NSArray *keys=[tempDic allKeys];
    if ([keys containsObject:@"method"])
    {
        [tempDic removeObjectForKey:@"method"];
    }
    
    if (tempDic&&[tempDic count]>0)
    {
        NSArray *tempArray=[[tempDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            NSRange rang={0,obj1.length-1};
            return [obj1 compare:obj2 options:NSLiteralSearch range:rang];
        }];
        
        NSMutableString *signURL=[[NSMutableString alloc] init];
       
        for (int i=0; i<[tempArray count] ; i++)
        {
            NSString *key = tempArray[i];
            NSString *vaule = signDic[key];
            if (i==0)
            {
                [signURL appendString:[NSString stringWithFormat:@"%@=%@",tempArray[i],[vaule stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            }
            else
            {
                [signURL appendString:[NSString stringWithFormat:@"&%@=%@",tempArray[i],[vaule stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            }
        }
        
        [signURL appendString:APP_SECRET];
        
        return signURL;
    }
    
    //没有数据时
    return nil;
    
}

@end
