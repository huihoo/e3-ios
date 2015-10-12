//
//  SelectInfoCollectionViewCell.h
//  E3
//
//  Created by 王亮 on 15/8/20.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellForSuperProtocol.h"

@interface SelectInfoCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSDictionary *infoDic;
@property(nonatomic,assign)id<CellForSuperProtocol> delegate;

@end
