//
//  UIImage+WLCategory.m
//  E3
//
//  Created by 王亮 on 15/8/20.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "UIImage+WLCategory.h"

@implementation UIImage (WLCategory)

+ (UIImage *)initWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
