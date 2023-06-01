//
//  JMViewController.m
//  JMQuotesComponets
//
//  Created by liyunlong1512 on 05/29/2023.
//  Copyright (c) 2023 liyunlong1512. All rights reserved.
//

#import "JMViewController.h"
#import <JMQuotesComponets/QuotationConstant.h>
#import <JMQuotesComponets/JMQuotationListView.h>
#import <JMQuotesComponets/JMStockDetailsView.h>

@interface JMViewController ()<QuotationListDelegate, StockDetailsViewDelegate>

/** 自选列表 */
@property (nonatomic, strong) JMQuotationListView *quotationListView;

/** 个股详情view */
@property (nonatomic, strong) JMStockDetailsView *stockDetailsView;

/** <#注释#> */
@property(nonatomic, assign) BOOL isMore;

@end

@implementation JMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self CreateWatchlistUI];
    
//    [self CreateStockDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 图表数据

- (void)setStockDateWithIndex:(NSInteger)index {
    
    NSString * jsonName = @"fs";
    
    switch (index) {
        case 3:{
            jsonName = @"fs";
        }
            break;
        case 4:{
            jsonName = @"wr";
            break;
        }
        case 5:{
            jsonName = @"dayK";
        }
            break;
        case 6:{
            jsonName = @"weekK";
        }
            break;
        case 7:{
            jsonName = @"moonK";
        }
            break;
        case 8:{
            jsonName = @"yearK";
        }
            break;
        default:
            break;
    }
    
    // 获取 JSON 文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    // 读取 JSON 文件数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 将 JSON 数据转换为 Objective-C 对象
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    [self.stockDetailsView updateKLineDataWithJson:jsonObject ChartTyep:index Weights:@"F" More:NO];
}

- (void)getMoreData {
    
    // 获取 JSON 文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"more_dayK" ofType:@"json"];
    // 读取 JSON 文件数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 将 JSON 数据转换为 Objective-C 对象
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    [self.stockDetailsView updateKLineDataWithJson:jsonObject ChartTyep:5 Weights:@"F" More:YES];
}

#pragma mark - StockDetailsViewDelegate

- (void)GetMoreKLineDataWithTimestamp:(NSString *)timestamp {
    NSLog(@"%@",timestamp);
    if (!self.isMore) {
        self.isMore = YES;
        [self getMoreData];
    }
}

- (void)KLineWeightsSelectionWithType:(NSString *)type {
    
}

- (void)KLineTimeSelectionWithIndex:(NSInteger)index {
    [self setStockDateWithIndex:index];
}

#pragma mark - 创建股票详情

- (void)CreateStockDetails {
    
    [self.view addSubview:self.stockDetailsView];
    [self.stockDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(64);
    }];
    
    // 获取 JSON 文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fs" ofType:@"json"];
    // 读取 JSON 文件数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 将 JSON 数据转换为 Objective-C 对象
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    // 获取 JSON 文件的路径
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"pkdata" ofType:@"json"];
    // 读取 JSON 文件数据
    NSData *data1 = [NSData dataWithContentsOfFile:path1];
    // 将 JSON 数据转换为 Objective-C 对象
    NSError *error1 = nil;
    NSArray *jsonObject1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:&error1];
    
    [self.stockDetailsView setDataWithHandicapJson:jsonObject1.lastObject KLineJson:jsonObject];
    
}

#pragma mark - QuotationListDelegate

- (void)quotationListDelegateWithSelectedCategoryIndex:(NSInteger)index {
    NSLog(@"自选股分类选中下标%ld", index);
    if (index == 0) {
        // 获取 JSON 文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hqlist" ofType:@"json"];
        // 读取 JSON 文件数据
        NSData *data = [NSData dataWithContentsOfFile:path];
        // 将 JSON 数据转换为 Objective-C 对象
        NSError *error = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        self.quotationListView.dataJsonList = jsonObject[@"result"];
    } else {
        self.quotationListView.dataJsonList = [NSMutableArray array];
    }
}

- (void)quotationListDelegateWithSelectedStockCode:(NSString *)stockCode {
    NSLog(@"选中%@", stockCode);
}

- (void)deleteOptionalStockWithSelectedStockCode:(NSString *)stockCode {
    NSLog(@"删除%@", stockCode);
}

#pragma mark - 创建自选列表

- (void)CreateWatchlistUI{
    
    [self.view addSubview:self.quotationListView];
    [self.quotationListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(64);
    }];
    
    // 获取 JSON 文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hqlist" ofType:@"json"];
    // 读取 JSON 文件数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 将 JSON 数据转换为 Objective-C 对象
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    self.quotationListView.dataJsonList = jsonObject[@"result"];
    
}

#pragma mark — Lazy

- (JMStockDetailsView *)stockDetailsView {
    if (!_stockDetailsView) {
        _stockDetailsView = [[JMStockDetailsView alloc] init];
        _stockDetailsView.delegate = self;
    }
    return _stockDetailsView;
}

- (JMQuotationListView *)quotationListView{
    if (!_quotationListView) {
        _quotationListView = [[JMQuotationListView alloc] init];
        _quotationListView.delegate = self;
    }
    return _quotationListView;
}

@end
