//
//  SelectInfoCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/20.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "SelectInfoCollectionViewCell.h"

@interface SelectInfoCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (nonatomic,strong) NSMutableDictionary *selectDic;

@end

@implementation SelectInfoCollectionViewCell

- (NSMutableDictionary *)selectDic {
    
    if (!_selectDic) {
        
        _selectDic = [NSMutableDictionary dictionary];
    }
    return _selectDic;
}

- (void)awakeFromNib {
    // Initialization code
    [self UI];
}

- (void)UI {
    
    self.backgroundColor = [UIColor clearColor];
    self.nameLabel.textColor = Color_Blue;
    self.picImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.picImageView.layer.borderWidth = 2;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectSize:) name:@"selectSize" object:nil];
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.nameLabel.text = [NSString stringWithFormat:@"¥%0.2f",[infoDic[@"product_price"][@"defaultPrice"] floatValue]];
    self.storeLabel.text = @"库存10件";
    self.selectLabel.text = @"已选：“其他／other” “算法”";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Base_Url,infoDic[@"detail_image_url"]];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}

- (IBAction)exitBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"status"] = @"exit";
        [self.delegate proctocolCell:self withInfo:dic];
    }
}

- (void)selectSize:(NSNotification *)notice {
    
    NSDictionary *dic = notice.userInfo;
    self.selectDic[dic[@"key"]] = dic;
    
    NSMutableString *selectStr =[NSMutableString stringWithString:@"已选:"];
    for (NSString *key in self.selectDic.allKeys) {
        
        [selectStr appendFormat:@"“%@” ",self.selectDic[key][@"description"]];
    }
    self.selectLabel.text = selectStr;
    
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:self.selectDic];
        dic1[@"status"] = @"select";
        [self.delegate proctocolCell:self withInfo:dic1];
    }
}

@end
