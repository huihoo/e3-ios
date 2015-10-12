//
//  UITextField+WLCategory.m
//  TextView
//
//  Created by scjh on 15/6/24.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "UITextField+WLCategory.h"

#import <objc/runtime.h>

static char *textFieldNumKey = "numKey";

@implementation UITextField (WLCategory)

- (void)addAccountNum:(NSInteger)num {
    
    objc_setAssociatedObject(self, &textFieldNumKey, @(num), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(numAction:) forControlEvents:UIControlEventEditingChanged];
}

- (void)numAction:(UITextField *)textField {
    

    NSInteger allNum = [objc_getAssociatedObject(textField, &textFieldNumKey) integerValue];
    NSString *toBeString = textField.text;
    NSString *langModel = [[UITextInputMode currentInputMode] primaryLanguage];
    if ([langModel isEqualToString:@"zh-Hans"]) {
        
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            
            if (toBeString.length > allNum) {
                
                textField.text = [toBeString substringToIndex:allNum];
            }
        }
    }else {
        
        if (toBeString.length > allNum) {
            
            textField.text = [toBeString substringToIndex:allNum];
        }
    }
}

@end
