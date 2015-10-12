//
//  AlertTableView.h
//  transform
//
//  Created by sheldon on 15/1/17.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AlertTableViewDelegate  <NSObject>
@required
- (void)AlertTableViewSubmitResult:(NSArray *)array;
@optional
- (CGFloat)AlertTableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (CGFloat)AlertTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (NSInteger)AlertTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInAlertTableView:(UITableView *)tableView;
- (UITableViewCell *)AlertTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)AlertTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)AlertTableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface AlertTableView : UIView
-(id)initWithTitle:(NSString *)title delegate:(id) delegate cancelButtonTitle:(NSString *)cancelTitle;
- (void)show;
@end
/*
- (CGFloat)AlertTableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

- (CGFloat)AlertTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (NSInteger)AlertTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInAlertTableView:(UITableView *)tableView;
- (UITableViewCell *)AlertTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)AlertTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)AlertTableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
*/