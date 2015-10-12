//
//  RegisterViewController.m
//  E3
//
//  Created by 王亮 on 15/8/30.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *passTextField;
@property(nonatomic,strong)UITextField *againTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initUI {
    
    self.title = @"注册";
    self.view.backgroundColor = Color_Back_Gray;
    
    CGFloat centerX = CGRectGetWidth(self.view.frame) / 2;
    NSArray *array = @[
  @{@"name":@"账号：",@"desc":@"请输入手机号或邮箱"},
  @{@"name":@"密码：",@"desc":@"请输入密码"},
  @{@"name":@"确认密码：",@"desc":@"请再次输入密码"}
                       ];
    
    UIView *backView = nil;
    CGFloat wide = 0.9 * centerX * 2;
    CGFloat high = wide * 40.0f / 300.0f;
    for (int i = 0; i < array.count; i ++) {
        
        backView = [[UIView alloc] initWithFrame:CGRectMake(0,20 + (10 + high) * i, wide, high)];
        backView.center = CGPointMake(centerX, backView.center.y);
        backView.backgroundColor = Color_Gray;
        backView.tag = i;
        [self.view addSubview:backView];
        [self addBackView:backView withDic:array[i]];
    }
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backView.frame) + 20, wide, high * 0.8)];
    loginBtn.center = CGPointMake(centerX, loginBtn.center.y);
    [loginBtn setTitle:@"注 册" forState:UIControlStateNormal];
    loginBtn.backgroundColor = Color_Blue;
    loginBtn.layer.cornerRadius = 5;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBackView:(UIView *)backView withDic:(NSDictionary *)dic {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, CGRectGetHeight(backView.frame))];
    label.text = dic[@"name"];
    [backView addSubview:label];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, CGRectGetWidth(backView.frame) - CGRectGetMaxX(label.frame) - 10, CGRectGetHeight(backView.frame))];
    textField.placeholder = dic[@"desc"];
    [backView addSubview:textField];
    if (backView.tag == 0) {
        
        self.nameTextField = textField;
    }else if (backView.tag == 1){
        
        self.passTextField = textField;
        textField.secureTextEntry = YES;
    }else {
        
        self.againTextField = textField;
        textField.secureTextEntry = YES;
    }
}


- (void)registerBtnAction:(UIButton *)sender {
    
    if (![self.passTextField.text isEqualToString:self.againTextField.text]) {
        
        [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"两次密码不一致"];
    }else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"account"] = self.nameTextField.text;
        dic[@"pwd"] = self.passTextField.text;
        dic[@"website_id"] = @"www";//注册时为固定的www；
        [[AppData shareData] userRegisterWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
            
            if ([dic[@"code"] intValue] == 0) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

@end
