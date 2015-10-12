//
//  OrderProductTableViewCell.m
//  E3
//
//  Created by 王亮 on 15/9/11.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "OrderProductTableViewCell.h"

@interface OrderProductTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UIView *numBackView;

@end

@implementation OrderProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.numBackView.layer.borderColor = [UIColor grayColor].CGColor;
    self.numBackView.layer.borderWidth = 0.5;
    self.numBackView.layer.cornerRadius = 3;
    self.picImageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.picImageView.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    
    CGFloat price = [IS_NULL(infoDic[@"default_price"]) floatValue];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%0.2f",price];
    self.nameLabel.text = IS_NULL(infoDic[@"product_name"]);
    self.numLabel.text = [NSString stringWithFormat:@"x%@",infoDic[@"select_num"]];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Base_Url,infoDic[@"detail_image_url"]];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}

- (void)setSuppilerDic:(NSDictionary *)suppilerDic {
    
    _suppilerDic = suppilerDic;
    self.shopLabel.text = [NSString stringWithFormat:@"供货商：%@",suppilerDic[@"supplier_name"]];
}

@end
