//
//  ChangePasswordViewController.m
//  Mallike
//
//  Created by colin liao on 5/13/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property(nonatomic,weak)IBOutlet UIButton* applyButton;
@property(nonatomic,weak)IBOutlet UITextField* oldPasswordTextField;
@property(nonatomic,weak)IBOutlet UITextField* passwordNewTextField;
@property(nonatomic,weak)IBOutlet UITextField* confirmPasswordTextField;
@property(nonatomic)NSTimer* loadTimer;
@end

@implementation ChangePasswordViewController


-(void)buttonRetrunAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"修改密码";
    
    
//    UIButton* leftButton = [[AppViewManager sharedAppViewManager]createOneReturnButton];
//    [leftButton addTarget:self action:@selector(buttonRetrunAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.applyButton.layer.cornerRadius = 4;
    self.oldPasswordTextField.secureTextEntry = YES;
    self.passwordNewTextField.secureTextEntry = YES;
    self.confirmPasswordTextField.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonToApply:(id)sender
{
//    if (self.oldPasswordTextField.text.length>0 && self.passwordNewTextField.text.length>0 && self.confirmPasswordTextField.text.length>0) {
//        if (![self.passwordNewTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
//            [[AppViewManager sharedAppViewManager] createOneAlertView:@"New Password not same" rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//            return;
//        }
//        if (-1 == [[AppViewManager sharedAppViewManager] createOneLoadView:self.view withName:@"Upload" withComplete:NO]) {
//            return;
//        };
//        NSDictionary* changePwdDic = @{@"oldpwd":self.oldPasswordTextField.text,
//                                       @"newpwd":self.passwordNewTextField.text,
//                                       KSessionID:[SessionModel getSessionID]
//                                       };
//        [MineHttpRequest changePasswordWithParam:changePwdDic usingSucessBlock:^(BOOL isSucess, NSDictionary *resultDictionary)
//        {
//            [[AppViewManager sharedAppViewManager] removeLoadView];
//            NSDictionary* changedResultDic = [resultDictionary nullValueToEmpty];
//            if ([kSuccess isEqualToString:[changedResultDic objectForKey:KMessage]]) {
//                //通信成功
//                if (1 == [[changedResultDic objectForKey:@"code"] integerValue]) {
//                    //密码修改成功
//                    [AppManager sharedAppManager].isLogIn = NO;
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:User_Info];
//                    [[NSUserDefaults standardUserDefaults] setObject:self.passwordNewTextField.text forKey:User_Pwd];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                     self.loadTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(createLogInLoad) userInfo:nil repeats:NO];
//                    
//                }else if(-2 == [[changedResultDic objectForKey:@"code"] integerValue])
//                {
//                    [[AppViewManager sharedAppViewManager] createOneAlertView:@"Old Password is not right!" rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//                }else if(-1 == [[changedResultDic objectForKey:@"code"] integerValue])
//                {
//                    [[AppViewManager sharedAppViewManager] createOneAlertView:@"password not send,try again!" rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//                }
//            }else
//            {
//                //报告错误todo设置alertview的字符串
//                [[AppViewManager sharedAppViewManager] createOneAlertView:[changedResultDic objectForKey:KError] rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//            }
//        } andFailureBlock:^(NSError *resultError) {
//            [[AppViewManager sharedAppViewManager] removeShadeView:self.view];
//            //报告错误todo设置alertview的字符串
//            [[AppViewManager sharedAppViewManager] createOneAlertView:@"Change password Error" rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//        }];
//    }
}

-(void)logIn
{
//    NSDictionary* logInDic = @{@"account":[[NSUserDefaults standardUserDefaults] valueForKey: User_Email],
//                               @"password":[[NSUserDefaults standardUserDefaults] valueForKey: User_Pwd],
//                               @"sessionId":[SessionModel getSessionID]};
//    
//    [WLHttpRequest loginWithParam:logInDic usingSucessBlock:^(BOOL isSucess, NSDictionary *resultDictionary) {
//        
//        [[AppViewManager sharedAppViewManager] removeLoadView];
//        
//        NSDictionary* changedResultDic = [resultDictionary nullValueToEmpty];
//        if ([kSuccess isEqual:[changedResultDic objectForKey:KMessage]]) {
//            if (-1 == [[AppViewManager sharedAppViewManager] createOneLoadView:self.view withName:@"Complete" withComplete:YES]) {
//                return;
//            }
//            //登陆完成后数据保存
//            [[NSUserDefaults standardUserDefaults] setObject:changedResultDic forKey:User_Info];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            [AppManager sharedAppManager].isLogIn = true;
//            self.loadTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(createCompleted) userInfo:nil repeats:NO];
//        }else
//        {
//            [[AppViewManager sharedAppViewManager] createOneAlertView:@"LogIn failure" rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//        }
//        
//        
//    } andFailureBlock:^(NSError *resultError) {
//        [[AppViewManager sharedAppViewManager] removeLoadView];
//        //报告错误todo设置alertview的字符串
//        [[AppViewManager sharedAppViewManager] createOneAlertView:@"LogIn Error" rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//    }];
}

-(void)createLogInLoad
{
//    if (-1 == [[AppViewManager sharedAppViewManager] createOneLoadView:self.view withName:@"Sign In" withComplete:NO]) {
//        return;
//    }
//    [self logIn];
//    [self.loadTimer invalidate];
}

-(void)createCompleted
{
//    [[AppViewManager sharedAppViewManager] removeLoadView];
//    [[AppViewManager sharedAppViewManager] createOneAlertView:@"Change password Sucessed" rightOrWrong:YES viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_PopRoot time:1.0f];
//    [self.loadTimer invalidate];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
