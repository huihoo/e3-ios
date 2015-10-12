//
//  WLHttpRequestA.h
//  Mallike
//
//  Created by wangliang on 15/4/18.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLHttpRequestA : NSObject

/**获取浏览根下的分类列表*/
+ (void)getMainCategoryWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock;


/**通过website获取跑马灯*/
+ (void)getPaomadengWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取产品信息*/
+ (void)getProductProductDetailWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取一级分类*/
+ (void)getCategoryFirstCategoryWithParam:(NSDictionary *)param
                        usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                         andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**根据上级分类获取下级分类*/
+ (void)getCategorySubCategoryWithParam:(NSDictionary *)param
                         usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                          andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取6个热卖产品*/
+ (void)getHotProductsSubCategoryWithParam:(NSDictionary *)param
                       usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                        andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取产品供货商信息*/
+ (void)getProductSupplierWithParam:(NSDictionary *)param
                          usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                           andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取供货商项目产品*/
+ (void)getProductSupplierProductWithParam:(NSDictionary *)param
                              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                               andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取产品库存信息*/
+ (void)getProductInventoryNumWithParam:(NSDictionary *)param
                                  usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                                   andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取产品评论接口*/
+ (void)getProductCommentsWithParam:(NSDictionary *)param
                               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                                andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取分类产品*/
+ (void)getProductListWithParam:(NSDictionary *)param
                   usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                    andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**用户登录接口*/
+ (void)userLoginWithParam:(NSDictionary *)param
               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**1.判断用户是否存在，存在则通过判断用户类型发送短信或邮件*/ 
+ (void)userSendMessageWithParam:(NSDictionary *)param
          usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
           andFailureBlock:(void (^)(NSError *resultError))failureBlock;


/**用户注册*/
+ (void)userRegisterWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**判断验证码*/
+ (void)userCheckCodeWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**找回密码，保存新密码*/ //待验证
+ (void)userFindPwdWithParam:(NSDictionary *)param
              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
               andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**登录认证*/
+ (void)userLoginAuthWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**修改用户信息*/ //待验证
+ (void)userChangeInfoWithParam:(NSDictionary *)param
              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
               andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取用户信息*/
+ (void)userInfoWithParam:(NSDictionary *)param
               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取sessionkey*/
+ (void)userSessionWithParam:(NSDictionary *)param
         usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
          andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**用户验证信息*/
+ (void)userVerificationWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**修改保存地址*/
+ (void)userAddressWithParam:(NSDictionary *)param
                 usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                  andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**获取地址列表*/
+ (void)userAddressListWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**修改密码*/
+ (void)userChangePwdWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**支付密码 1.启用支付密码*/
+ (void)userPayPwdWithParam:(NSDictionary *)param
              usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
               andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**支付密码 2.修改支付密码*/
+ (void)userPayChangePwdWithParam:(NSDictionary *)param
           usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
            andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.user.headerimage 头像上传*/
+ (void)userHeaderImageWithParam:(NSDictionary *)param
                 usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                  andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.user.add_collect 收藏商品*/
+ (void)userAddCollectionWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock;


/**com.huihoo.user.collect_list 查询收藏商品*/
+ (void)userCollectListionWithParam:(NSDictionary *)param
                  usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                   andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.user.delete_collect 删除收藏商品*/
+ (void)userDeleteCollectWithParam:(NSDictionary *)param
               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.user.like_add 添加喜欢商品商品*/
+ (void)userAddLikeWithParam:(NSDictionary *)param
                   usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                    andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.user.like_list 查询喜欢的商品*/
+ (void)userLikeListWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.user.delete_like 删除喜欢的商品*/
+ (void)userDeleteLikeWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.user.user_message 获取消息列表*/
+ (void)userMessageithParam:(NSDictionary *)param
               usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.shopping.add_cart_item 添加购物车*/
+ (void)userShoppingAddCartWithParam:(NSDictionary *)param
                    usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                     andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.shopping.get_cart_items 获取购物车信息*/
+ (void)userShoppingGetCartWithParam:(NSDictionary *)param
                    usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                     andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.shopping.batch_add_cart_item 批量添加购物车*/
+ (void)userShoppingBatchAddCartWithParam:(NSDictionary *)param
                         usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                          andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.shopping.update_cart_item_quantity 修改购物车产品数量*/
+ (void)userShoppingChangeNumCartWithParam:(NSDictionary *)param
                          usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                           andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.shopping.remove_cart_item 删除购物车中的商品*/
+ (void)userShoppingDeleteCartWithParam:(NSDictionary *)param
                       usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                        andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.user.loginout 退出登录*/
+ (void)userLoginOutWithParam:(NSDictionary *)param
                       usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                        andFailureBlock:(void (^)(NSError *resultError))failureBlock;


//订单
/**com.huihoo.order.select_payment 选择支付方式*/
+ (void)orderSelectPaymentWithParam:(NSDictionary *)param
                   usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                    andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.order.confirm 订单确认*/
+ (void)orderConfirmWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.order.create 创建订单*/
+ (void)orderCreateWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.order.cancle 取消订单*/
+ (void)orderCancelWithParam:(NSDictionary *)param
            usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
             andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**ccom.huihoo.order.shipment.received 确认收货*/
+ (void)orderShipmentReceivedWithParam:(NSDictionary *)param
                      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                       andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.order.query_user_orderno 用户根据订单号查询订单*/
+ (void)orderQueryUserOrdernoWithParam:(NSDictionary *)param
                      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                       andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.order.query_pay_package 获取app支付包*/
+ (void)orderQueryPayPackageWithParam:(NSDictionary *)param
                     usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                      andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.order.order_synchronization 订单增量同步订单*/
+ (void)odersynchronizeWithParam:(NSDictionary *)param
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.order.order_details 查询订单详情*/
+ (void)orderDetailsWithParam:(NSDictionary *)param
             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
              andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.order.mpop_pay_secret 银联支付*/
+ (void)orderMpopPaySecretWithParam:(NSDictionary *)param
                   usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                    andFailureBlock:(void (^)(NSError *resultError))failureBlock;


//物流接口
/**com.huihoo.logistics.query_shipment 物流查询*/
+ (void)logisticsQueryShipmentWithInfo:(NSDictionary *)dic
                      usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                       andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.logistics.query_shipment_product 包裹商品查询*/
+ (void)logisticsQueryShipmengProductWithInfo:(NSDictionary *)dic
                             usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                              andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.geo.provice 获取所有省*/
+ (void)geoProviceWithInfo:(NSDictionary *)dic
          usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
           andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.geo.city 获取省下面的市*/
+ (void)geoCityWithInfo:(NSDictionary *)dic
       usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
        andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.geo.county 获取市下面的县或区*/
+ (void)geoCountyWithInfo:(NSDictionary *)dic
         usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
          andFailureBlock:(void (^)(NSError *resultError))failureBlock;

/**com.huihoo.geo.ship_info_query 快递100物流查询*/
+ (void)geoShipinfoQueryWithInfo:(NSDictionary *)dic
                usingSucessBlock:(void(^)(BOOL isSucess,NSDictionary * resultDictionary))sucessBlock
                 andFailureBlock:(void (^)(NSError *resultError))failureBlock;


@end
