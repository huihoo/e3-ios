//
//  SelectSizeCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/20.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "SelectSizeCollectionViewCell.h"
#import "AutoWideButton.h"
#import "UIImage+WLCategory.h"

@interface SelectSizeCollectionViewCell ()

@property(nonatomic,strong)AutoWideButton *lastBtn;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)NSArray *sizeArr;

@end

@implementation SelectSizeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self UI];
    }
    return self;
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",infoDic[@"key"]];
    self.sizeArr = infoDic[infoDic[@"key"]];
    
    [self addRainView:self.nameLabel];
}

- (void)UI {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
    label.text = @"净含量";
    label.font = [UIFont boldSystemFontOfSize:15];
    self.nameLabel = label;
    [self addSubview:label];
    
    [self addRainView:label];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
}


- (UIView *)addRainView:(UIView *)lastView {
    
    for (int i = 0; i < self.subviews.count; i ++) {
        
        id sub = self.subviews[i];
        if ([sub isKindOfClass:[UIButton class]]) {
            
            [sub removeFromSuperview];
            i --;
        }
    }
    
    AutoWideButton *lastAutoBtn = nil;
    CGFloat between = 10;
    
    for (int i = 0; i < self.sizeArr.count; i ++) {
        
        if (i == 0) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.sizeArr[0]];
            dic[@"key"] = self.infoDic[@"key"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selectSize" object:nil userInfo:dic];
        }
        UILabel *label = [[UILabel alloc] init];
        label.text = self.sizeArr[i][@"description"];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
        
        AutoWideButton *autoBtn = [[AutoWideButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(lastView.frame), 0, 0) withLabel:label];
        autoBtn.btnDic = self.sizeArr[i];
        [autoBtn setBackgroundImage:[UIImage initWithColor:Color_Blue] forState:UIControlStateSelected];
        [autoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        if (lastAutoBtn) {
            
            CGRect frame = lastAutoBtn.frame;
            CGRect btnFrame = autoBtn.frame;
            btnFrame.origin.y = frame.origin.y;
            CGFloat allWide = CGRectGetMaxX(frame) + autoBtn.frame.size.width + 2 * between;
            if (allWide > IOS_IPHONE_WINDOW_WIDE) {
                
                btnFrame.origin.y += CGRectGetHeight(frame) + between;
            }else {
                btnFrame.origin.x += CGRectGetMaxX(frame);
                
            }
            autoBtn.frame = btnFrame;
        }else {
            
            self.lastBtn = autoBtn;
            self.lastBtn.selected = YES;
        }
        lastAutoBtn = autoBtn;
        [autoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        autoBtn.clipsToBounds = YES;
        [self addSubview:autoBtn];
    }
    return lastAutoBtn;
}

- (void)btnAction:(UIButton *)sender {
    
    self.lastBtn.selected = NO;
    sender.selected = YES;
    self.lastBtn = (AutoWideButton *)sender;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.lastBtn.btnDic];
    dic[@"key"] = self.infoDic[@"key"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectSize" object:nil userInfo:dic];
}

@end
