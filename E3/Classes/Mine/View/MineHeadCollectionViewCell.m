//
//  MineHeadCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/30.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "MineHeadCollectionViewCell.h"

@interface MineHeadCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property(nonatomic,weak)IBOutlet UILabel *nameLabel;


@end

@implementation MineHeadCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
//    self.picImageView.backgroundColor = [UIColor redColor];
    self.picImageView.layer.cornerRadius = CGRectGetWidth(self.picImageView.frame) / 2;
    self.picImageView.clipsToBounds = YES;
    self.picImageView.layer.borderColor = Color_Blue.CGColor;
    self.picImageView.layer.borderWidth = 0.5;

}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    NSString *picStr = [User share].website_logo;
    NSString *nameStr = [User share].website_name;
//    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"iconfont-yonghu"]];
    self.picImageView.image = [UIImage imageNamed:@"huihoo-logo"];
    self.nameLabel.text = (nameStr == nil) || ([nameStr isEqual:@""]) ? @"未登录" : nameStr;
}

@end
