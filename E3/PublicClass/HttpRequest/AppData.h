//
//  AppData.h
//  E3
//
//  Created by 王亮 on 15/8/16.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DataSuccessBlock)(NSDictionary *dic);

@interface AppData : NSObject

+ (instancetype)shareData;

/** com.huihoo.category.main_category 获取浏览根下的分类列表*/
- (void)mainCategroyWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.content.paomadeng 通过website获取跑马灯*/
- (void)contentPaomadengWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.product.product_detail 获取产品信息*/
- (void)productProductDetailWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.category.first_category 获取一级分类*/
- (void)fistCategoryWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.category.sub_category 根据上级分类获取下级分类*/
- (void)subCategoryWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.product.get_hot_products 获取6个热卖产品*/
- (void)hotProductsWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.product.supplier 获取产品供货商信息*/
- (void)productSuppliersWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.product.supplier_product 获取供货商项目产品*/
- (void)productSupplierProductWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.product.inventory_num 获取产品库存信息*/
- (void)productInventoryNumWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.product.get_pro_comments 获取产品评论接口*/
- (void)productCommentsWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.product.product_list 获取分类产品*/
- (void)productListWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;

//用户
/**com.huihoo.user.login 用户登录接口*/
- (void)userLoginWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**基础com.huihoo.user.send_find_pwd_message 1.判断用户是否存在，存在则通过判断用户类型发送短信或邮件*/
- (void)userSendMessageWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.register 用户注册*/
- (void)userRegisterWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.check_find_pwd_code 判断验证码*/
- (void)userCheckCodeWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.find_pwd_save 找回密码，保存新密码*/
- (void)userFindPwdWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.loginauth 登录认证*/
- (void)userLoginAuthWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.person_info 修改用户信息*/
- (void)userChangeInfoWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.m_info 获取用户信息*/
- (void)userInfoWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.session 获取sessionkey*/
- (void)userSessionWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.verification 用户验证信息*/
- (void)userVerificationWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.address 修改保存地址*/
- (void)userAddressWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.addresslist 获取地址列表*/
- (void)userAddressListWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.change_pwd 修改密码*/
- (void)userChangePwdWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.pay_pwd 支付密码 1.启用支付密码*/
- (void)userPayPwdWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.change_pay_pwd 支付密码 2.修改支付密码*/
- (void)userPayChangePwdWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.headerimage 头像上传*/
- (void)userHeaderImageWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.add_collect 收藏商品*/
- (void)userAddCollectWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.collect_list 查询收藏商品*/
- (void)userCollectListWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.delete_collect 删除收藏商品*/
- (void)userDeleteCollectWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.like_add 添加喜欢商品商品*/
- (void)userAddLikeWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.like_list 查询喜欢的商品*/
- (void)userLikeListWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.delete_like 删除喜欢的商品*/
- (void)userDeleteLikeWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.user_message 获取消息列表*/
- (void)userMessageWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
///**com.huihoo.user.user_message 获取消息列表*/
//- (void)userMessageWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;

//购物车
/**com.huihoo.shopping.add_cart_item 添加购物车*/
- (void)userShoppingAddCartWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.shopping.get_cart_items 获取购物车信息*/
- (void)userShoppingGetCartWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.shopping.batch_add_cart_item 批量添加购物车*/
- (void)userShoppingBatchAddCartWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.shopping.update_cart_item_quantity 修改购物车产品数量*/
- (void)userShoppingChangeNumCartWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**ccom.huihoo.shopping.remove_cart_item 删除购物车中的商品*/
- (void)userShoppingDeleteCartWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.user.loginout 退出登录*/
- (void)userLoginOutWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;

//订单
/**com.huihoo.order.select_payment 选择支付方式*/
- (void)orderSelectPaymentWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.order.confirm 订单确认*/
- (void)orderConfirmWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.order.create 创建订单*/
- (void)orderCreateWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.order.cancle 取消订单*/
- (void)orderCancelWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**ccom.huihoo.order.shipment.received 确认收货*/
- (void)orderShipmentReceivedWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.order.query_user_orderno 用户根据订单号查询订单*/
- (void)orderQueryUserOrdernoWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.order.query_pay_package 获取app支付包*/
- (void)orderQueryPayPackageWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.order.order_synchronization 订单增量同步订单*/
- (void)odersynchronizeWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.order.order_details 查询订单详情*/
- (void)orderDetailsWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.order.mpop_pay_secret 银联支付*/
- (void)orderMpopPaySecretWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;

//物流接口
/**com.huihoo.logistics.query_shipment 物流查询*/
- (void)logisticsQueryShipmentWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.logistics.query_shipment_product 包裹商品查询*/
- (void)logisticsQueryShipmengProductWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.geo.provice 获取所有省*/
- (void)geoProviceWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.geo.city 获取省下面的市*/
- (void)geoCityWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.geo.county 获取市下面的县或区*/
- (void)geoCountyWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;
/**com.huihoo.geo.ship_info_query 快递100物流查询*/
- (void)geoShipinfoQueryWithInfo:(NSDictionary *)dic withFinishBlock:(DataSuccessBlock)block;

@end
