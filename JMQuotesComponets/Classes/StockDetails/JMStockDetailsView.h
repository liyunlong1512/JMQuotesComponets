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

@property (nonatomic, weak) id<StockDetailsViewDelegate> delegate;


/**
 *  初始化设置数据
 *  handicapJson 盘口数据
 *  kLineJson       K线数据
 */
- (void)setDataWithHandicapJson:(NSDictionary *)handicapJson
                      KLineJson:(NSDictionary *)kLineJson;

/**
 *  更新K线数据
 *  json            数据
 *  chartType   K线tab类型
 *  weights       复权类型
 *  more           是否数据加载更多
 */
- (void)updateKLineDataWithJson:(NSDictionary *)json
                      ChartTyep:(NSInteger)chartType
                        Weights:(NSString *)weights
                           More:(BOOL)more;

/**
 *  MQTT数据
 */
- (void)setMQTTDataWithJson:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
