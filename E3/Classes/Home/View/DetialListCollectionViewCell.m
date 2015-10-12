//
//  DetialListCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/7/29.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "DetialListCollectionViewCell.h"
#import "DetailListTableViewCell.h"

@interface DetialListCollectionViewCell ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetialListCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self UI];
    
}

- (void)UI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"DetailListTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = WL_XIB(@"DetailListTableViewCell");
    }
    return cell;
}

@end
