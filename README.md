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


// QuotationListDelegate 代理方法

// 自选股tab 分类
// 0.全部 1.港股 2.美股
- (void)quotationListDelegateWithSelectedCategoryIndex:(NSInteger)index {
    // 这里可以去根据分类查询自选股
}

// 选中个股回调
// stockCode 股票代码
- (void)quotationListDelegateWithSelectedStockCode:(NSString *)stockCode {
    // 跳转个股详情逻辑
}

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

// 赋值
// dataSource 传JSON格式,数据结构参考下面
self.stockDetailsView.dataSource = jsondata;


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

## Author

yunlong.li, yunlong.li@fargowealth.com.hk

## License

JMQuotesComponets is available under the MIT license. See the LICENSE file for more info.

