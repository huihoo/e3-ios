//
//  UILabel+Addition.h
//  CakeClient
//
//  Created by scjh on 15/3/12.
//  Copyright (c) 2015年 SCJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

//一个label两种颜色
- (void)twoColorWith:(NSRange)range
        withOneColor:(UIColor *)color1
         withOneFont:(UIFont *)font1
        withTwoColor:(UIColor *)color2
         withTwoFont:(UIFont *)font2;

//添加横线
- (void)addLine;

@end
