//
//  AddressTableViewCell.m
//  E3
//
//  Created by 王亮 on 15/9/10.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "AddressTableViewCell.h"

@interface AddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.nameLabel.text = infoDic[@"addressname"];
    self.phoneLabel.text = infoDic[@"mobile"];
    NSMutableString *addstr = [NSMutableString string];
    [addstr appendString:infoDic[@"provinceName"]];
    [addstr appendString:infoDic[@"cityName"]];
    [addstr appendString:infoDic[@"countyName"]];
    [addstr appendString:infoDic[@"address"]];
    self.addressLabel.text = addstr;
}

@end
