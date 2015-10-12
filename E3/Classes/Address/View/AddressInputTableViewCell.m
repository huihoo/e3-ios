//
//  AddressInputTableViewCell.m
//  E3
//
//  Created by 王亮 on 15/9/10.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "AddressInputTableViewCell.h"
#import "AreaView.h"

@interface AddressInputTableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *descTextField;
@property (nonatomic,strong)AreaView *areaView;
@end

@implementation AddressInputTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.nameLabel.text = infoDic[@"name"];
    self.descTextField.placeholder = infoDic[@"descDefault"];
    self.descTextField.delegate = self;
    NSDictionary *descDic = infoDic[@"desc"];
    
    NSArray *allName = infoDic[@"allName"];
    for (int i = 0; i < allName.count; i ++) {
        
        NSString *nameStr = allName[i];
        if ([nameStr isEqual:infoDic[@"name"]]) {
            switch (i) {
                case 0:
                {
                    if (descDic != nil) {
                        
                        self.descTextField.text = descDic[@"name"];
                    }
                }
                    break;
                case 1:
                {
                    self.descTextField.keyboardType = UIKeyboardTypeNumberPad;
                    if (descDic != nil) {
                        
                        self.descTextField.text = descDic[@"phone"];
                    }
                }
                    
                    break;
                case 2:
                {
                    if (self.areaView == nil) {
                        
                        self.areaView = [[AreaView alloc] initWithFrame:CGRectMake(0, 0, IOS_IPHONE_WINDOW_WIDE, 150)];
                    }
                    self.descTextField.inputView = self.areaView;
                }
                    break;
                case 3:
                {
                    if (descDic != nil) {
                        
                        self.descTextField.text = descDic[@"address"];
                    }
                }
                    break;
                default:
                    break;
            }
            
            break;
        }
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
    
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.infoDic];
        dic[@"desc"] = textField.text;
        [self.delegate proctocolCell:self withInfo:dic];
    }
}

@end
