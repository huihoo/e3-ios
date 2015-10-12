//
//  SessionModel.h
//  Mallike
//
//  Created by wangliang on 15/4/16.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionModel : NSObject

//第一次启动app存储sessionID
+ (void)saveSessionID;
//获取sessionID
+ (NSString *)getSessionID;

+ (void)saveSessionIDNew;

@end
