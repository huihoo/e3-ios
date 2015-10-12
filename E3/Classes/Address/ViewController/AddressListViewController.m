//
//  AddressListViewController.m
//  E3
//
//  Created by 王亮 on 15/9/10.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressAddViewController.h"
#import "AddressTableViewCell.h"

@interface AddressListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *addressList;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self obationData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    
    self.title = @"我的地址";
    self.view.backgroundColor = Color_Back_Gray;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
}

- (void)obationData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"account"] = [User share].website_name;
    [[AppData shareData] userAddressListWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0 ) {
            
            self.addressList = dic[@"listpostaddress"];
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.addressList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cell";
    if (indexPath.row == 0) {
        
        cellID = @"AddressAddTableViewCell";
    }else {
        cellID = @"AddressTableViewCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        if (indexPath.row == 0) {
            
            cell = WL_XIB(@"AddressAddTableViewCell");
        }else {
            
            cell = WL_XIB(@"AddressTableViewCell");
        }
    }
    
    if (indexPath.row != 0) {
        
        AddressTableViewCell *theCell = (AddressTableViewCell *)cell;
        theCell.infoDic = self.addressList[indexPath.row - 1];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 50;
    }else {
        
        return 90;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        AddressAddViewController *addressAddVC = [[AddressAddViewController alloc] init];
        addressAddVC.title = @"新增地址";
        [self.navigationController pushViewController:addressAddVC animated:YES];
    }else {
        
        AddressAddViewController *addressAddVC = [[AddressAddViewController alloc] init];
        addressAddVC.infoDic = self.addressList[indexPath.row - 1];
        addressAddVC.title = @"修改地址";
        [self.navigationController pushViewController:addressAddVC animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.addressList[indexPath.row];
    [self deleteAddressDic:dic];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (void)deleteAddressDic:(NSDictionary *)infoDic {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    dic[@"methods"] = @"delete";
    dic[@"addressname"] = infoDic[@"addressname"];
    dic[@"contactMechIdStr"] = infoDic[@"contactMechIdStr"];
    dic[@"addressphone"] = infoDic[@"mobile"];
    dic[@"proviceId"] = infoDic[@"proviceId"];
    dic[@"cityId"] = infoDic[@"cityGeoId"];
    dic[@"countryId"] = infoDic[@"countyGeoId"];
    dic[@"address"] = infoDic[@"address"];
    [[AppData shareData] userAddressWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:dic[@"message"]];
        }
    }];
}


@end
