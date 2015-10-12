//
//  UITextView+WLCategory.m
//  h5Test
//
//  Created by scjh on 15/6/23.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "UITextView+WLCategory.h"

#import <objc/runtime.h>

static char *textViewPHLabelKey = "PHlabel";
static char *textViewAccountNumLabelKey = "accountNumlabel";
static char *textViewNumKey = "numKey";

@implementation UITextView (WLCategory)


- (void)addPlaceholder:(UILabel *)placeholderLabel {
    
    UILabel *accountNumLabel = objc_getAssociatedObject(self, &textViewPHLabelKey);
    if (accountNumLabel == nil) {
        
        self.delegate = self;
    }
    //复制视图
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:placeholderLabel];
    UILabel *PHLabel = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    PHLabel.font = self.font;
    CGFloat originX = self.textContainerInset.left;
    CGFloat originY = self.textContainerInset.top;
    CGFloat wide = CGRectGetWidth(self.frame) - self.textContainerInset.left - self.textContainerInset.right;
    CGFloat high = CGRectGetHeight(self.frame) - self.textContainerInset.top - self.textContainerInset.bottom;
    CGSize  marskSize = CGSizeMake(wide, high);
    CGRect textRect = [PHLabel.text boundingRectWithSize:marskSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:PHLabel.font} context:nil];
    PHLabel.frame = CGRectMake(originX, originY, wide, textRect.size.height);
    PHLabel.numberOfLines = 0;
    [self addSubview:PHLabel];

    objc_setAssociatedObject(self, &textViewPHLabelKey, PHLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    PHLabel.hidden = self.text.length > 0;
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)addAccountNum:(NSInteger)num {
    
    objc_setAssociatedObject(self, &textViewNumKey, @(num), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *PHLabel = objc_getAssociatedObject(self, &textViewPHLabelKey);
    if (PHLabel == nil) {
        
        self.delegate = self;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UITextViewTextDidChangeNotification object:nil];
    NSString *numStr = [NSString stringWithFormat:@"%ld",(long)num];
    CGFloat wide = CGRectGetWidth(self.frame) - self.textContainerInset.left - self.textContainerInset.right;
    CGFloat high = CGRectGetHeight(self.frame) - self.textContainerInset.top - self.textContainerInset.bottom;
    CGSize  marskSize = CGSizeMake(wide, high);
    CGRect textRect = [numStr boundingRectWithSize:marskSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    CGRect frame = CGRectMake(CGRectGetWidth(self.frame) - textRect.size.width - self.textContainerInset.right, CGRectGetHeight(self.frame) - textRect.size.height - self.textContainerInset.bottom, textRect.size.width, textRect.size.height);


    UILabel *accountNumLabel = [[UILabel alloc] initWithFrame:frame];
    accountNumLabel.text = numStr;
    accountNumLabel.font = self.font;
    [self addSubview:accountNumLabel];
    
    objc_setAssociatedObject(self, &textViewAccountNumLabelKey, accountNumLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)textViewDidChange:(UITextView *)textView {
    
    UILabel *PHLabel = objc_getAssociatedObject(self, &textViewPHLabelKey);
    UILabel *accountNumLabel = objc_getAssociatedObject(self, &textViewAccountNumLabelKey);
    NSInteger allNum = [objc_getAssociatedObject(self, &textViewNumKey) integerValue];
    if (PHLabel != nil) {
        
        if (textView.text.length > 0) {
            
            PHLabel.hidden = YES;
        }else {
            
            PHLabel.hidden = NO;
        }
    }
    if (accountNumLabel != nil) {
        
        NSInteger currNum = textView.text.length;
        NSInteger moreNum = allNum - currNum;
        if (moreNum < 0) {
            
            moreNum = 0;
        }
        accountNumLabel.text = [NSString stringWithFormat:@"%ld",(long)moreNum];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    UILabel *accountNumLabel = objc_getAssociatedObject(self, &textViewAccountNumLabelKey);
    if (accountNumLabel == nil) {
        
        return YES;
    }else {
     
        NSInteger currNum = [accountNumLabel.text integerValue];
        if (currNum > 0) {
            
            return YES;
        }else {
            
            if ([text isEqual:@""]) {
                return YES;
            }
            return NO;
        }
    }
}

- (void)change:(NSNotification *)noti {
    
    
    UILabel *accountNumLabel = objc_getAssociatedObject(noti.object, &textViewAccountNumLabelKey);
    if (accountNumLabel == nil) {
        
        return;
    }
    NSInteger allNum = [objc_getAssociatedObject(noti.object, &textViewNumKey) integerValue];
    UITextView *textView = (UITextView *)noti.object;
    NSString *toBeString = textView.text;
    NSString *langModel = [[UITextInputMode currentInputMode] primaryLanguage];
    if ([langModel isEqualToString:@"zh-Hans"]) {
        
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            
            if (toBeString.length > allNum) {
                
                textView.text = [toBeString substringToIndex:allNum];
            }
        }
    }else {
        
        if (toBeString.length > allNum) {
            
            textView.text = [toBeString substringToIndex:allNum];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSString *string = change[NSKeyValueChangeNewKey];
    UILabel *PHLabel = objc_getAssociatedObject(self, &textViewPHLabelKey);
    PHLabel.hidden = string.length > 0;
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"text" context:nil];
}


@end
