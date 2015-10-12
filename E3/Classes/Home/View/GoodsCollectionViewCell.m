//
//  GoodsCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/19.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "GoodsCollectionViewCell.h"

@interface GoodsCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation GoodsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.nameLabel.text = @"你说放假啊放假啊事件发生飞机是否接受";
    self.priceLabel.font = [UIFont boldSystemFontOfSize:17];
    self.priceLabel.text = @"¥9.9";
    self.backgroundColor = [UIColor whiteColor];
}

@end
