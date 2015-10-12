//
//  AddressAddViewController.m
//  E3
//
//  Created by 王亮 on 15/9/10.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "AddressAddViewController.h"
#import "AddressInputTableViewCell.h"

@interface AddressAddViewController ()<UITableViewDelegate,UITableViewDataSource,CellForSuperProtocol>

@property(nonatomic,strong)NSMutableArray *nameArray;
@property(nonatomic,strong)NSMutableArray *descDefaultArray;
@property(nonatomic,strong)NSMutableDictionary *addressDic;

@end

@implementation AddressAddViewController

- (NSMutableDictionary *)addressDic {
    
    if (!_addressDic) {
        _addressDic = [NSMutableDictionary dictionary];
    }
    return _addressDic;
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.addressDic[@"name"] = infoDic[@"addressname"];
    self.addressDic[@"phone"] = infoDic[@"mobile"];
    self.addressDic[@"address"] = infoDic[@"address"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareData];
    [self initUI];
    [self naviUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareData {
    
    self.nameArray = [NSMutableArray array];
    [self.nameArray addObject:@"姓名:"];
    [self.nameArray addObject:@"电话:"];
    [self.nameArray addObject:@"省市区:"];
    [self.nameArray addObject:@"详情地址:"];
    
    self.descDefaultArray = [NSMutableArray array];
    [self.descDefaultArray addObject:@"请输入收货人姓名"];
    [self.descDefaultArray addObject:@"请输入收货人电话"];
    [self.descDefaultArray addObject:@"请选择省市区"];
    [self.descDefaultArray addObject:@"请输入详情地址"];
}

- (void)initUI {
    
    self.view.backgroundColor = Color_Back_Gray;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
}

- (void)naviUI {
    
    [self.rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    
}

- (void)clickRightButton {
    
    [self.view endEditing:YES];
    // CN-51 CN-51-01  CN-51-01-01
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.infoDic == nil) {
        
        dic[@"methods"] = @"save";//save update delete select
    }else {
        dic[@"methods"] = @"update";
        dic[@"contactMechIdStr"] = self.infoDic[@"contactMechIdStr"];
    }
    dic[@"addressname"] = self.addressDic[@"name"];
    dic[@"addressphone"] = self.addressDic[@"phone"];
    dic[@"proviceId"] = @"CN-51";
    dic[@"cityId"] = @"CN-51-01";
    dic[@"countryId"] = @"CN-51-01-01";
    dic[@"address"] = self.addressDic[@"address"];
    [[AppData shareData] userAddressWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            if ([self.status isEqual:@"select"]) {
                
                NSInteger num = self.navigationController.viewControllers.count;
                UIViewController *secVC = self.navigationController.viewControllers[num - 3];
                [self.navigationController popToViewController:secVC animated:YES];
            }else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cell";
    if (indexPath.section == 0) {
        
        cellID = @"AddressInputTableViewCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        if (indexPath.section == 0) {
            
            cell = WL_XIB(@"AddressInputTableViewCell");
        }else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    }

    if (indexPath.section == 0) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"name"] = self.nameArray[indexPath.row];
        dic[@"descDefault"] = self.descDefaultArray[indexPath.row];
        dic[@"allName"] = self.nameArray;
        if (self.infoDic != nil) {
            
            dic[@"desc"] = self.addressDic;
        }
        AddressInputTableViewCell *thecCell = (AddressInputTableViewCell *)cell;
        thecCell.infoDic = dic;
        thecCell.delegate = self;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)proctocolCell:(id)obj withInfo:(NSDictionary *)dic {
    
    for (int i = 0; i < self.nameArray.count; i ++) {
        
        NSString *nameStr = self.nameArray[i];
        if ([nameStr isEqual:dic[@"name"]]) {
            switch (i) {
                case 0:
                    self.addressDic[@"name"] = dic[@"desc"];
                    break;
                case 1:
                    self.addressDic[@"phone"] = dic[@"desc"];
                    break;
                case 2:
                    self.addressDic[@"area"] = dic[@"desc"];
                    break;
                case 3:
                    self.addressDic[@"address"] = dic[@"desc"];
                    break;
                default:
                    break;
            }
            
            break;
        }
    }
}

@end
