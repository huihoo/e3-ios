//
//  LoginViewController.m
//  E3
//
//  Created by 王亮 on 15/8/29.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPassViewController.h"

@interface LoginViewController ()

@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *passTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self naviUI];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)naviUI {
    
    self.title = @"登录";
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
}

- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)initUI {
    
    self.view.backgroundColor = Color_Back_Gray;
    
    CGFloat centerX = CGRectGetWidth(self.view.frame) / 2;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 90, 90)];
    nameLabel.text = @"E3";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.center = CGPointMake(centerX, nameLabel.center.y);
    nameLabel.backgroundColor = Color_Blue;
    nameLabel.layer.cornerRadius = CGRectGetWidth(nameLabel.frame) / 2;
    nameLabel.clipsToBounds = YES;
    nameLabel.layer.borderColor = Color_Gray.CGColor;
    nameLabel.layer.borderWidth = 2;
    nameLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:nameLabel];
    
    NSArray *array = @[@{@"name":@"账号：",@"desc":@"请输入手机号或邮箱"},
                       @{@"name":@"密码：",@"desc":@"请输入密码"}
                       ];

    UIView *backView = nil;
    CGFloat wide = 0.9 * centerX * 2;
    CGFloat high = wide * 40.0f / 300.0f;
    for (int i = 0; i < array.count; i ++) {
    
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame) + 20 + (10 + high) * i, wide, high)];
        backView.center = CGPointMake(centerX, backView.center.y);
        backView.backgroundColor = Color_Gray;
        [self.view addSubview:backView];
        [self addBackView:backView withDic:array[i]];
    }
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backView.frame) + 20, wide, high * 0.8)];
    loginBtn.center = CGPointMake(centerX, loginBtn.center.y);
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = Color_Blue;
    loginBtn.layer.cornerRadius = 5;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(loginBtn.frame.origin.x, CGRectGetMaxY(loginBtn.frame) + 5, CGRectGetWidth(loginBtn.frame) / 3, CGRectGetHeight(loginBtn.frame))];
    [registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(loginBtn.frame.origin.x + CGRectGetWidth(loginBtn.frame) / 3 * 2, CGRectGetMaxY(loginBtn.frame) + 5, CGRectGetWidth(loginBtn.frame) / 3, CGRectGetHeight(loginBtn.frame))];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:Color_Blue forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(findPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
}

- (void)addBackView:(UIView *)backView withDic:(NSDictionary *)dic {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(backView.frame))];
    label.text = dic[@"name"];
    [backView addSubview:label];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, CGRectGetWidth(backView.frame) - CGRectGetMaxX(label.frame) - 10, CGRectGetHeight(backView.frame))];
    textField.placeholder = dic[@"desc"];
    [backView addSubview:textField];
    if ([dic[@"name"] isEqualToString:@"账号："]) {
        
        textField.text = @"13881111755";
        self.nameTextField = textField;
    }else {
        
        textField.secureTextEntry = YES;
        textField.text = @"123456";
        self.passTextField = textField;
    }
}


- (void)loginBtnAction:(UIButton *)sender {
    
    NSString *name = self.nameTextField.text;
    NSString *pass = self.passTextField.text;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"user_name"] = name;
    dic[@"pwd"] = pass;
    [[AppData shareData] userLoginWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            infoDic[@"is_login"] = [NSString stringWithFormat:@"%d",YES];
            [[User share] updateInfo:infoDic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginIn" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)registerBtnAction:(UIButton *)sender {

    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)findPassword:(UIButton *)sender {
    
    FindPassViewController *findVC = [[FindPassViewController alloc] init];
    [self.navigationController pushViewController:findVC animated:YES];
}


@end
