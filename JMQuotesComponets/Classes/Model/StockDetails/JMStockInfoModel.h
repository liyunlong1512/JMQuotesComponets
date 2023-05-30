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

@end

NS_ASSUME_NONNULL_END
