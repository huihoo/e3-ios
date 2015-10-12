//
//  WLBaseURL.m
//  E3
//
//  Created by 王亮 on 15/8/17.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "WLBaseURL.h"

#import "NSString+Category.h"


#define APP_KEY @"9e304d4e8df1b74cfa009913198428ab"

#define APP_SECRET @"4f4f8dd219bbdde0ae6bbe02be217c3a"

#define V @"v1.0"

#define FORMAT @"json"

#define SIGN_METHOD @"md5"

#define BASEURL @"http://182.140.244.73:91/gateway/router?"

#import "SessionModel.h"

@implementation WLBaseURL


//根据传入参数返回一个完成的URL地址
+(NSString *)getURLStringWithParameters:(NSDictionary *)parmeters
{
    NSMutableString *urlString=[[NSMutableString alloc] initWithString:BASEURL];
    [urlString appendString:[[self class] getSystemParameters:parmeters[@"method"]]];
    [urlString appendString:[[self class] getParURLWithParameters:parmeters session:YES]];
    if (!([parmeters count] == 1 && [[parmeters allKeys][0] isEqualToString:@"method"]))
    {
        [urlString appendString:[NSString stringWithFormat:@"&sign=%@",[[[self class] getSignParameters:parmeters] md5]]];
    }
//    
//    [urlString appendString:[NSString stringWithFormat:@"session_key=%@",[SessionModel getSessionID]]];
//    [urlString appendString:[NSString stringWithFormat:@"&app_key=%@",APP_KEY]];
//    [urlString appendString:[NSString stringWithFormat:@"&method=%@",parmeters[@"method"]]];
//    [urlString appendString:[NSString stringWithFormat:@"&sign=%@",[[[self class] getSignParameters:parmeters] md5]]];
//    long someTime=[[NSDate date] timeIntervalSince1970];
//    [urlString appendString:[NSString stringWithFormat:@"&sign_method=md5&timestamp=%ld&v=v1.0",someTime]];
    
    return urlString;
}

//构建应用级别参数
+(NSString *) getParURLWithParameters:(NSDictionary *)parameters session:(BOOL) session
{
    NSMutableString *urlStr=[[NSMutableString alloc] init];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *sessionKey=[defaults objectForKey:@"sessionId"];
    
    if (sessionKey&&session)
    {
        [urlStr appendString:[NSString stringWithFormat:@"&session_key=%@",sessionKey]];
    }
    
    if ([parameters count] >0 && parameters)
    {
        NSArray *keys=[parameters allKeys];
        for(int i=0;i<[keys count];i++)
        {
            if (![keys[i] isEqualToString:@"method"])
            {
                [urlStr appendString:[NSString stringWithFormat:@"&%@=%@",keys[i],parameters[keys[i]]]];
            }
        }
    }
    return urlStr;
}



//构建系统级别参数URL
+(NSString *)getSystemParameters:(NSString *) method
{
    NSMutableString *systemParametes=[[NSMutableString alloc] init];
    
    long someTime=[[NSDate date] timeIntervalSince1970];
    
    NSString *pasStr=[NSString stringWithFormat:@"app_key=%@&method=%@&timestamp=%ld&v=%@&sign_method=%@",APP_KEY,method,someTime,V,SIGN_METHOD];
    
    [systemParametes appendString:pasStr];
    
    return systemParametes;
}

//排序应用级参数
+(NSString *) getSignParameters:(NSDictionary *) signDic
{
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
        [signURL appendString:APP_SECRET];
        
        for (int i=0; i<[tempArray count] ; i++)
        {
            if (i==0)
            {
                [signURL appendString:[NSString stringWithFormat:@"%@=%@",tempArray[i],signDic[tempArray[i]]]];
            }
            else
            {
                [signURL appendString:[NSString stringWithFormat:@"&%@=%@",tempArray[i],signDic[tempArray[i]]]];
            }
        }
        [signURL appendString:APP_SECRET];
        
        return signURL;
    }
    return nil;
    
    
}
//获取设备唯一标示
+(NSString *)getIdentifier
{
    NSString* uniqueIdentifier = nil;
    if( [UIDevice instancesRespondToSelector:@selector(identifierForVendor)])
    { // >=iOS 7
        uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else { //<=iOS6, Use UDID of Device
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        //uniqueIdentifier = ( NSString*)CFUUIDCreateString(NULL, uuid);- for non- ARC
        uniqueIdentifier = (NSString*)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));// for ARC
        CFRelease(uuid);
    }
    return uniqueIdentifier;
}

+(NSDictionary *) postCodeingUrlWithDic:(NSDictionary *) dic
{
    
    NSMutableDictionary *urlDic=[[NSMutableDictionary alloc] init];
    
    [urlDic setObject:APP_KEY forKey:@"app_key"];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *sessionKey=[defaults objectForKey:@"sessionKey"];
    [urlDic setObject:sessionKey forKey:@"session_key"];
    
    long someTime=[[NSDate date] timeIntervalSince1970];
    [urlDic setObject:[NSString stringWithFormat:@"%ld",someTime] forKey:@"timestamp"];
    [urlDic setObject:V forKey:@"v"];
    [urlDic setObject:FORMAT forKey:@"format"];
    [urlDic setObject:SIGN_METHOD forKey:@"sign_method"];
    NSString *asignStr=[[[self class] getSignParameters:dic] md5];
    [urlDic setObject:asignStr forKey:@"sign"];
    
    [urlDic addEntriesFromDictionary:dic];
    return urlDic;
}


@end
