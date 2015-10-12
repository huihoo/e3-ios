//
//  User.m
//  E3
//
//  Created by 王亮 on 15/8/29.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)share {
    
    static dispatch_once_t once;
    static User *user = nil;
    dispatch_once(&once, ^{
        
        user = [[User alloc] init];
    });
    return user;
}

- (void)updateInfo:(NSDictionary *)param1{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:param1];
    for (NSString *key in param.allKeys) {
        
        if ([param[key] isKindOfClass:[NSNull class]]) {
            
            param[key] = @"";
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:param forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.website_grade = param[@"website_grade"];
    self.website_id = param[@"website_id"];
    self.website_logo = param[@"website_logo"];
    self.website_name = param[@"website_name"];
    self.isLogin = param[@"is_login"];

}

- (instancetype)init {
    
    if (self = [super init]) {
        
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        if (dic != nil) {
            
            self.website_grade = dic[@"website_grade"];
            self.website_id = dic[@"website_id"];
            self.website_logo = dic[@"website_logo"];
            self.website_name = dic[@"website_name"];
            self.isLogin = dic[@"is_login"];
        }
    }
    return self;
}


- (void)removeUserInfo{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"account"] = [User share].website_name;
    
    [[AppData shareData] userLoginOutWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOut" object:nil];
            self.website_grade = @"";
            self.website_id = @"";
            self.website_logo = @"";
            self.website_name = @"";
            self.isLogin = NO;
        }
    }];
}

@end
