//
//  BaseViewController.h
//  E3
//
//  Created by 王亮 on 15/7/28.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  导航栏左侧按钮
 */
@property (nonatomic, strong) UIButton * leftBtn;
/**
 *  导航栏右侧按钮
 */
@property (nonatomic, strong) UIButton * rightBtn;


/**
 * @brief 返回上一级
 */
-(void)back;

/**
 * @brief 点击右按钮
 */
- (void)clickRightButton;

@end
