//
//  OrderListTableViewCell.m
//  E3
//
//  Created by 王亮 on 15/9/16.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "OrderListTableViewCell.h"

@interface OrderListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;
@end

@implementation OrderListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.nameLabel.text = IS_NULL(infoDic[@"itemDescription"]);
    CGFloat price = [infoDic[@"unitPrice"] floatValue];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%0.2f",price];
    self.numLabel.text = [NSString stringWithFormat:@"x%@",IS_NULL(infoDic[@"quantity"])];
    NSString *str = [NSString stringWithFormat:@"供货商：%@",infoDic[@"supplierProductId"]];
    [self.shopBtn setTitle:str forState:UIControlStateNormal];
}

- (IBAction)supplierBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        [self.delegate proctocolCell:self withInfo:self.infoDic];
    }
}

@end
