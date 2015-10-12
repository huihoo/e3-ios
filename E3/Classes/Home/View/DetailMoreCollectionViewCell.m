//
//  DetailCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/19.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "DetailMoreCollectionViewCell.h"

@interface DetailMoreCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DetailMoreCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = [Color_Blue colorWithAlphaComponent:0.8];
    self.label.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
}

@end
