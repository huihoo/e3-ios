//
//  SelectNumCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/20.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "SelectNumCollectionViewCell.h"

@interface SelectNumCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIView *numBackView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation SelectNumCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = [UIColor whiteColor];
    self.numBackView.layer.cornerRadius = 5;
    self.numBackView.layer.borderColor = [UIColor grayColor].CGColor;
    self.numBackView.layer.borderWidth = 0.5;
}
- (IBAction)minusBtn:(id)sender {
    
    NSInteger currNum = [self.numLabel.text integerValue];
    currNum --;
    if (currNum <= 1) {
        
        currNum = 1;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",currNum];
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"num"] = @(currNum);
        [self.delegate proctocolCell:self withInfo:dic];
    }
}
- (IBAction)addBtn:(id)sender {
    
    NSInteger currNum = [self.numLabel.text integerValue];
    currNum ++;
    if (currNum >= 10) {
        
        currNum = 10;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",currNum];

    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"num"] = @(currNum);
        [self.delegate proctocolCell:self withInfo:dic];
    }
}

@end
