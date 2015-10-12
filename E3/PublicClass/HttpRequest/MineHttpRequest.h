//
//  MineHttpRequest.h
//  Mallike
//
//  Created by colin liao on 5/13/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineHttpRequest : NSObject


//获取订单
+(void)getOrderWithParam:(NSDictionary*)param
        usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
         andFailureBlock:(void(^)(NSError* resultError))failureBlock;

/**个人中心修改邮箱*/
+ (void)changeEmailWithParam:(NSDictionary *)param
           usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
            andFailureBlock:(void (^)(NSError *resultError))failureBlock;
/**个人中心修改密码*/
+ (void)changePasswordWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock;

//获取用户关注与被关注
+(void)getFollowerOrFollowingWithParam:(NSDictionary*)param
                      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock

                       andFailureBlock:(void(^)(NSError* resultError))failureBlock;
//移除关注
+(void)removeFollowingWithParam:(NSDictionary*)param
               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
                andFailureBlock:(void(^)(NSError* resultError))failureBlock;

//查询用户消息
+(void)qryUserMessageWithParam:(NSDictionary*)param
              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
               andFailureBlock:(void(^)(NSError* resultError))failureBlock;

//查询用户中心数据
+(void)qryUserCenterWithParam:(NSDictionary*)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
              andFailureBlock:(void(^)(NSError* resultError))failureBlock;


//查询用户中心收藏夹
+(void)qryUserCollectFolderListWithParam:(NSDictionary*)param
                        usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary* resultDictionary))sucessBlock
                         andFailureBlock:(void(^)(NSError* resultError))failureBlock;
@end
