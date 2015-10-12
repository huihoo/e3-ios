//
//  MineHeaderCollectionReusableView.m
//  E3
//
//  Created by colin liao on 7/30/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "MineHeaderCollectionReusableView.h"

@interface MineHeaderCollectionReusableView ()

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property(nonatomic,weak)IBOutlet UILabel *nameLabel;

@end

@implementation MineHeaderCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
    
  
    self.picImageView.backgroundColor = [UIColor redColor];
    self.picImageView.layer.cornerRadius = CGRectGetWidth(self.picImageView.frame) / 2;
    self.picImageView.clipsToBounds = YES;

    
}

- (void)refreshView {
    
    NSString *picStr = [User share].website_logo;
    NSString *nameStr = [User share].website_name;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picStr]];
    self.nameLabel.text = nameStr;
    NSLog(@"%@",self.nameLabel);
}

@end
