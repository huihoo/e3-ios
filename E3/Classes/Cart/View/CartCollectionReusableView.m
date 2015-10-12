//
//  CartCollectionReusableView.m
//  E3
//
//  Created by 王亮 on 15/8/31.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "CartCollectionReusableView.h"
#import "CartSupplierModel.h"

@interface CartCollectionReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *supplierName;

@end

@implementation CartCollectionReusableView


- (void)awakeFromNib {
    // Initialization code
}


- (IBAction)select:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    self.model.isSelect = btn.selected;
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        [self.delegate proctocolCell:self withInfo:@{@"type":@"0",@"state":@(btn.selected)}];
    }
}

- (void)setModel:(CartSupplierModel *)model {
    
    _model = model;
    self.selectBtn.selected = model.isSelect;
    self.supplierName.text = model.suppilerDic[@"supplier_name"];
   
}

- (IBAction)supplier:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        [self.delegate proctocolCell:self withInfo:@{@"type":@"1",@"info":self.model.suppilerDic}];
    }
}

@end
