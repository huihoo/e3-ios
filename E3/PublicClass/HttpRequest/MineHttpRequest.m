//
//  MineHttpRequest.m
//  Mallike
//
//  Created by colin liao on 5/13/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "MineHttpRequest.h"
#import "AFNetworking.h"
#import "WLBaseURLModel.h"
//#import "AppManager.h"

@implementation MineHttpRequest

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

//获取订单
+(void)getOrderWithParam:(NSDictionary *)param usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary* orderDic =[NSMutableDictionary dictionaryWithDictionary:param];
    [orderDic setValue:@"getUserOrders" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:orderDic];
    WLLog(@"method = %@,\n url = %@",orderDic[kMethod],orderDic);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

//修改邮箱接口
+(void)changeEmailWithParam:(NSDictionary *)param usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"changeEmail" forKey:kMethod];
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


//更改密码
+(void)changePasswordWithParam:(NSDictionary *)param usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary* changePasswordDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [changePasswordDic setValue:@"changePwd" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:changePasswordDic];
    WLLog(@"method = %@,\n url = %@",changePasswordDic[kMethod],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


//获取follower 和following
+(void)getFollowerOrFollowingWithParam:(NSDictionary *)param usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock andFailureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"qryPartyToParty" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:dic];
    WLLog(@"method = %@,\n url = %@",dic[kMethod],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

//取消关注
+(void)removeFollowingWithParam:(NSDictionary *)param usingSucessBlock:(void (^)(BOOL, NSDictionary *))sucessBlock andFailureBlock:(void (^)(NSError *))failureBlock

{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"cannelMutualConcern" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:dic];
    WLLog(@"method = %@,\n url = %@",dic[kMethod],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


//查询用户消息
+(void)qryUserMessageWithParam:(NSDictionary*)param
              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
               andFailureBlock:(void(^)(NSError* resultError))failureBlock
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"qryUserMessage" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:dic];
    WLLog(@"method = %@,\n url = %@",dic[kMethod],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


//查询用户中心数据
+(void)qryUserCenterWithParam:(NSDictionary*)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
              andFailureBlock:(void(^)(NSError* resultError))failureBlock
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"qryUserCenter" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:dic];
    WLLog(@"method = %@,\n url = %@",dic[kMethod],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

//查询用户中心收藏夹
+(void)qryUserCollectFolderListWithParam:(NSDictionary*)param
                        usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
                         andFailureBlock:(void(^)(NSError* resultError))failureBlock
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"qryUserCollectFolderList" forKey:kMethod];
    NSString* urlString = [WLBaseURLModel catUrlStringParameters:dic];
    WLLog(@"method = %@,\n url = %@",dic[kMethod],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


@end
