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
    
//    [self CreateWatchlistUI];
    
    [self CreateStockDetails];
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
    self.stockDetailsView.dataSource = jsonObject;
}

- (void)getMoreData {
    
    // 获取 JSON 文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"more_dayK" ofType:@"json"];
    // 读取 JSON 文件数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 将 JSON 数据转换为 Objective-C 对象
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    [self.stockDetailsView LoadMoreKLineData:jsonObject];
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
    
    [self setStockDateWithIndex:3];
    
}

#pragma mark - QuotationListDelegate

- (void)quotationListDelegateWithSelectedCategoryIndex:(NSInteger)index {
    NSLog(@"自选股分类选中下标%ld", index);
}

- (void)quotationListDelegateWithSelectedStockCode:(NSString *)stockCode {
    NSLog(@"%@", stockCode);
}

#pragma mark - 创建自选列表

- (void)CreateWatchlistUI{
    NSMutableArray * listArray = [[NSMutableArray alloc] init];
    NSDictionary *myDict = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"0", @"stockMarketType",
                            @"腾讯控股", @"stockName",
                            @"00700", @"stockCode",
                            @"333.200", @"currentPrice",
                            @"-1.40", @"quoteChange",
                            nil];
    NSDictionary *myDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"0", @"stockMarketType",
                             @"美团-W", @"stockName",
                             @"03690", @"stockCode",
                             @"128.600", @"currentPrice",
                             @"-1.09", @"quoteChange",
                             nil];
    NSDictionary *myDict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"0", @"stockMarketType",
                             @"阿里巴巴-SW", @"stockName",
                             @"09988", @"stockCode",
                             @"82.450", @"currentPrice",
                             @"-6.04", @"quoteChange",
                             nil];
    NSDictionary *myDict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"1", @"stockMarketType",
                             @"苹果", @"stockName",
                             @"AAPL", @"stockCode",
                             @"175.050", @"currentPrice",
                             @"1.37", @"quoteChange",
                             nil];
    NSDictionary *myDict4 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"1", @"stockMarketType",
                             @"特斯拉", @"stockName",
                             @"TSLA", @"stockCode",
                             @"176.890", @"currentPrice",
                             @"1.74", @"quoteChange",
                             nil];
    NSDictionary *myDict5 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"1", @"stockMarketType",
                             @"Meta Platforms", @"stockName",
                             @"META", @"stockCode",
                             @"246.850", @"currentPrice",
                             @"1.80", @"quoteChange",
                             nil];
    NSDictionary *myDict6 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"1", @"stockMarketType",
                             @"BTCUSDT.P", @"stockName",
                             @"BTC", @"stockCode",
                             @"8080.000", @"currentPrice",
                             @"0.00", @"quoteChange",
                             nil];
    
    
    [listArray addObject:myDict];
    [listArray addObject:myDict1];
    [listArray addObject:myDict2];
    [listArray addObject:myDict3];
    [listArray addObject:myDict4];
    [listArray addObject:myDict5];
    [listArray addObject:myDict6];
    
    JMQuotationListView *quotationListView = [[JMQuotationListView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT - 64)];
    quotationListView.delegate = self;
    quotationListView.dataSource = listArray;
    [self.view addSubview:quotationListView];
}

#pragma mark — Lazy

- (JMStockDetailsView *)stockDetailsView {
    if (!_stockDetailsView) {
        _stockDetailsView = [[JMStockDetailsView alloc] init];
        _stockDetailsView.delegate = self;
    }
    return _stockDetailsView;
}

@end
