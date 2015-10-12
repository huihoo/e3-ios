//
//  MineCollectionViewCell.m
//  E3
//
//  Created by colin liao on 7/30/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "MineCollectionViewCell.h"
#include "MineItem.h"

@interface MineCollectionViewCell ()

@property(nonatomic,weak)IBOutlet UIImageView* imageView;
@property(nonatomic,weak)IBOutlet UILabel* typeLabel;
@property(nonatomic,weak)IBOutlet UIView* lineView;
@end

@implementation MineCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)initWithMineItem:(MineItem *)mineItem withLine:(BOOL)line
{
    self.imageView.image = [UIImage imageNamed:mineItem.imageName];
    self.typeLabel.text = mineItem.itemTypeName;
    
    self.lineView.hidden = line;
}

@end
