//
//  ChangeEmailViewController.m
//  Mallike
//
//  Created by colin liao on 5/13/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "ChangeEmailViewController.h"

@interface ChangeEmailViewController ()
@property(weak,nonatomic)IBOutlet UIButton* applyButton;
@property(weak,nonatomic)IBOutlet UILabel* oldEmailLabel;
@property(nonatomic,weak)IBOutlet UITextField* emailNewTextField;
@property(nonatomic)NSTimer* loadTimer;
@end

@implementation ChangeEmailViewController


-(void)buttonRetrunAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.applyButton.layer.cornerRadius = 4;
    self.navigationItem.title = @"修改邮箱";
    
    
    
//    UIButton* leftButton = [[AppViewManager sharedAppViewManager]createOneReturnButton];
//    [leftButton addTarget:self action:@selector(buttonRetrunAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    // Do any additional setup after loading the view from its nib.

//    self.oldEmailLabel.text = [[AppManager sharedAppManager].customerInfo.infoDic objectForKey:@"userLoginId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonToApply:(id)sender
{
    
//    if (self.emailNewTextField.text.length > 0) {
//        if (-1 == [[AppViewManager sharedAppViewManager] createOneLoadView:self.view withName:@"Upload" withComplete:NO]) {
//            return;
//        };
//        NSDictionary* changeEmailDic = @{@"email":self.emailNewTextField.text,
//                                         KSessionID:[SessionModel getSessionID]
//                                         };
//        [MineHttpRequest changeEmailWithParam:changeEmailDic usingSucessBlock:^(BOOL isSucess, NSDictionary *resultDictionary)
//        {
//            [[AppViewManager sharedAppViewManager] removeShadeView:self.view];
//            
//            NSDictionary* changedResultDic = [resultDictionary nullValueToEmpty];
//            if ([kSuccess isEqualToString:[changedResultDic objectForKey:KMessage]]) {
//                //通信成功
//                if (1 == [[changedResultDic objectForKey:@"code"] integerValue]) {
//                    [[AppViewManager sharedAppViewManager] createOneLoadView:self.view withName:@"Email Send" withComplete:YES];
//                    self.loadTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(removeLoadView) userInfo:nil repeats:NO];
//                    
//                }else if(2 == [[changedResultDic objectForKey:@"code"] integerValue])
//                {
//                    [[AppViewManager sharedAppViewManager] createOneAlertView:@"Email Exist,try again!" rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//                }else if(-1 == [[changedResultDic objectForKey:@"code"] integerValue])
//                {
//                    [[AppViewManager sharedAppViewManager] createOneAlertView:@"Email not send,try again!" rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//                }
//            }else
//            {
//                //报告错误todo设置alertview的字符串
//                [[AppViewManager sharedAppViewManager] createOneAlertView:[changedResultDic objectForKey:KError] rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//            }
//        } andFailureBlock:^(NSError *resultError) {
//            [[AppViewManager sharedAppViewManager] removeShadeView:self.view];
//            //报告错误todo设置alertview的字符串
//            [[AppViewManager sharedAppViewManager] createOneAlertView:@"Change Email Error" rightOrWrong:NO viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_Default time:3.0f];
//        }];
//    }
}

-(void)removeLoadView
{
//    [[AppViewManager sharedAppViewManager] createOneAlertView:@"Change Email Sucessed" rightOrWrong:YES viewController:self targetViewController:nil viewControllerCutType:ViewControllerCutType_PopRoot time:1.0f];
//    [self.loadTimer invalidate];
//    [[AppViewManager sharedAppViewManager] removeLoadView];
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
