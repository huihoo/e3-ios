//
//  OrderListTableViewCell.h
//  E3
//
//  Created by 王亮 on 15/9/16.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellForSuperProtocol.h"

@interface OrderListTableViewCell : UITableViewCell

@property(nonatomic,assign)id<CellForSuperProtocol> delegate;

@property(nonatomic,strong)NSDictionary *infoDic;

@end
