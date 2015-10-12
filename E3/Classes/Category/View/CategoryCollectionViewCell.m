//
//  CategoryCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/24.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@interface CategoryCollectionViewCell ()

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation CategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self UI];
    }
    return self;
}

- (void)UI {
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.text = @"sfsfa";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.nameLabel = label;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.center = CGPointMake(imageView.center.x, CGRectGetHeight(self.frame) / 2);
    [self addSubview:imageView];
    self.imageView = imageView;
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.nameLabel.text = infoDic[@"category_name"];

    id urlStr = infoDic[@"category_image_url"];
    if (![urlStr isKindOfClass:[NSNull class]]) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_Url,urlStr]];
        [self.imageView sd_setImageWithURL:url];
    }
}

@end
