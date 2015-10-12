//
//  AddressInputTableViewCell.h
//  E3
//
//  Created by 王亮 on 15/9/10.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellForSuperProtocol.h"

@interface AddressInputTableViewCell : UITableViewCell

@property(nonatomic,strong)NSDictionary *infoDic;
@property(nonatomic,assign)id<CellForSuperProtocol> delegate;

@end
