//
//  WishListTableViewCell.m
//  E3
//
//  Created by 王亮 on 15/9/3.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "WishListTableViewCell.h"
#import "UILabel+WLCategory.h"

@interface WishListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end

@implementation WishListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.nameLabel.text = IS_NULL(infoDic[@"product_name"]);
    CGFloat priceF = [infoDic[@"default_price"] floatValue];
    CGFloat oldPriceF = [infoDic[@"list_price"] floatValue];
    self.priceLabel.text =[NSString stringWithFormat:@"¥%0.2f",priceF];
    self.oldPriceLabel.text = [NSString stringWithFormat:@"¥%0.2f",oldPriceF];
    self.priceLabel.textColor = Color_Blue;
    [self.oldPriceLabel addLineMidColor:[UIColor blackColor] withStr:self.oldPriceLabel.text];
    NSString *urlStr = infoDic[@"large_image_url"];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}

@end
