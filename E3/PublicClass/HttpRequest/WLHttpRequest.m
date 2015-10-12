//
//  WLHttpRequest.m
//  Mallike
//
//  Created by wangliang on 15/4/13.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "WLHttpRequest.h"
#import "AFNetworking.h"
#import "WLBaseURLModel.h"
//#import "AppManager.h"

@implementation WLHttpRequest


//POST请求获取字典数据
+ (void)getDictionaryWithStringURL:(NSString *)stringURL
                              Parma:(NSDictionary *)parma
                       SuccessBlock:(void(^)(NSDictionary * resultDictionary))SuccessBlock
                       FailureBlock:(void(^)(NSError * error))FailureBlock{
    
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    [manger GET:stringURL parameters:parma success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        SuccessBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        FailureBlock(error);
        
    }];
}


//POST请求获取字典数据
+ (void)postDictionaryWithStringURL:(NSString *)stringURL
                              Parma:(NSDictionary *)parma
                       SuccessBlock:(void(^)(NSDictionary * resultDictionary))SuccessBlock
                       FailureBlock:(void(^)(NSError * error))FailureBlock{

    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    [manger POST:stringURL
      parameters:parma
         success:^(AFHTTPRequestOperation *operation, id responseObject) {

        SuccessBlock(responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   
        FailureBlock(error);
 
    }];
}


/**登陆*/
+ (void)loginWithParam:(NSDictionary *)param
      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
       andFailureBlock:(void (^)(NSError *resultError))failureBlock{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"userEnter" forKey:kMethod];
    NSString *urlString = [WLBaseURLModel catUrlStringParameters:dic];
    WLLog(@"method = %@,\n url = %@",dic[kMethod],urlString);
    [self postDictionaryWithStringURL:urlString
                                Parma:nil
                         SuccessBlock:^(NSDictionary *resultDictionary) {
                             
                             sucessBlock(YES,resultDictionary);
                         } FailureBlock:^(NSError *error) {
                             
                             failureBlock(error);
                         }];
}

/**sessionID获取API*/
+ (void)getSessionWithParam:(NSDictionary *)param
           usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
            andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"getSession" forKey:kMethod];
    NSString *urlString = [WLBaseURLModel catUrlStringParameters:dic];
    WLLog(@"method = %@,\n url = %@",dic[kMethod],urlString);
    [self postDictionaryWithStringURL:urlString
                                Parma:nil
                         SuccessBlock:^(NSDictionary *resultDictionary) {
                             
                             sucessBlock(YES,resultDictionary);
                         } FailureBlock:^(NSError *error) {
                             
                             failureBlock(error);
                         }];
    
}

//注册
+(void)registerWithParam:(NSDictionary *)param
        usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock
         andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary* registerDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [registerDic setValue:@"userRegister" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:registerDic];
    WLLog(@"method = %@,\n url = %@",registerDic[kMethod],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

//个人信息设置
+(void)setPersonMessageWithParam:(NSDictionary *)param
                usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock
                 andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary* personMessageDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [personMessageDic setValue:@"setPerson" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:personMessageDic];
    WLLog(@"method = %@,\n url = %@",personMessageDic[kMethod],personMessageDic);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
    
}

//获取分类
+(void)getCategoryWithParam:(NSDictionary *)param usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary* inquireCategoryDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [inquireCategoryDic setValue:@"category" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:inquireCategoryDic];
    WLLog(@"method = %@,\n url = %@",inquireCategoryDic[kMethod],inquireCategoryDic);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

//用户添加偏好
+(void)addCategoryWithParam:(NSDictionary *)param usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary* addCategoryDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [addCategoryDic setValue:@"setUserPreference" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:addCategoryDic];
    WLLog(@"method = %@,\n url = %@",addCategoryDic[kMethod],addCategoryDic);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

//忘记密码
+(void)findPwdWithParam:(NSDictionary *)param usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary* addCategoryDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [addCategoryDic setValue:@"findPwd" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:addCategoryDic];
    WLLog(@"method = %@,\n url = %@",addCategoryDic[kMethod],addCategoryDic);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


//登出
+(void)logOutWithParam:(NSDictionary *)param usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary* addCategoryDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [addCategoryDic setValue:@"loginOut" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:addCategoryDic];
    WLLog(@"method = %@,\n url = %@",addCategoryDic[kMethod],addCategoryDic);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

@end
