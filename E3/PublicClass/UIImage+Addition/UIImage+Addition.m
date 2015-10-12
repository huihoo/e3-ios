//
//  UIImage+Addition.m
//  EasyOrder
//
//  Created by scjh on 14/12/30.
//  Copyright (c) 2014年 wangliang0. All rights reserved.
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)

+ (UIImage *) createImageWithColor: (UIColor *) color {
    
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
