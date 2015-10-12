//
//  UILabel+Addition.m
//  CakeClient
//
//  Created by scjh on 15/3/12.
//  Copyright (c) 2015年 SCJH. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)


- (void)twoColorWith:(NSRange)range
        withOneColor:(UIColor *)color1
         withOneFont:(UIFont *)font1
        withTwoColor:(UIColor *)color2
         withTwoFont:(UIFont *)font2
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    [str addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0,range.length)];
    [str addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(range.length,self.text.length - range.length)];
    [str addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0,range.length)];
    [str addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(range.length,self.text.length - range.length)];
    self.attributedText = str;

}

- (void)addLine {
    
    NSString *oldPrice = self.text;
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [self setAttributedText:attri];
}

@end
