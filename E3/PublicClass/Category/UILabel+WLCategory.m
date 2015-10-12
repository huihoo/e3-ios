//
//  UILabel+WLCategory.m
//  TextView
//
//  Created by scjh on 15/6/24.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "UILabel+WLCategory.h"
#import <objc/runtime.h>

static char *AttributeKey = "attributeKey";

@implementation UILabel (WLCategory)

- (void)addLineMidColor:(UIColor *)color withStr:(NSString *)str {
    
    NSString *text = self.text;
    NSRange range = [text rangeOfString:str];
    NSMutableAttributedString *attri = objc_getAssociatedObject(self, &AttributeKey);
//    if (attri == nil) {
    
        attri = [[NSMutableAttributedString alloc] initWithString:text];
//    }else if (![attri.mutableString isEqual:text]) {
//        
//        [attri replaceCharactersInRange:NSMakeRange(0, attri.mutableString.length) withString:text];
//    }
    //线条
    [attri addAttribute:NSStrikethroughStyleAttributeName
                  value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                  range:range];
    //颜色
    [attri addAttribute:NSStrikethroughColorAttributeName
                  value:color
                  range:range];
    [self setAttributedText:attri];
    objc_setAssociatedObject(self, &AttributeKey, attri, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addLineDownColor:(UIColor *)color withStr:(NSString *)str {
    
    NSString *text = self.text;
    NSRange range = [text rangeOfString:str];
    NSMutableAttributedString *attri = objc_getAssociatedObject(self, &AttributeKey);
    if (attri == nil) {
        
        attri = [[NSMutableAttributedString alloc] initWithString:text];
    }else if (![attri.mutableString isEqual:text]) {
        
        [attri replaceCharactersInRange:NSMakeRange(0, attri.mutableString.length - 1) withString:text];
    }
    //线条
    [attri addAttribute:NSUnderlineStyleAttributeName
                  value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                  range:range];
    //颜色
    [attri addAttribute:NSUnderlineColorAttributeName
                  value:color
                  range:range];
    [self setAttributedText:attri];
    objc_setAssociatedObject(self, &AttributeKey, attri, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addMoreStates:(NSArray *)states {
    
    NSString *text = self.text;
    NSMutableAttributedString *attri = objc_getAssociatedObject(self, &AttributeKey);
    if (attri == nil) {
        
        attri = [[NSMutableAttributedString alloc] initWithString:text];
    } else if (![attri.mutableString isEqual:text]) {
     
        [attri replaceCharactersInRange:NSMakeRange(0, attri.mutableString.length - 1) withString:text];
    }
    for (int i = 0; i < states.count; i ++) {
        
        NSDictionary *dic = states[i];
        NSString *str = dic[@"text"];
        NSRange range = [text rangeOfString:str];
        if (dic[@"font"]) {
            //字体
            UIFont *font = dic[@"font"];
            [attri addAttribute:NSFontAttributeName value:font range:range];
        }
        if (dic[@"color"]) {
            //颜色
            UIColor *color = dic[@"color"];
            [attri addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
    self.attributedText = attri;
    objc_setAssociatedObject(self, &AttributeKey, attri, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addLinesBetween:(CGFloat)between {
    
    self.numberOfLines = 0;
    NSString *text = self.text;
    NSMutableAttributedString *attri = objc_getAssociatedObject(self, &AttributeKey);
    if (attri == nil) {
        
        attri = [[NSMutableAttributedString alloc] initWithString:text];
    }else if (![attri.mutableString isEqual:text]) {
        
        [attri replaceCharactersInRange:NSMakeRange(0, attri.mutableString.length - 1) withString:text];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = between;//字的行间距的高度
    [attri addAttribute:NSParagraphStyleAttributeName
                  value:paragraphStyle
                  range:NSMakeRange(0, text.length)];
    self.attributedText = attri;
    [self sizeToFit];
    objc_setAssociatedObject(self, &AttributeKey, attri, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
