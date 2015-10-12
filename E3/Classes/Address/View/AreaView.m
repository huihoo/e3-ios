//
//  AreaView.m
//  E3
//
//  Created by 王亮 on 15/9/10.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "AreaView.h"

@interface AreaView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)NSArray *proviceArray;
@property(nonatomic,strong)NSArray *cityArray;
@property(nonatomic,strong)NSArray *countyArray;
@property(nonatomic,strong)UIPickerView *pickerView;

@end

@implementation AreaView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        [self initUI];
        [self getProvice];
    }
    return self;
}

- (void)getProvice {
    __block NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"last_time"] = @"133232";
    [[AppData shareData] geoProviceWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            self.proviceArray = dic[@"geo"];
            [self.pickerView reloadComponent:0];
            
            NSMutableDictionary *cityDic = [NSMutableDictionary dictionary];
            cityDic[@"geoId"] = @"CN-51";
            [self getCity:cityDic];
        }
    }];
}

- (void)getCity:(NSDictionary *)dic {
    
    [[AppData shareData] geoCityWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            self.cityArray = dic[@"geo"];
            [self.pickerView reloadComponent:1];
            
            NSMutableDictionary *countyDic = [NSMutableDictionary dictionary];
            countyDic[@"geoId"] = @"CN-51-01";
            [self getCounty:countyDic];
        }
    }];
}

- (void)getCounty:(NSDictionary *)dic {
    
    [[AppData shareData] geoCountyWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            self.countyArray = dic[@"geo"];
            [self.pickerView reloadComponent:2];
        }
        
    }];
}

- (void)initUI {
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self addSubview:pickerView];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.proviceArray.count;
    }else if(component == 1) {
        
        return self.cityArray.count;
    }else if (component == 2) {
        
        return self.countyArray.count;
    }
    return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    if (component == 0) {
        
        return self.proviceArray[row][@"geoName"];
    }else if(component == 1) {
        
        return self.cityArray[row][@"geoName"];
    }else if(component == 2) {
        
        return self.countyArray[row][@"geoName"];
    }
    return @"wang";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
}

@end
