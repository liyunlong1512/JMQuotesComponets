# JMQuotesComponets

[![CI Status](https://img.shields.io/travis/liyunlong1512/JMQuotesComponets.svg?style=flat)](https://travis-ci.org/liyunlong1512/JMQuotesComponets)
[![Version](https://img.shields.io/cocoapods/v/JMQuotesComponets.svg?style=flat)](https://cocoapods.org/pods/JMQuotesComponets)
[![License](https://img.shields.io/cocoapods/l/JMQuotesComponets.svg?style=flat)](https://cocoapods.org/pods/JMQuotesComponets)
[![Platform](https://img.shields.io/cocoapods/p/JMQuotesComponets.svg?style=flat)](https://cocoapods.org/pods/JMQuotesComponets)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JMQuotesComponets is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JMQuotesComponets',:git =>"https://github.com/liyunlong1512/JMQuotesComponets.git"
```

## 使用方法

组件内包含两个模块，一个是自选股列表，一个是个股行情模块。

### 自选股列表

```ruby

// 引入头文件
#import <JMQuotesComponets/JMQuotationListView.h>

// 引入代理方法
<QuotationListDelegate>

// 初始化
- (JMQuotationListView *)quotationListView{
    if (!_quotationListView) {
        _quotationListView = [[JMQuotationListView alloc] init];
        _quotationListView.delegate = self;
    }
    return _quotationListView;
}

// 显示组件
[self.view addSubview:self.quotationListView];
[self.quotationListView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.mas_equalTo(self.view);
    make.top.mas_equalTo(self.view).mas_offset(64);
}];

// 赋值
// dataJsonList 传JSON格式,数据结构参考下面

self.quotationListView.dataJsonList = jsondata;

/**
 *  MQTT数据 传整体数据过来
 */
- (void)setMQTTDataWithJson:(NSDictionary *)json;

/** 设置选中Tab */
- (void)setSelectionTabIndex:(NSInteger)index;


// QuotationListDelegate 代理方法

/**
 *  自选股分类选择回调
 *  index: 选中下标
 * 0.全部 1.港股 2.美股
 */
- (void)quotationListDelegateWithSelectedCategoryIndex:(NSInteger)index {
    // 这里可以去根据分类查询自选股
}

/**
 *  选中个股回调
 *  stockCode: 股票代码
 */
- (void)quotationListDelegateWithSelectedStockCode:(NSString *)stockCode {
    // 跳转个股详情逻辑
}

/**
 *  删除个股回调
 *  stockCode: 股票代码
 *  删除回调
 */
- (void)deleteOptionalStockWithSelectedStockCode:(NSString *)stockCode
                          fetchCompletionHandler:(void (^)(BOOL isDelete))completionHandler;

```

dataJsonList 数据结构

```ruby
[
    {
        "assetId": "00700.HK", // 股票代码
        "name": "腾讯控股", // 股票名称
        "price": "316.200", // 现价 
        "change": "3.000", // 涨跌额
        "changePct": "0.0096" // 涨跌幅
    },
    {
        "assetId": "COIN.US",
        "name": "Coinbase Global, Inc. Class A",
        "price": "316.200",
        "change": "3.000",
        "changePct": "0.0096"
    }
]
```

### 个股详情

```ruby

// 引入头文件
#import <JMQuotesComponets/JMStockDetailsView.h>

// 引入代理方法
<StockDetailsViewDelegate>

// 初始化
- (JMStockDetailsView *)stockDetailsView {
    if (!_stockDetailsView) {
        _stockDetailsView = [[JMStockDetailsView alloc] init];
        _stockDetailsView.delegate = self;
    }
    return _stockDetailsView;
}

// 显示组件
[self.view addSubview:self.stockDetailsView];
[self.stockDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.mas_equalTo(self.view);
    make.top.mas_equalTo(self.view).mas_offset(64);
}];

// 赋值，数据结构参考下面

/**
 *  初始化设置数据
 *  handicapJson    盘口数据   传result这一层
 *  kLineJson       K线数据   传result这一层
 */
- (void)setDataWithHandicapJson:(NSDictionary *)handicapJson
                      KLineJson:(NSDictionary *)kLineJson;

/**
 *  更新K线数据
 *  json            数据         传result这一层
 *  chartType       K线tab类型
 *  weights         复权类型
 *  more            是否数据加载更多
 */
- (void)updateKLineDataWithJson:(NSDictionary *)json
                      ChartTyep:(NSInteger)chartType
                        Weights:(NSString *)weights
                           More:(BOOL)more;

/**
 *  MQTT数据 传整体数据过来
 */
- (void)setMQTTDataWithJson:(NSDictionary *)json;


// StockDetailsViewDelegate 代理方法

/**
 *  获取更多K线数据
 *  timestamp:  时间戳
 */
- (void)GetMoreKLineDataWithTimestamp:(NSString *)timestamp {
    // 接口请求到数据后，使用下面方法，进行数据加载
    [self.stockDetailsView LoadMoreKLineData:jsonObject];
}

/**
 *  K线权重选择回调
 *  type: 权重 F: 前复权 B: 后复权 N: 除权
 */
- (void)KLineWeightsSelectionWithType:(NSString *)type {
}

**
 *  K线时间周期选择回调
 *  index: 时间周期, 当前项目从3开始
 *  0.盘前 1.盘中 2.盘后 3.分时 4.五日 5.日K 6.周K 7.月K 8.年K 9.1分 10.5分 11.15分 12.30分 13.60分
 */
- (void)KLineTimeSelectionWithIndex:(NSInteger)index {
}

```

数据结构

```ruby
// 盘口数据结构
{
  "code": 0,
  "message": null,
  "id": null,
  "result": [
    {
      "assetId": "00700.HK",
      "name": "腾讯控股",
      "price": "311.200",
      "change": "-5.000",
      "open": "314.600",
      "preClose": "316.200",
      "high": "314.600",
      "low": "310.000",
      "volume": "7812128",
      "turnover": "2441574803",
      "changePct": "-0.0158",
      "ttmPe": "14.05",
      "week52High": "416.600",
      "week52Low": "198.600",
      "hisHigh": "758.500",
      "hisLow": "-21.807",
      "avgPrice": "312.536",
      "turnRate": "0.0008",
      "pb": "3.68",
      "volRate": "1.19",
      "commitTee": "",
      "epsp": "22.15",
      "totalVal": "2983768038673",
      "ampLiTude": "0.0145",
      "flshr": "9587943569",
      "total": "9587943569",
      "status": 7,
      "ts": "1685502733000",
      "lotSize": "100",
      "bid1": "",
      "bidQty1": "",
      "ask1": "",
      "askQty1": "",
      "ttmDps": "2.400",
      "dpsRate": "0.0077",
      "isShortSell": false,
      "type": "1",
      "brokerQueue": "",
      "fmktVal": "2983768038673"
    }
  ]
}

```

```ruby
// K线数据结构
{
  "code": 0,
  "message": null,
  "id": null,
  "result": {
    "lastDayTurnover": "13516781502.37",
    "data": [
      [
        1657641600000,
        "338.600",
        "341.200",
        "335.000",
        "335.400",
        "17134245",
        "5778623253.00",
        "337.800"
      ],
      [
        1657728000000,
        "334.600",
        "337.400",
        "332.000",
        "335.000",
        "16774995",
        "5612694759.00",
        "335.400"
      ],
      [
        1657814400000,
        "330.000",
        "332.400",
        "323.200",
        "325.000",
        "26328504",
        "8620244653.00",
        "335.000"
      ]
    ],
    "lastDayVolume": "45550089"
  }
}
```

```ruby
// MQTT数据结构
{
    "data": [
        [
            "00700.HK",
            "腾讯控股",
            60,
            7,
            "316.200",
            "314.600",
            "312.000",
            "314.600",
            "310.400",
            "6284686",
            "1966470854",
            "-4.200",
            "-0.0133",
            "2991438393528",
            "2991438393528",
            "0.0007",
            "14.08",
            "3.69",
            "1.31",
            "0.3318",
            "312.899",
            "22.15",
            84.5277,
            "",
            "14.08",
            1685501051000,
            "2023-05-31",
            "10:44:11",
            "0.0133",
            2,
            "416.600",
            "198.600",
            "758.500",
            "-21.807",
            "",
            "",
            "",
            "",
            "0.00",
            "0.00",
            "0.0000",
            "",
            "",
            ""
        ]
    ],
    "funId": 2,
    "sendTime": "2023-05-31 10:44:12",
    "topicName": "QUOT/HK/00700.HK/2"
}
```

## Author

yunlong.li, yunlong.li@fargowealth.com.hk

## License

JMQuotesComponets is available under the MIT license. See the LICENSE file for more info.

