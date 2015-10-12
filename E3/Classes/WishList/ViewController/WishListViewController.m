//
//  WishListViewController.m
//  E3
//
//  Created by colin liao on 7/27/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "WishListViewController.h"
#import "WishListTableViewCell.h"
#import "NSString+Addition.h"
#import "MJRefresh.h"
#import "GoodsDetailViewController.h"

@interface WishListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger page;
}
@property(nonatomic,strong)NSMutableArray *wishList;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *noLoginBackView;

@end

@implementation WishListViewController

- (NSMutableArray *)wishList {
    
    if (!_wishList) {
        
        _wishList = [NSMutableArray array];
    }
    return _wishList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    page = 1;
    dic[@"page"] = [NSString stringWithFormat:@"%ld",page];
    dic[@"page_size"] = @"10";
    [self obationData:dic];
    
    [self noLogin];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if ([User share].isLogin) {
        self.noLoginBackView.hidden = YES;
    }else {
        self.noLoginBackView.hidden = NO;
    }
}

- (void)noLogin {
    
    CGFloat wide = 0.8 * IOS_IPHONE_WINDOW_WIDE;
    CGFloat high = wide;
    UIView *loginBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wide, high)];
    loginBackView.center = CGPointMake(IOS_IPHONE_WINDOW_WIDE / 2, (IOS_IPHONE_WINDOW_HIGH - 64 - 49)/ 2);
    loginBackView.backgroundColor = [UIColor clearColor];
    self.noLoginBackView = loginBackView;
    [self.view addSubview:loginBackView];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(loginBackView.frame), 30)];
    descLabel.text = @"您还没有登录哦！";
    descLabel.textAlignment = NSTextAlignmentCenter;
    [loginBackView addSubview:descLabel];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(descLabel.frame) + 10, 100, 30)];
    loginBtn.backgroundColor = Color_Blue;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.center = CGPointMake(CGRectGetWidth(loginBackView.frame) / 2, loginBtn.center.y);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginBackView addSubview:loginBtn];
    
}

- (void)toLogin {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNavi animated:YES completion:nil];
}

- (void)obationData:(NSDictionary *)dic {
    
    [[AppData shareData] userCollectListWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            if (page == 1) {
                [self.wishList removeAllObjects];
                [self.tableView headerEndRefreshing];
            }else {
                [self.tableView footerEndRefreshing];
            }
            [self.wishList addObjectsFromArray:dic[@"list"]];
            [self.tableView reloadData];
        }else {
            
            [self.wishList removeAllObjects];
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    
    self.title = @"心愿单";
    CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
    frame.size.height -= 64;
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    [tableView addHeaderWithTarget:self action:@selector(refreshData)];
    [tableView addFooterWithTarget:self action:@selector(addMoreData)];
    self.tableView = tableView;
    
}

- (void)refreshData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    page = 1;
    dic[@"page"] = [NSString stringWithFormat:@"%ld",page];
    dic[@"page_size"] = @"10";
    [self obationData:dic];
}

- (void)addMoreData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    page ++;
    dic[@"page"] = [NSString stringWithFormat:@"%ld",page];
    dic[@"page_size"] = @"10";
    [self obationData:dic];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wishList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *nameStr = self.wishList[indexPath.row][@"product_name"];
    CGSize size = [nameStr sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(IOS_IPHONE_WINDOW_WIDE - 16 - 8 - 70, CGFLOAT_MAX)];
    NSInteger num = size.height / 30;
    CGFloat high = 100 + num * 15 ;
    return high;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"WishListTableViewCell";
    WishListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = WL_XIB(@"WishListTableViewCell");
    }
    cell.infoDic = self.wishList[indexPath.row];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.wishList[indexPath.row];
    [self deleteCollectDic:dic];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.wishList[indexPath.row];
    GoodsDetailViewController *goodsDetailVC = [[GoodsDetailViewController alloc] init];
    goodsDetailVC.productId = dic[@"product_id"];
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
}

- (void)deleteCollectDic:(NSDictionary *)dic {
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[@"product_id"] = dic[@"product_id"];
    [[AppData shareData] userDeleteCollectWithInfo:dic1 withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"删除成功"];
        }
    }];
    
}

@end
