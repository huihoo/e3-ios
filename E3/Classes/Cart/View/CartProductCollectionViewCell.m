//
//  CartProductCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/31.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "CartProductCollectionViewCell.h"
#import "CartProductModel.h"

@interface CartProductCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIView *numBackView;
@property (weak, nonatomic) IBOutlet UIView *phoneBackView;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation CartProductCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = WLColor(230, 243, 241);
    self.numBackView.backgroundColor = WLColor(230, 243, 241);
    self.numBackView.layer.borderColor = [UIColor grayColor].CGColor;
    self.numBackView.layer.borderWidth = 0.5;
    self.numBackView.layer.cornerRadius = 3;
    self.phoneBackView.backgroundColor = WLColor(230, 243, 241);
    self.phoneBackView.layer.borderColor = WLColor(50, 200, 152).CGColor;
    self.phoneBackView.layer.borderWidth = 1;
    self.priceLabel.textColor = Color_Blue;
    self.allPriceLabel.textColor = Color_Blue;

}


- (void)setProductModel:(CartProductModel *)productModel {

    _productModel = productModel;
    NSDictionary *infoDic = productModel.productDic;
    self.selectBtn.selected = productModel.isSelect;
    
    self.nameLabel.text = [infoDic[@"product_name"] isKindOfClass:[NSNull class]] ? @"" : infoDic[@"product_name"];
    NSMutableString *descStr = [NSMutableString string];
    if (![IS_NULL(infoDic[@"features"]) isEqual:@""]) {
        
        for (NSDictionary *dic in infoDic[@"features"]) {
            NSString *name = dic[@"product_feature_type_id"];
            NSString *desc = dic[@"description"];
            if (![descStr isEqual:@""]) {
                
                [descStr appendString:@","];
            }
            [descStr appendString:[NSString stringWithFormat:@"%@:%@",name,desc]];
        }
    }
    
    self.descLabel.text = descStr;
    
    NSString *picStr = [NSString stringWithFormat:@"%@%@",Base_Url,infoDic[@"product_small_image_url"]];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picStr]];
    
    CGFloat price = [infoDic[@"default_price"] floatValue];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%0.2f",price];
    NSInteger num = [infoDic[@"quality"] integerValue];
    self.numLabel.text = [NSString stringWithFormat:@"%ld",num];
    
    self.allPriceLabel.text = [NSString stringWithFormat:@"小计:%0.2f",num * price]
    ;
}

- (IBAction)minus:(id)sender {
    
    NSInteger num = [self.numLabel.text integerValue];
    num --;
    if (num <= 1) {
        num = 1;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",num];
}

- (IBAction)add:(id)sender {
    
    NSInteger num = [self.numLabel.text integerValue];
    num ++;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",num];
}


- (IBAction)select:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    self.productModel.isSelect = btn.selected;
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        [self.delegate proctocolCell:self withInfo:@{@"model":self.productModel}];
    }
}

@end
