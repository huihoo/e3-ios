//
//  MineCollectionViewCell.h
//  E3
//
//  Created by colin liao on 7/30/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  MineItem;

@interface MineCollectionViewCell : UICollectionViewCell


-(void)initWithMineItem:(MineItem*)mineItem withLine:(BOOL)line;

@end
