//
//  BaseViewController.m
//  E3
//
//  Created by 王亮 on 15/7/28.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+WLCategory.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBaseNaviUI];
    
//    self.edgesForExtendedLayout = UIRectEdgeAll;

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (self.navigationController.childViewControllers.count > 1) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else {
        
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseNaviUI {
    
    //左键
    UIImage *backImage = [UIImage imageNamed:@"iconfont-fanhui"];
    self.leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (self.navigationController.childViewControllers.count>1) {
        //返回
        [self.leftBtn setImage:backImage forState:UIControlStateNormal];
    } else{
        //第一个
    }
    [self.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    
    //右键
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [self.rightBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [self.rightBtn addObserver:self forKeyPath:@"titleLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    [self.leftBtn addObserver:self forKeyPath:@"titleLabel.text" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    UIButton * btn = (UIButton *)object;
    if (btn.imageView.image != nil) {
        return;
    }
    NSString * newBtnTitle = change[@"new"];
    
    NSDictionary *attrs = @{NSFontAttributeName : btn.titleLabel.font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, btn.frame.size.height);
    
    CGSize titlSize = [newBtnTitle boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, titlSize.width, titlSize.height);
    
}

- (void)clickRightButton{
    NSLog(@"%@--右侧按钮点击了",self.navigationItem.title);
}
- (void)back{
    NSLog(@"%@--左侧按钮点击了",self.navigationItem.title);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    
    [self.leftBtn removeObserver:self forKeyPath:@"titleLabel.text"];
    [self.rightBtn removeObserver:self forKeyPath:@"titleLabel.text"];
    
}

@end
