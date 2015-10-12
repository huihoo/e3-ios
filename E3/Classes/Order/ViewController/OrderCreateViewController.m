//
//  OrderCreateViewController.m
//  E3
//
//  Created by 王亮 on 15/9/11.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "OrderCreateViewController.h"
#import "OrderProductTableViewCell.h"
#import "NSString+Addition.h"
#import "AddressTableViewCell.h"
#import "OrderSelectAddressViewController.h"
#import "OrderHeadView.h"
#import "PayTableViewCell.h"
#import "UILabel+WLCategory.h"
#import "OrderViewController.h"

@interface OrderCreateViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *addressList;
@property(nonatomic,strong)NSDictionary *defaultAddressDic;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *supplierDics;
@property(nonatomic,strong)NSMutableArray *payList;

@end

@implementation OrderCreateViewController

- (NSMutableArray *)supplierDics {
    
    if (!_supplierDics) {
        
        _supplierDics = [NSMutableArray array];
    }
    return _supplierDics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self obationAddress];
    [self obationSuppiler];
    [self prepareData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)obationSuppiler {
    
    for (NSDictionary *productDic in self.productDics) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"product_id"] = productDic[@"product_V_id"];
        [[AppData shareData] productSuppliersWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
            
            if ([dic[@"code"] intValue] == 0) {
                
                [self.supplierDics addObject:dic];
                NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
                [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }
}

- (void)obationAddress {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"account"] = [User share].website_name;
    [[AppData shareData] userAddressListWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            self.addressList = dic[@"listpostaddress"];
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)prepareData {
    
    self.payList = [NSMutableArray array];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[@"name"] = @"支付宝";
    dic1[@"select"] = @(YES);
    [self.payList addObject:dic1];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    dic2[@"name"] = @"微信支付";
    dic2[@"select"] = @(NO);
    [self.payList addObject:dic2];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    dic3[@"name"] = @"余额支付";
    dic3[@"select"] = @(NO);
    [self.payList addObject:dic3];
    
}

- (void)initUI {
    
    self.title = @"确认订单";
    CGRect frame = self.view.bounds;
    frame.size.height -= 49 + 64;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableView.frame), CGRectGetWidth(self.view.frame), 49)];
    footView.backgroundColor = Color_Gray;
    [self.view addSubview:footView];
    [self addFootView:footView];
}

- (void)addFootView:(UIView *)view {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 200, CGRectGetHeight(view.frame))];
    
    CGFloat price = 0.0;
    CGFloat num = 0;
    for (NSDictionary *productDic in self.productDics) {
        
        CGFloat price1 = [productDic[@"default_price"] floatValue];
        NSInteger num1 = [productDic[@"select_num"] integerValue];
        CGFloat allPrice = price1 * num1;
        price += allPrice;
        num += num1;
    }
    
    NSString *allPriceStr = [NSString stringWithFormat:@"¥%0.2f",price];
    label.text = [NSString stringWithFormat:@"总计:%@",allPriceStr];
    [view addSubview:label];
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"text"] = allPriceStr;
    dic[@"font"] = [UIFont systemFontOfSize:20];
    dic[@"color"] = [UIColor redColor];
    [array addObject:dic];
    [label addMoreStates:array];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, CGRectGetHeight(view.frame))];
    btn.center = CGPointMake(CGRectGetWidth(view.frame) - CGRectGetWidth(btn.frame) / 2, btn.center.y);
    [view addSubview:btn];
    [btn setTitle:@"确认下单" forState:UIControlStateNormal];
    btn.backgroundColor = Color_Blue;
    [btn addTarget:self action:@selector(createOrder) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 2) {
        return self.payList.count;
    }else if (section == 1) {
        
        return self.productDics.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cell";
    if (indexPath.section == 1) {
        
        cellID = @"OrderProductTableViewCell";
    }else if (indexPath.section == 0) {
        
        cellID = @"AddressTableViewCell";
    }else if (indexPath.section == 3) {
        
        cellID = @"PayTableViewCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        if (indexPath.section == 1) {
            
            cell = WL_XIB(@"OrderProductTableViewCell");
        }else if (indexPath.section == 0) {
            
            cell = WL_XIB(@"AddressTableViewCell");
        }else if (indexPath.section == 2) {
            
            cell = WL_XIB(@"PayTableViewCell");
        }
        else {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    }
    if (indexPath.section == 1) {
        
        OrderProductTableViewCell *theCell = (OrderProductTableViewCell *)cell;
        theCell.infoDic = self.productDics[indexPath.row];
        if (self.supplierDics.count == self.productDics.count) {
            
            theCell.suppilerDic = self.supplierDics[indexPath.row];
        }

    }else if(indexPath.section == 0){
        
        AddressTableViewCell *theCell = (AddressTableViewCell *)cell;
        if (self.addressList.count > 0) {
            
            for (NSDictionary *dic in self.addressList) {
                
                if ([IS_NULL(dic[@"state"]) isEqual:@"Y"]) {
                    
                    theCell.infoDic = dic;
                    self.defaultAddressDic = dic;
                    break;
                }
            }
        }
    }else if (indexPath.section == 2) {
        
        PayTableViewCell *theCell = (PayTableViewCell *)cell;
        theCell.infoDic = self.payList[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        NSString *strName = IS_NULL(self.productDics[indexPath.row][@"product_name"]);
        CGSize size = [strName sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
        return size.height + 60;
    }else if(indexPath.section == 0) {
        
        return 80;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        OrderSelectAddressViewController *selectVC = [[OrderSelectAddressViewController alloc] init];
        selectVC.addressList = self.addressList;
        [self.navigationController pushViewController:selectVC animated:YES];
    }else if(indexPath.section == 2){
        
        [self selectPay:(int)indexPath.row];
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:2];
        [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    OrderHeadView *headView = [[OrderHeadView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 40)];
    headView.descStr = @"选择支付方式";
    return headView;
}

- (void)createOrder {
 
    
    NSMutableString *productIds = [NSMutableString string];
    for (NSDictionary *productDic in self.productDics) {
        if (![productIds isEqual:@""]) {
            
            [productIds appendString:@","];
        }
        [productIds appendString:productDic[@"product_id"]];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"product_ids"] = productIds;
    dic[@"web_site_id"] = [User share].website_id;
    dic[@"confirm_type"] = @"1";
    dic[@"quantity"] = @"1";
    
    __block NSString *addressId = self.defaultAddressDic[@"contactMechIdStr"];
    
    [[AppData shareData] orderConfirmWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
    
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        dic1[@"contact_mech_id"] = addressId;
        dic1[@"shipment_method_type_ids"] = @"EXPRESS";
        dic1[@"payment_method_ids"] = @"EXT_ALIPAY";
        
        NSMutableString *supStr = [NSMutableString string];
        for (NSDictionary *supplierDic in self.supplierDics) {
            
            if (![supStr isEqual:@""]) {
    
                [supStr appendString:@","];
            }
            
            NSArray *array = [supStr componentsSeparatedByString:@","];
            BOOL isHas = [array containsObject:supplierDic[@"party_id"]];
            if (isHas == NO) {
                
                [supStr appendString:supplierDic[@"party_id"]];
            }
        }
        dic1[@"supplier_ids"] = supStr;
        [[AppData shareData] orderCreateWithInfo:dic1 withFinishBlock:^(NSDictionary *dic) {
            
            NSLog(@"%@",dic);
            [self.navigationController popToRootViewControllerAnimated:YES];
            UITabBarController *tabbar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            [tabbar setSelectedIndex:4];
            UINavigationController *navic = tabbar.viewControllers[4];
            [navic pushViewController:[[OrderViewController alloc] init] animated:YES];
        }];
    }];
}


- (void)selectPay:(int)row {
    
    for (int i = 0; i < self.payList.count; i ++) {
        
        NSMutableDictionary *dic = self.payList[i];
        if (i == row) {
            
            dic[@"select"] = @(YES);
        }else {
            dic[@"select"] = @(NO);
        }
    }
}

@end
