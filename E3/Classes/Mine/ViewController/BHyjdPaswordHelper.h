//
//  BHyjdPaswordHelper.h
//  BHGMasterProject2
//
//  Created by yujiangdong on 14-4-15.
//  Copyright (c) 2014年 BHG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHyjdPaswordHelper : NSObject
+ (BOOL)checkTel:(NSString *)str;
+(BOOL)isValidateEmail:(NSString *)email;
+(BOOL) chk18PaperId:(NSString *) sPaperId;
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
+(BOOL)TXqqValidte:(NSString*)string;
@end
