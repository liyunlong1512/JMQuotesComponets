//
//  JMQuotationListModel.h
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/29.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuotationConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMQuotationListModel : NSObject

/** 股票市场类型 */
@property(nonatomic, assign) StockMarketType stockMarketType;

/** 股票名称 */
@property (nonatomic, copy) NSString *stockName;

/** 股票代码 */
@property (nonatomic, copy) NSString *stockCode;

/** 现价 */
@property (nonatomic, copy) NSString *currentPrice;

/** 涨跌幅 */
@property (nonatomic, copy) NSString *quoteChange;

@end

NS_ASSUME_NONNULL_END
