//
//  UILabel+WLCategory.h
//  TextView
//
//  Created by scjh on 15/6/24.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WLCategory)

/**
*   添加Label的str中间一条横线
*   @param color  线条颜色
*   @param str 线条添加到上的文字
*/
- (void)addLineMidColor:(UIColor *)color withStr:(NSString *)str;

/**
 *   添加Label的str下添加一条下划线
 *   @param color  线条颜色
 *   @param str 线条添加到上的文字
 */
- (void)addLineDownColor:(UIColor *)color withStr:(NSString *)str;

/**
*   添加多种样式
*   @param states 数组({"text":"必须","font":@"UIFont","color":"UIColor"},...)
*/
- (void)addMoreStates:(NSArray *)states;
/**
*   设置label的行间距
*   @param between 行间距的值
*/
- (void)addLinesBetween:(CGFloat)between;

@end
