//
//  WLHttpRequest.h
//  Mallike
//
//  Created by wangliang on 15/4/13.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLHttpRequest : NSObject

/**登陆*/
+ (void)loginWithParam:(NSDictionary *)param
      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
       andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**sessionID获取API*/
+ (void)getSessionWithParam:(NSDictionary *)param
      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
       andFailureBlock:(void (^)(NSError *resultError))failureBlock;

//注册
+(void)registerWithParam:(NSDictionary *)param
        usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
         andFailureBlock:(void (^)(NSError *resultError))failureBlock;

//个人信息设置
+(void)setPersonMessageWithParam:(NSDictionary*)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
                 andFailureBlock:(void(^)(NSError* resultError))failureBlock;

//获取
+(void)getCategoryWithParam:(NSDictionary*)param
               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
                andFailureBlock:(void(^)(NSError* resultError))failureBlock;

//添加偏好
+(void)addCategoryWithParam:(NSDictionary*)param
           usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
            andFailureBlock:(void(^)(NSError* resultError))failureBlock;

//忘记密码
+(void)findPwdWithParam:(NSDictionary*)param
       usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
        andFailureBlock:(void(^)(NSError* resultError))failureBlock;

//登出
+(void)logOutWithParam:(NSDictionary*)param
      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
       andFailureBlock:(void(^)(NSError* resultError))failureBlock;

@end
