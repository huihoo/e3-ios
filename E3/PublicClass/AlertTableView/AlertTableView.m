//
//  AlertTableView.m
//  transform
//
//  Created by sheldon on 15/1/17.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "AlertTableView.h"
@interface AlertTableView()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomBtnBgView;
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * resultArray;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic, strong) IBOutlet UIView * bgView;
@property (nonatomic, assign) id<AlertTableViewDelegate> delegate;

@end
@implementation AlertTableView
-(id)initWithTitle:(NSString *)title delegate:(id) delegate cancelButtonTitle:(NSString *)cancelTitle{
    self = [[NSBundle mainBundle] loadNibNamed:@"AlertTableView" owner:nil options:nil].lastObject;
    if (self) {

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.topTitleLabel.text = title;
        self.delegate = delegate;
        
    }
    return self;
    
}
- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.clipsToBounds = YES;

        self.layer.cornerRadius = 30;
        
    }
    return self;
}
-(instancetype)init{

    if (self = [super init]) {
        
    }
    return self;
}

- (IBAction)confirm:(UIButton *)sender {
}

- (IBAction)cancle:(UIButton *)sender {
    [self dismiss];
}

-(void)awakeFromNib{
    
    self.clipsToBounds = YES;
    self.hidden = YES;
    self.layer.cornerRadius = 10;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [UIColor grayColor];
    self.bgView.alpha = 0.5;
    _resultArray = [NSMutableArray array];
}
/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/
- (void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];

//    [self.bgView addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.bounds = CGRectZero;
    [UIView animateWithDuration:0.2 animations:^{
        self.bounds = CGRectMake(0, 0, 220, 300);
    }];
    self.hidden = NO;
}
- (void)dismiss{
    
    [UIView animateWithDuration:0.2 animations:^{

        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self.delegate respondsToSelector:@selector(AlertTableView:heightForFooterInSection:)]) {
        return [self.delegate AlertTableView:tableView heightForFooterInSection:section];
    }

    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([self.delegate respondsToSelector:@selector(AlertTableView:heightForHeaderInSection:)]) {
        return [self.delegate AlertTableView:tableView heightForHeaderInSection:section];
    }

    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(AlertTableView:numberOfRowsInSection:)]) {
        return [self.delegate AlertTableView:tableView numberOfRowsInSection:section];
    }

    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.delegate respondsToSelector:@selector(numberOfSectionsInAlertTableView:)]) {
        return [self.delegate numberOfSectionsInAlertTableView:tableView];
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.delegate respondsToSelector:@selector(AlertTableView:cellForRowAtIndexPath:)]) {
        return [self.delegate AlertTableView:tableView cellForRowAtIndexPath:indexPath];
    }else{
    
    
    static NSString * ID = @"cell";
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"星期%ld",(long)indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(AlertTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate AlertTableView:tableView didSelectRowAtIndexPath:indexPath];
    }else{
      
        [tableView cellForRowAtIndexPath:indexPath].selected = YES;
    }
    [self.resultArray addObject:@(indexPath.row)];
    if (self.resultArray.count>0&&!self.submitBtn.enabled) {
        self.submitBtn.enabled = YES;
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(AlertTableView:didDeselectRowAtIndexPath:)]) {
        [self.delegate AlertTableView:tableView didDeselectRowAtIndexPath:indexPath];
    }else{
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
    }
    [self.resultArray removeObject:@(indexPath.row)];
    if (self.resultArray.count==0) {
        self.submitBtn.enabled = NO;
    }


}
- (IBAction)submitResult:(UIButton *)sender {
    [self.delegate AlertTableViewSubmitResult:self.resultArray];
    [self dismiss];
}
@end
