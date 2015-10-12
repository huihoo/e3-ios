//
//  HomeTopCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/7/28.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "HomeTopCollectionViewCell.h"


@interface HomeTopCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HomeTopCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = [Color_Blue colorWithAlphaComponent:0.1];
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.ImageVIew.image = [UIImage imageNamed:infoDic[@"image"]];
    self.nameLabel.text = infoDic[@"name"];
}

@end
