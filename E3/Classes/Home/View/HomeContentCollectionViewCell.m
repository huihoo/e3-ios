//
//  HomeContentCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/7/28.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "HomeContentCollectionViewCell.h"
#import "UILabel+WLCategory.h"

@interface HomeContentCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftPirceLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HomeContentCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.saveBtn.layer.cornerRadius = 1;
    self.saveBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.saveBtn.layer.borderWidth = 0.5;
    self.buyBtn.layer.cornerRadius = 1;
    self.buyBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.buyBtn.layer.borderWidth = 0.5;
    [self.rightPriceLabel addLineMidColor:[UIColor grayColor] withStr:self.rightPriceLabel.text];
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",Base_Url,infoDic[@"large_image_url"]];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:infoDic[@"image"]];
    
    CGFloat rightPrice = [infoDic[@"product_price"][@"list_price"] floatValue];
    CGFloat leftPrice = [infoDic[@"product_price"][@"default_price"] floatValue];
    self.rightPriceLabel.text = [NSString stringWithFormat:@"¥%0.2f",rightPrice];
    self.leftPirceLabel.text = [NSString stringWithFormat:@"¥%0.2f",leftPrice];
    [self.rightPriceLabel addLineMidColor:[UIColor blackColor] withStr:self.rightPriceLabel.text];
    self.nameLabel.text = IS_NULL(infoDic[@"product_name"]);

}

- (IBAction)addCollect:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        [self.delegate proctocolCell:self withInfo:self.infoDic];
    }
}


@end
