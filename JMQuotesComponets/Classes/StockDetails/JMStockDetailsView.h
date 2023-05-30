//
//  JMStockDetailsView.h
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/30.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol StockDetailsViewDelegate <NSObject>

/**
 *  K线时间选择回调
 *  index: 时间周期
 */
- (void)KLineTimeSelectionWithIndex:(NSInteger)index;

/**
 *  K线权重选择回调
 *  type: 权重 F: 前复权 B: 后复权 N: 除权
 */
- (void)KLineWeightsSelectionWithType:(NSString *)type;

/**
 *  获取更多K线数据
 *  timestamp:  时间戳
 */
- (void)GetMoreKLineDataWithTimestamp:(NSString *)timestamp;

@end

@interface JMStockDetailsView : UIView

/** 数据源 */
@property (nonatomic, strong) NSDictionary *dataSource;

@property (nonatomic, weak) id<StockDetailsViewDelegate> delegate;

/**
 *  加载更多K线数据
 *  data:  数据
 */
- (void)LoadMoreKLineData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
