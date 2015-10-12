//
//  UITextView+WLCategory.h
//  h5Test
//
//  Created by scjh on 15/6/23.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (WLCategory)<UITextViewDelegate>

/**
*   添加提示文字
*   param placeholderLabel 提示文字的label
*/
- (void)addPlaceholder:(UILabel *)placeholderLabel;
/**
*   添加文字的个数
*   @param num 文字的最大个数
*/
- (void)addAccountNum:(NSInteger)num;

@end
