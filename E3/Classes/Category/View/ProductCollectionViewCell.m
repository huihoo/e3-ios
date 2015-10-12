//
//  ProductCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/27.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "ProductCollectionViewCell.h"
#import "UILabel+WLCategory.h"

@interface ProductCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHigh;

@end

@implementation ProductCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageHigh.constant = (IOS_IPHONE_WINDOW_WIDE - 30)/ 2;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = Color_Gray.CGColor;
    self.layer.borderWidth= 0.5;
    self.backgroundColor = [UIColor whiteColor];
    self.nowPriceLabel.textColor = [UIColor redColor];
    
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.descLabel.text = [infoDic[@"product_name"] isKindOfClass:[NSNull class]] ? @"" : infoDic[@"product_name"];
    NSString *detailStr = infoDic[@"detail_image_url"];
    NSString *largeStr = infoDic[@"large_image_url"];
    NSString *str = IS_NULL(detailStr);
    if ([str isEqual:@""]) {
        
        str = IS_NULL(largeStr);
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Base_Url,str];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    self.nowPriceLabel.text = [NSString stringWithFormat:@"¥%0.2f",[infoDic[@"product_price"][@"default_price"] floatValue]];
    self.oldPriceLabel.text = [NSString stringWithFormat:@"¥%0.2f",[IS_NULL(infoDic[@"product_price"][@"list_price"]) floatValue]];
    [self.oldPriceLabel addLineMidColor:[UIColor grayColor] withStr:self.oldPriceLabel.text];
}

@end
