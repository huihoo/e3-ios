//
//  ProductSuplierCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/19.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "ProductSuplierCollectionViewCell.h"
#import "NSString+Addition.h"
#import "AutoWideButton.h"

typedef enum {
    
    StateLeft = 0,
    StateMiddle,
    StateRight,
} State;

@implementation ProductSuplierCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self UI];
    }
    return self;
}

- (void)UI {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 70, 70)];
    imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"iconfont-lladdresshome"];
    
    UILabel *nameLabel= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 5, 200, 30)];
    nameLabel.text = @"供货商户名";
    [self addSubview:nameLabel];
    nameLabel.center = CGPointMake(nameLabel.center.x, imageView.center.y);
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    [self addRainNumView:imageView withState:StateLeft];
    [self addRainNumView:imageView withState:StateMiddle];
    UIView *stateView = [self addRainNumView:imageView withState:StateRight];
    [self addNumView:stateView withState:StateLeft];
    [self addNumView:stateView withState:StateMiddle];
}

- (UIView *)addRainNumView:(UIView *)lastView withState:(State)state {
    
    NSArray *array = @[@"发货速度 4.9 ",@"服务态度 4.9 ",@"描述相符 4.9 "];
    UILabel *label = [[UILabel alloc] init];
    label.text = array[state];
    label.font = [UIFont systemFontOfSize:14];
    CGSize size = [label.text sizeWithFont:label.font maxSize:CGSizeMake(200, 200)];
    label.frame = CGRectMake(0, CGRectGetMaxY(lastView.frame) + 10, size.width, size.height);
    [self addSubview:label];
    label.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    
    CGPoint center = label.center;
    if (state == StateLeft) {
        
        center.x = CGRectGetWidth(label.frame) / 2 + 10;
    }else if (state == StateMiddle) {
        
        center.x = CGRectGetWidth(self.frame) / 2 - 10;
    }else if(state == StateRight) {
        
        center.x = IOS_IPHONE_WINDOW_WIDE - CGRectGetWidth(label.frame) / 2 - 30;
    }
    label.center = center;
    
    UILabel *levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, 20, 20)];
    levelLabel.center = CGPointMake(levelLabel.center.x, label.center.y);
    levelLabel.text = @"高";
    levelLabel.font = [UIFont systemFontOfSize:12];
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.backgroundColor = WLColor(22, 169, 234);
    levelLabel.layer.cornerRadius = 5;
    levelLabel.clipsToBounds = YES;
    [self addSubview:levelLabel];
    return label;
}

- (void)addNumView:(UIView *)lastView withState:(State)state {
    
    float centerX = 0.0;
    if (state == StateLeft) {
        
        centerX = CGRectGetWidth(self.frame) / 4;
    }else if (state == StateMiddle) {
        
        centerX = CGRectGetWidth(self.frame) / 4 * 3;
    }
    NSArray *array = @[@{@"name":@"全部宝贝",@"btn":@"查看宝贝分类",@"num":@"469"},
                       @{@"name":@"关注人数",@"btn":@"进店逛逛吧",@"num":@"3.3万"}];
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lastView.frame) + 15, CGRectGetWidth(self.frame) / 2, 30)];
    numLabel.text = array[state][@"num"];
    numLabel.center = CGPointMake(centerX, numLabel.center.y);
    numLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:numLabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numLabel.frame), CGRectGetWidth(self.frame) / 2, 10)];
    descLabel.text = array[state][@"name"];
    descLabel.font = [UIFont boldSystemFontOfSize:12];
    descLabel.center = CGPointMake(numLabel.center.x, descLabel.center.y);
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    [self addSubview:descLabel];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = array[state][@"btn"];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    AutoWideButton *autoBtn = [[AutoWideButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(descLabel.frame) + 10, 0, 0) withLabel:label];
    [self addSubview:autoBtn];
    autoBtn.center = CGPointMake(numLabel.center.x, autoBtn.center.y);
    
}

@end
