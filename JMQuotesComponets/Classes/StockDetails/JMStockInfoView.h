//
//  JMStockInfoView.h
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/30.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMStockInfoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMStockInfoView : UIView

/** 盘口信息 */
@property (nonatomic, strong) JMStockInfoViewModel *stockInfoViewModel;

@end

NS_ASSUME_NONNULL_END
