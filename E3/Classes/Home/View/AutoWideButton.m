//
//  AutoWideButton.m
//  E3
//
//  Created by 王亮 on 15/8/19.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "AutoWideButton.h"
#import "NSString+Addition.h"

@implementation AutoWideButton


- (instancetype)initWithFrame:(CGRect)frame withLabel:(UILabel *)label {
    
    if (self = [super initWithFrame:frame]) {
        
        CGSize size = [label.text sizeWithFont:label.font maxSize:CGSizeMake(IOS_IPHONE_WINDOW_WIDE, MAXFLOAT)];
        [self setTitle:label.text forState:UIControlStateNormal];
        [self setTitleColor:label.textColor forState:UIControlStateNormal];
        self.titleLabel.font = label.font;
        size.width += 20;
        size.height += 20;
        frame.size = size;
        self.frame = frame;
        
        self.layer.cornerRadius = 5;
        self.layer.borderColor = label.textColor.CGColor;
        self.layer.borderWidth = 0.5;
    
    }
    return self;
}


@end
