//
//  WLHttpRequestA.m
//  Mallike
//
//  Created by wangliang on 15/4/18.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "WLHttpRequestA.h"
#import "AFNetworking.h"
#import "WLBaseURLModel.h"
#import "WLBaseURL.h"

@implementation WLHttpRequestA


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
             [[DMCAlertCenter defaultCenter] postAlertWithMessage:error.description];
         }];
}




/**获取浏览根下的分类列表*/
+ (void)getMainCategoryWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.category.main_category" forKey:@"method"];
    NSString *urlString = [WLBaseURLModel catUrlStringParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString
                                Parma:nil
                         SuccessBlock:^(NSDictionary *resultDictionary) {
                             
                             sucessBlock(YES,resultDictionary);
                         } FailureBlock:^(NSError *error) {
                             
                             failureBlock(error);
                         }];
}

/**通过website获取跑马灯*/
+ (void)getPaomadengWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.content.paomadeng" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取产品信息*/
+ (void)getProductProductDetailWithParam:(NSDictionary *)param
                        usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                         andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.product.product_detail" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取一级分类*/
+ (void)getCategoryFirstCategoryWithParam:(NSDictionary *)param
                         usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                          andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.category.first_category" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**根据上级分类获取下级分类*/
+ (void)getCategorySubCategoryWithParam:(NSDictionary *)param
                       usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                        andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.category.sub_category" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取6个热卖产品*/
+ (void)getHotProductsSubCategoryWithParam:(NSDictionary *)param
                          usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                           andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.product.get_hot_products" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


/**获取产品供货商信息*/
+ (void)getProductSupplierWithParam:(NSDictionary *)param
                              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                               andFailureBlock:(void (^)(NSError *resultError))failureBlock {
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.product.supplier" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取供货商项目产品*/
+ (void)getProductSupplierProductCategoryWithParam:(NSDictionary *)param
                                  usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                                   andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.product.supplier_product" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取产品库存信息*/
+ (void)getProductInventoryNumCategoryWithParam:(NSDictionary *)param
                               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                                andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.product.inventory_num" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取产品评论接口*/
+ (void)getProductCommentsWithParam:(NSDictionary *)param
                   usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                    andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.product.get_pro_comments" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取分类产品*/
+ (void)getProductListWithParam:(NSDictionary *)param
               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.product.product_list" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**用户登录接口*/
+ (void)userLoginWithParam:(NSDictionary *)param
          usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
           andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.login" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**1.判断用户是否存在，存在则通过判断用户类型发送短信或邮件*/
+ (void)userSendMessageWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.send_find_pwd_message" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**用户注册*/
+ (void)userRegisterWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.register" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**判断验证码*/
+ (void)userCheckCodeWithParam:(NSDictionary *)param
              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
               andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.check_find_pwd_code" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**找回密码，保存新密码*/
+ (void)userFindPwdWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.find_pwd_save" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**登录认证*/
+ (void)userLoginAuthWithParam:(NSDictionary *)param
              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
               andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.loginauth" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**修改用户信息*/ 
+ (void)userChangeInfoWithParam:(NSDictionary *)param
              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
               andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.person_info" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取用户信息*/
+ (void)userInfoWithParam:(NSDictionary *)param
         usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
          andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.m_info" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


/**获取sessionkey*/
+ (void)userSessionWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.session" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**用户验证信息*/
+ (void)userVerificationWithParam:(NSDictionary *)param
                 usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                  andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.verification" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**修改保存地址*/
+ (void)userAddressWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.address" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取地址列表*/
+ (void)userAddressListWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.addresslist" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**修改密码*/
+ (void)userChangePwdWithParam:(NSDictionary *)param
              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
               andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.change_pwd" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**支付密码 1.启用支付密码*/
+ (void)userPayPwdWithParam:(NSDictionary *)param
           usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
            andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.pay_pwd" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**支付密码 2.修改支付密码*/
+ (void)userPayChangePwdWithParam:(NSDictionary *)param
                 usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                  andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.change_pay_pwd" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.user.headerimage 头像上传*/
+ (void)userHeaderImageWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.headerimage" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


/**com.huihoo.user.add_collect 收藏商品*/
+ (void)userAddCollectionWithParam:(NSDictionary *)param
                  usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                   andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.add_collect" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.user.collect_list 查询收藏商品*/
+ (void)userCollectListionWithParam:(NSDictionary *)param
                   usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                    andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.collect_list" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.user.delete_collect 删除收藏商品*/
+ (void)userDeleteCollectWithParam:(NSDictionary *)param
                  usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                   andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.delete_collect" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}



/**com.huihoo.user.like_add 添加喜欢商品商品*/
+ (void)userAddLikeWithParam:(NSDictionary *)param
               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.like_add" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.user.like_list 查询喜欢的商品*/
+ (void)userLikeListWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.like_list" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.user.delete_like 删除喜欢的商品*/
+ (void)userDeleteLikeWithParam:(NSDictionary *)param
               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.delete_like" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.user.user_message 获取消息列表*/
+ (void)userMessageithParam:(NSDictionary *)param
           usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
            andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.user_message" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


/**com.huihoo.shopping.add_cart_item 添加购物车*/
+ (void)userShoppingAddCartWithParam:(NSDictionary *)param
                    usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                     andFailureBlock:(void (^)(NSError *resultError))failureBlock;{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.shopping.add_cart_item" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.shopping.get_cart_items 获取购物车信息*/
+ (void)userShoppingGetCartWithParam:(NSDictionary *)param
                    usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                     andFailureBlock:(void (^)(NSError *resultError))failureBlock;{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.shopping.get_cart_items" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.shopping.batch_add_cart_item 批量添加购物车*/
+ (void)userShoppingBatchAddCartWithParam:(NSDictionary *)param
                         usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                          andFailureBlock:(void (^)(NSError *resultError))failureBlock;{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.shopping.batch_add_cart_item" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.shopping.update_cart_item_quantity 修改购物车产品数量*/
+ (void)userShoppingChangeNumCartWithParam:(NSDictionary *)param
                          usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                           andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.shopping.update_cart_item_quantity" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.shopping.remove_cart_item 删除购物车中的商品*/
+ (void)userShoppingDeleteCartWithParam:(NSDictionary *)param
                       usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                        andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.shopping.remove_cart_item" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**获取供货商项目产品*/
+ (void)getProductSupplierProductWithParam:(NSDictionary *)param
                          usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                           andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.product.supplier_product" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
    
}

/**com.huihoo.user.loginout 退出登录*/
+ (void)userLoginOutWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.user.loginout" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
    
}


//订单
/**com.huihoo.order.select_payment 选择支付方式*/
+ (void)orderSelectPaymentWithParam:(NSDictionary *)param
                   usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                    andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.select_payment" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.order.confirm 订单确认*/
+ (void)orderConfirmWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock

              andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.confirm" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
    
    
}

/**com.huihoo.order.create 创建订单*/
+ (void)orderCreateWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.create" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
    
}

/**com.huihoo.order.cancle 取消订单*/
+ (void)orderCancelWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.cancle" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**ccom.huihoo.order.shipment.received 确认收货*/
+ (void)orderShipmentReceivedWithParam:(NSDictionary *)param
                      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                       andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.shipment.received" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.order.query_user_orderno 用户根据订单号查询订单*/
+ (void)orderQueryUserOrdernoWithParam:(NSDictionary *)param
                      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                       andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.query_user_orderno" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self postDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.order.query_pay_package 获取app支付包*/
+ (void)orderQueryPayPackageWithParam:(NSDictionary *)param
                     usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                      andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.query_pay_package" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.order.order_synchronization 订单增量同步订单*/
+ (void)odersynchronizeWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.order_synchronization" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.order.order_details 查询订单详情*/
+ (void)orderDetailsWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.order_details" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.order.mpop_pay_secret 银联支付*/
+ (void)orderMpopPaySecretWithParam:(NSDictionary *)param
                   usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                    andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    [dic setValue:@"com.huihoo.order.mpop_pay_secret" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:dic];
    WLLog(@"method = %@;\nurl = %@",dic[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
    
}


//物流接口
/**com.huihoo.logistics.query_shipment 物流查询*/
+ (void)logisticsQueryShipmentWithInfo:(NSDictionary *)dic
                      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                       andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    [param setValue:@"com.huihoo.logistics.query_shipment" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:param];
    WLLog(@"method = %@;\nurl = %@",param[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.logistics.query_shipment_product 包裹商品查询*/
+ (void)logisticsQueryShipmengProductWithInfo:(NSDictionary *)dic
                             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                              andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    [param setValue:@"com.huihoo.logistics.query_shipment_product" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:param];
    WLLog(@"method = %@;\nurl = %@",param[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.geo.provice 获取所有省*/
+ (void)geoProviceWithInfo:(NSDictionary *)dic
          usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
           andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    [param setValue:@"com.huihoo.geo.provice" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:param];
    WLLog(@"method = %@;\nurl = %@",param[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.geo.city 获取省下面的市*/
+ (void)geoCityWithInfo:(NSDictionary *)dic
       usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
        andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    [param setValue:@"com.huihoo.geo.city" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:param];
    WLLog(@"method = %@;\nurl = %@",param[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.geo.county 获取市下面的县或区*/
+ (void)geoCountyWithInfo:(NSDictionary *)dic
         usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
          andFailureBlock:(void (^)(NSError *resultError))failureBlock; {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    [param setValue:@"com.huihoo.geo.county" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:param];
    WLLog(@"method = %@;\nurl = %@",param[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}

/**com.huihoo.geo.ship_info_query 快递100物流查询*/
+ (void)geoShipinfoQueryWithInfo:(NSDictionary *)dic
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock;  {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    [param setValue:@"com.huihoo.geo.ship_info_query" forKey:@"method"];
    NSString *urlString = [WLBaseURL getURLStringWithParameters:param];
    WLLog(@"method = %@;\nurl = %@",param[@"method"],urlString);
    [self getDictionaryWithStringURL:urlString Parma:nil SuccessBlock:^(NSDictionary *resultDictionary) {
        sucessBlock(YES,resultDictionary);
    } FailureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}




@end
