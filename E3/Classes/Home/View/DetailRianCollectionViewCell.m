//
//  DetailRianCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/19.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "DetailRianCollectionViewCell.h"
#import "AutoWideButton.h"
#import "NSString+Addition.h"
@implementation DetailRianCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self UI];
    }
    return self;
}


- (void)UI {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
    label.text = @"宝贝评价";
    label.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:label];
    UIView *btnView = [self addRainView:label];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(btnView.frame) + 10, CGRectGetWidth(self.frame) - 10, 0.5)];
    lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self addSubview:lineView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView.frame) + 10, 60, 60)];
    imageView.image = [UIImage imageNamed:@"iconfont-yonghu"];
    imageView.layer.cornerRadius = CGRectGetWidth(imageView.frame) / 2;
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    imageView.layer.borderWidth = 0.5;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10, 0, 200, 30)];
    nameLabel.center = CGPointMake(nameLabel.center.x, imageView.center.y);
    nameLabel.text = @"用户**1";
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:nameLabel];
    
    
    NSString *rainStr = @"颜色和图片上的一样，没有色差，穿上以后也没有想象中的显黑，反而显白,颜色和图片上的一样，没有色差，穿上以后也没有想象中的显黑，反而显白";
    
    UILabel *rainLabel = [[UILabel alloc] init];
    rainLabel.text = rainStr;
    CGSize labelSize = [rainStr sizeWithFont:rainLabel.font maxSize:CGSizeMake(IOS_IPHONE_WINDOW_WIDE - 20, MAXFLOAT)];
    rainLabel.numberOfLines = 0;
    rainLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    rainLabel.frame = CGRectMake(10, CGRectGetMaxY(imageView.frame) + 10, labelSize.width, labelSize.height);
    [self addSubview:rainLabel];
    
    UILabel *smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(rainLabel.frame) + 5, IOS_IPHONE_WINDOW_WIDE - 20, 20)];
    smallLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    smallLabel.text = @"2015 3 22";
    smallLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:smallLabel];
    
    UIView *lineView2 = [[UIView alloc] init];
    CGRect lineFrame = lineView.frame;
    lineFrame.origin.y = CGRectGetMaxY(smallLabel.frame) + 3;
    lineView2.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    lineView2.frame = lineFrame;
    [self addSubview:lineView2];
    
    UIButton *checkMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView2.frame), IOS_IPHONE_WINDOW_WIDE, 50)];
    [checkMoreBtn setTitle:@"查看更多评价" forState:UIControlStateNormal];
    [self addSubview:checkMoreBtn];
    [checkMoreBtn setTitleColor:[[UIColor grayColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
    
}

- (UIView *)addRainView:(UIView *)lastView {
    
    NSArray *arra = @[@"味道好闻（20）",@"服务态度好（12）",@"是正品（12）",@"包装严实（5）",@"快递不错（6）",@"留香时间较短（3）",@"质量好（54）"];
    
    AutoWideButton *lastAutoBtn = nil;
    CGFloat between = 10;
    for (int i = 0; i < arra.count; i ++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.text = arra[i];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
        
        AutoWideButton *autoBtn = [[AutoWideButton alloc] initWithFrame:CGRectMake(between, CGRectGetMaxY(lastView.frame), 0, 0) withLabel:label];
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
        }
        lastAutoBtn = autoBtn;
        [autoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:autoBtn];
    }
    return lastAutoBtn;
}


- (void)btnAction:(UIButton *)sender {
    
    NSLog(@"sfafafa");
}

@end
