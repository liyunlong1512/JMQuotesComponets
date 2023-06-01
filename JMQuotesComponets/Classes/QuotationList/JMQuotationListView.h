//
//  JMQuotationListView.h
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/29.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QuotationListDelegate <NSObject>

/**
 *  选中个股回调
 *  stockCode: 股票代码
 */
- (void)quotationListDelegateWithSelectedStockCode:(NSString *)stockCode;

/**
 *  自选股分类选择回调
 *  index: 选中下标
 */
- (void)quotationListDelegateWithSelectedCategoryIndex:(NSInteger)index;

/**
 *  删除个股回调
 *  stockCode: 股票代码
 */
- (void)deleteOptionalStockWithSelectedStockCode:(NSString *)stockCode;

@end

@interface JMQuotationListView : UIView

@property (nonatomic, weak) id<QuotationListDelegate> delegate;

/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataJsonList;

@end

NS_ASSUME_NONNULL_END
