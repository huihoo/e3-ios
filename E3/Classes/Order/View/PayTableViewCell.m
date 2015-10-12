//
//  PayTableViewCell.m
//  E3
//
//  Created by 王亮 on 15/9/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "PayTableViewCell.h"

@interface PayTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation PayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.payLabel.text = infoDic[@"name"];
    BOOL select = [infoDic[@"select"] boolValue];
    self.selectBtn.selected = select;
}

@end
