//
//  SessionModel.m
//  Mallike
//
//  Created by wangliang on 15/4/16.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "SessionModel.h"

@interface SessionModel ()

@property(nonatomic,strong)NSString *session;

@end

@implementation SessionModel

+ (instancetype)share {
    
    static dispatch_once_t once;
    static SessionModel *model = nil;
    dispatch_once(&once, ^{
        
        model = [[SessionModel alloc] init];
        model.session = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
        
    });
    return model;
}

+ (void)saveSessionID {
    
    if (![[SessionModel share] session]) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"getSession" forKey:@"method"];
        NSString *urlString = [WLBaseURLModel catUrlStringParameters:dic];
        WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
        NSError *error;
        NSData *data=[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] returningResponse:nil error:&error];
       
        if (error) {
            
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"获取sessionId出错"];
        } else {
            
            id sessionObj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([sessionObj[@"success"] isEqualToString:@"success"])
            {
                [[NSUserDefaults standardUserDefaults] setValue:sessionObj[@"sessionId"] forKey:@"sessionId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[SessionModel share] setSession:sessionObj[@"sessionId"]];
            }
        }
     }
}

+ (void)saveSessionIDNew {
    
    if (![[SessionModel share] session]) {
        
        NSString *urlString = @"http://182.140.244.73:91/sessionkey";
        NSError *error;
        NSData *data=[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] returningResponse:nil error:&error];
        if (error) {
            
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"获取sessionId出错"];
        } else {
            
            id sessionObj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([sessionObj[@"code"] integerValue] == 200)
            {
                [[NSUserDefaults standardUserDefaults] setValue:sessionObj[@"session_key"] forKey:@"sessionId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[SessionModel share] setSession:sessionObj[@"sessionId"]];
            }
        }
    }
    
}

+ (NSString *)getSessionID {
    
    return [[SessionModel share] session];
}

@end
