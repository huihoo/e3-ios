//
//  OrderHeadView.m
//  E3
//
//  Created by 王亮 on 15/9/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "OrderHeadView.h"

@interface OrderHeadView ()

@property(nonatomic,strong)UILabel *oderLabel;

@end

@implementation OrderHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        [self UI];
    }
    return self;
}

- (void)UI {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame) - 20, CGRectGetHeight(self.frame))];
    [self addSubview:label];
    label.text = @"选择支付方式";
    self.backgroundColor =  [UIColor colorWithWhite:0.9 alpha:0.5];
    self.oderLabel = label;
}

- (void)setDescStr:(NSString *)descStr {
    
    _descStr = descStr;
    self.oderLabel.text = descStr;
}

@end
