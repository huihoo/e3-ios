//
//  NSString+Addition.m
//  Mallike
//
//  Created by wangliang on 15/5/2.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
