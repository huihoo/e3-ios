
//
//  SearchViewController.m
//  JingXingApp
//
//  Created by 王亮 on 15/9/10.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchModel.h"
#import "SearchTableViewCell.h"
//#import "ShoppingMallCell.h"
#import "MJRefresh.h"

#import "ProductListViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSInteger _page;
    NSString *_name;
}
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UITableView *historyTableView;
@property(nonatomic,strong)UITableView *productTableView;
@property(nonatomic,strong)NSMutableArray *productArray;

@end

@implementation SearchViewController

- (NSMutableArray *)productArray {
    
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _page = 1;
    [self initUI];
    [self naviUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData {
    
    _page = 1;
    [self.productArray removeAllObjects];
    [self obationData:_name];
}

- (void)addMoreData {
    
    _page ++;
    [self obationData:_name];
}

- (void)obationData:(NSString *)name {
    
}

- (void)initUI {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 1;
    self.historyTableView = tableView;
    [self.view addSubview:tableView];
    
    UITableView *pTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    pTableView.delegate = self;
    pTableView.dataSource = self;
    pTableView.tag = 2;
    pTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    pTableView.backgroundColor = Color_Back_Gray;
    [self.view addSubview:pTableView];
    [pTableView addHeaderWithTarget:self action:@selector(refreshData)];
    [pTableView addFooterWithTarget:self action:@selector(addMoreData)];
    self.productTableView = pTableView;
    
    [self.view bringSubviewToFront:tableView];
    
    ProductListViewController *listVC = [[ProductListViewController alloc] init];
    listVC.infoDic = @{@"category_name":@"sfs"};
    self.productTableView = (UITableView *)listVC.view;
}

- (void)naviUI {
    
    self.leftBtn.hidden = YES;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, IOS_IPHONE_WINDOW_WIDE, 44)];
    backView.backgroundColor = Color_Blue;
    [self.navigationController.view addSubview:backView];
    self.backView = backView;
    
    CGFloat wide = CGRectGetWidth(backView.frame) * 0.8;
    CGFloat high = CGRectGetHeight(backView.frame) * 0.8;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, wide , high)];
    textField.center = CGPointMake(textField.center.x, CGRectGetHeight(backView.frame) / 2 );
    textField.backgroundColor = [UIColor whiteColor];
    [backView addSubview:textField];
    textField.keyboardType = UIKeyboardTypeWebSearch;
    textField.delegate = self;
    self.textField = textField;
    [textField becomeFirstResponder];
    
    UIImage *searchImg = [UIImage imageNamed:@"搜索_03"];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, searchImg.size.width + 10, searchImg.size.height + 10)];
    UIImageView *searchImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, searchImg.size.width, searchImg.size.height)];
    searchImgV.image = searchImg;
    [leftView addSubview:searchImgV];
    
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.placeholder = @"搜索产品";
    textField.layer.cornerRadius = 2;
    
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame),0 , IOS_IPHONE_WINDOW_WIDE - wide, high)];
    cancelBtn.center = CGPointMake(cancelBtn.center.x, CGRectGetHeight(backView.frame) / 2);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 1) {
     
        return [SearchModel share].searchList.count;
    }else {
        
        return self.productArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cell";
    if (tableView.tag == 1) {
        
        cellID = @"SearchTableViewCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        if (tableView.tag == 1) {
            
            cell = WL_XIB(@"SearchTableViewCell");
        }else {
            
            cell = WL_XIB(@"ShoppingMallCell");
        }
    }
    
    if (tableView.tag == 1) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"name"] = [SearchModel share].searchList[indexPath.row];
        SearchTableViewCell *theCell = (SearchTableViewCell *)cell;
        theCell.infoDic = dic;
    }else {
        
//        ShoppingMallCell *theCell = (ShoppingMallCell *)cell;
//        theCell.infoDic = self.productArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 1) {
        return 50;
    }else {
        
        return 117;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.textField.text = [SearchModel share].searchList[indexPath.row];
}

- (void)cancelBtnAction:(UIButton *)sender {
    
    [self.backView removeFromSuperview];
    self.backView = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (temp.length > 0) {
        
        [[SearchModel share] addObjToSearchList:temp];
        
        [self.productArray removeAllObjects];
        
        [UIView transitionFromView:self.historyTableView toView:self.productTableView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom completion:^(BOOL finished) {
            
            _name = temp;
            [self obationData:temp];
            
        }];
    }else {
        
        [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"请输入搜索内容！"];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView transitionFromView:self.productTableView toView:self.historyTableView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom completion:^(BOOL finished) {
        
        [self.historyTableView reloadData];
    }];
}




@end
