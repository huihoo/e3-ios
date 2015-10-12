//
//  User.h
//  E3
//
//  Created by 王亮 on 15/8/29.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+ (instancetype)share;
- (void)updateInfo:(NSDictionary *)param1;
- (void)removeUserInfo;

@property(nonatomic,assign) BOOL isLogin;

@property(nonatomic,copy) NSString *website_grade;
@property(nonatomic,copy) NSString *website_id;
@property(nonatomic,copy) NSString *website_logo;
@property(nonatomic,copy) NSString *website_name;

@end
