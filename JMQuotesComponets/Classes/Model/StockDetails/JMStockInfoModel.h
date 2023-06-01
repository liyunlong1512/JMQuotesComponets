//
//  JMStockInfoModel.h
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/30.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 股票信息Model
@interface JMStockInfoModel : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *titleStr;

/** 描述 */
@property (nonatomic, copy) NSString *describeStr;

/** 内容 */
@property (nonatomic, copy) NSString *contentStr;

/** 颜色 */
@property (nonatomic, strong) UIColor *myColor;

/** <#注释#> */
@property (nonatomic, copy) NSString *assetId;
/** <#注释#> */
@property (nonatomic, copy) NSString *name;
/** <#注释#> */
@property (nonatomic, copy) NSString *price;
/** <#注释#> */
@property (nonatomic, copy) NSString *change;
/** <#注释#> */
@property (nonatomic, copy) NSString *open;
/** <#注释#> */
@property (nonatomic, copy) NSString *preClose;
/** <#注释#> */
@property (nonatomic, copy) NSString *high;
/** <#注释#> */
@property (nonatomic, copy) NSString *low;
/** <#注释#> */
@property (nonatomic, copy) NSString *volume;
/** <#注释#> */
@property (nonatomic, copy) NSString *turnover;
/** <#注释#> */
@property (nonatomic, copy) NSString *changePct;
/** <#注释#> */
@property (nonatomic, copy) NSString *ttmPe;
/** <#注释#> */
@property (nonatomic, copy) NSString *pe;
/** <#注释#> */
@property (nonatomic, copy) NSString *week52High;
/** <#注释#> */
@property (nonatomic, copy) NSString *week52Low;
/** <#注释#> */
@property (nonatomic, copy) NSString *hisHigh;
/** <#注释#> */
@property (nonatomic, copy) NSString *hisLow;
/** <#注释#> */
@property (nonatomic, copy) NSString *avgPrice;
/** <#注释#> */
@property (nonatomic, copy) NSString *turnRate;
/** <#注释#> */
@property (nonatomic, copy) NSString *pb;
/** <#注释#> */
@property (nonatomic, copy) NSString *volRate;
/** <#注释#> */
@property (nonatomic, copy) NSString *commitTee;
/** <#注释#> */
@property (nonatomic, copy) NSString *epsp;
/** <#注释#> */
@property (nonatomic, copy) NSString *totalVal;
/** <#注释#> */
@property (nonatomic, copy) NSString *ampLiTude;
/** <#注释#> */
@property (nonatomic, copy) NSString *flshr;
/** <#注释#> */
@property (nonatomic, copy) NSString *total;
/** <#注释#> */
@property(nonatomic, assign) NSInteger status;
/** <#注释#> */
@property (nonatomic, copy) NSString *ts;
/** <#注释#> */
@property (nonatomic, copy) NSString *lotSize;
/** <#注释#> */
@property (nonatomic, copy) NSString *bid1;
/** <#注释#> */
@property (nonatomic, copy) NSString *bidQty1;
/** <#注释#> */
@property (nonatomic, copy) NSString *ask1;
/** <#注释#> */
@property (nonatomic, copy) NSString *askQty1;
/** <#注释#> */
@property (nonatomic, copy) NSString *ttmDps;
/** <#注释#> */
@property (nonatomic, copy) NSString *dpsRate;
/** <#注释#> */
@property(nonatomic, assign) BOOL isShortSell;
/** <#注释#> */
@property (nonatomic, copy) NSString *type;
/** <#注释#> */
@property (nonatomic, copy) NSString *brokerQueue;
/** <#注释#> */
@property (nonatomic, copy) NSString *fmktVal;

@end

NS_ASSUME_NONNULL_END
