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

/** <#注释#> */
@property(nonatomic, assign) NSInteger count;

@end

@implementation JMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.count = 0;
    
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
    
    if (index > 8) return;
    
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

- (void)KLineTimeSelectionWithIndex:(NSInteger)index Type:(NSString *)type {
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
//    NSDictionary *jsonObject = @{};
    
    // 获取 JSON 文件的路径
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"pkdata" ofType:@"json"];
    // 读取 JSON 文件数据
    NSData *data1 = [NSData dataWithContentsOfFile:path1];
    // 将 JSON 数据转换为 Objective-C 对象
    NSError *error1 = nil;
    NSArray *jsonObject1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:&error1];
    
    [self.stockDetailsView setDataWithHandicapJson:jsonObject1.lastObject KLineJson:jsonObject ChartTyep:2];
    
    // 延时 5 秒执行 doSomethingAfterDelay 方法
//    [self performSelector:@selector(doSomethingAfterDelay) withObject:nil afterDelay:5.0];
//    [self performSelector:@selector(doSomethingAfterDelay1) withObject:nil afterDelay:10.0];
//
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
//                                                      target:self
//                                                    selector:@selector(doSomethingAfterDelay1)
//                                                    userInfo:nil
//                                                     repeats:YES];
    
}

- (void)doSomethingAfterDelay1 {
    
    if (self.count > 11) {
        return;
    }
    
    NSLog(@"计数器%ld",self.count);
    

    NSArray *jsonStrings = @[
        @"{\"data\":[[\"00700.HK\",1685951460000,\"338.000\",\"335.334\",\"315.400\",\"151856\",\"51313608.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685951520000,\"338.000\",\"335.349\",\"315.400\",\"125000\",\"42233042.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685951580000,\"338.000\",\"335.354\",\"315.400\",\"69460\",\"23470272.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685951640000,\"338.000\",\"335.366\",\"315.400\",\"93105\",\"31467355.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685951700000,\"338.000\",\"335.382\",\"315.400\",\"110190\",\"37231710.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685951760000,\"338.400\",\"335.400\",\"315.400\",\"119030\",\"40261176.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685951820000,\"338.400\",\"335.419\",\"315.400\",\"111140\",\"37614200.400\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685951880000,\"338.400\",\"335.435\",\"315.400\",\"104100\",\"35231770.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685951940000,\"338.800\",\"335.486\",\"315.400\",\"301810\",\"102187967.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685951960000,\"338.800\",\"335.486\",\"315.400\",\"301810\",\"102187967.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685952000000,\"338.200\",\"335.648\",\"315.400\",\"1360910\",\"460337657.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}",
        @"{\"data\":[[\"00700.HK\",1685952010000,\"338.200\",\"335.648\",\"315.400\",\"1360910\",\"460337657.000\",\"N\",\"336.000\"]],\"funId\":4,\"sendTime\":\"2023-06-02 14:32:11\",\"topicName\":\"QUOT/HK/00700.HK/4\"}"
    ];
    
    NSData *jsonData = [jsonStrings[self.count] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];

    if (error) {
        NSLog(@"Error parsing JSON: %@", error.localizedDescription);
    } else {
        [self.stockDetailsView setMQTTDataWithJson:jsonDict];
    }
    
    self.count += 1;
}

- (void)doSomethingAfterDelay {
    // 在延时后执行的代码
    // 获取 JSON 文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mqtt_fs" ofType:@"json"];
    // 读取 JSON 文件数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 将 JSON 数据转换为 Objective-C 对象
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    [self.stockDetailsView setMQTTDataWithJson:jsonObject];
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

- (void)quotationListDelegateWithSelectedModel:(JMQuotationListModel *)model {
    NSLog(@"选中%@", model.name);
    [self.quotationListView setSelectionTabIndex:2];
}

- (void)deleteOptionalStockWithSelectedStockCode:(NSString *)stockCode
                          fetchCompletionHandler:(nonnull void (^)(BOOL))completionHandler {
    NSLog(@"删除%@", stockCode);
    completionHandler(YES);
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
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                      target:self
                                                    selector:@selector(doSomethingAfterDelay2)
                                                    userInfo:nil
                                                     repeats:YES];
    
}

- (void)doSomethingAfterDelay2 {
    
    if (self.count > 2) {
        return;
    }
    
    NSLog(@"计时器开始：%ld", self.count);
    
    // 在延时后执行的代码
    // 获取 JSON 文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"mqtt_pk_hk_%ld",self.count] ofType:@"json"];
    // 读取 JSON 文件数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 将 JSON 数据转换为 Objective-C 对象
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    [self.quotationListView setMQTTDataWithJson:jsonObject];
    
    self.count += 1;
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
