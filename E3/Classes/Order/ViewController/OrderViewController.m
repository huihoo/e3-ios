//
//  OrderViewController.m
//  E3
//
//  Created by 王亮 on 15/9/9.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderListTableViewCell.h"
#import "OrderHeadView.h"
#import "NSString+Addition.h"
#import "ProductListViewController.h"

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate,CellForSuperProtocol>

@property(nonatomic,strong)NSMutableArray *orderList;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation OrderViewController

- (NSMutableArray *)orderList {
    
    if (!_orderList) {
        
        _orderList = [NSMutableArray array];
    }
    return _orderList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"query_type"] = @"1";
    NSDate *startTime = [self dateFromString:@"2015-8-1"];
    NSDate *endTime = [self dateFromString:@"2015-9-30"];
    long startTimeIn = [startTime timeIntervalSince1970];
    long endTimeIn = [endTime timeIntervalSince1970];
    dic[@"end_time"] = [NSString stringWithFormat:@"%ld000",endTimeIn];
    dic[@"start_time"] = [NSString stringWithFormat:@"%ld000",startTimeIn];

    [[AppData shareData] orderDetailsWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            [self.orderList addObjectsFromArray:dic[@"order_item_list"]];
            [self.tableView reloadData];
        }
        
    }];
    
}

- (NSDate *)dateFromString:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *desDate = [dateFormatter dateFromString:dateString];
    return desDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    
    self.title = @"我的订单";
    
    CGRect frame = self.view.bounds;
    frame.size.height -= 20;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    tableView.backgroundColor = Color_Back_Gray;
    [self.view addSubview:tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.orderList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cell";
    if (indexPath.section < self.orderList.count) {
        
        cellID = @"OrderListTableViewCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        if (indexPath.section < self.orderList.count) {
            
            cell = WL_XIB(@"OrderListTableViewCell");
        }
        else {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    }
    if (indexPath.section < self.orderList.count) {
        
        OrderListTableViewCell *theCell = (OrderListTableViewCell *)cell;
        theCell.infoDic = self.orderList[indexPath.section];
        theCell.delegate = self;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *strName = IS_NULL(self.orderList[indexPath.section][@"itemDescription"]);
    CGSize size = [strName sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
    return size.height + 70 < 100 ? 100 : size.height + 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    OrderHeadView *headView = [[OrderHeadView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 50)];
    NSString *orderStr = [NSString stringWithFormat:@"订单号：%@",self.orderList[section][@"orderId"]];
    headView.descStr = orderStr;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 60)];
    CGFloat wide = 80;
    CGFloat high = 30;
    int num = 3;
    if (section % 3 == 0) {
        
        num = 1;
    }else if (section % 3 == 1) {
        
        num = 2;
    }
    for (int i = 0; i < num; i ++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, wide, high)];
        btn.center = CGPointMake(CGRectGetWidth(view.frame) - (wide / 2 + (wide + 10) * i)- 10, CGRectGetHeight(view.frame) / 2);
        NSString *str = [NSString stringWithFormat:@"操作%d",i+1];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = CGRectGetHeight(btn.frame) / 2;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.borderWidth = 0.5;
        [view addSubview:btn];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return view;
}

- (void)btnAction:(UIButton *)sender {
    
    NSString *str = [sender titleForState:UIControlStateNormal];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

- (void)proctocolCell:(id)obj withInfo:(NSDictionary *)dic {
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[@"category_name"] = dic[@"supplierProductId"];
    ProductListViewController *productLisctVC = [[ProductListViewController alloc] init];
    productLisctVC.infoDic = dic1;
    [self.navigationController pushViewController:productLisctVC animated:YES];
}

@end
