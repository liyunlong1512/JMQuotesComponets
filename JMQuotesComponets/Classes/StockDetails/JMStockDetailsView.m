//
//  JMStockDetailsView.m
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/30.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import "JMStockDetailsView.h"

#import "QuotationConstant.h"
#import "JMDelayPromptView.h"
#import "JMStockInfoView.h"
#import "JMMiddleLayerView.h"
#import "JMStockInfoModel.h"

@interface JMStockDetailsView ()<DelayPromptViewDelegate,MiddleLayerViewDelegate>

/** 延时行情提示 */
@property (nonatomic,strong) JMDelayPromptView *delayPromptView;

/** 股票信息view */
@property (nonatomic, strong) JMStockInfoView *stockInfoView;

/** K线图view */
@property (nonatomic, strong) JMMiddleLayerView *middleLayerView;

@end

@implementation JMStockDetailsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
        
        NSArray *titleList = @[
            @"最高", @"今开", @"成交量",
            @"最低", @"昨收", @"成交额",
            @"换手率", @"市盈率", @"总市值",
            @"量比", @"市盈", @"总股本",
            @"收益", @"市盈", @"流通市值",
            @"52周高", @"市净率", @"流通股本",
            @"52周低", @"均价", @"振幅",
            @"股息率", @"股息", @"每手",
            ];
        
        NSArray *describeList = @[
            @"", @"", @"",
            @"", @"", @"",
            @"", @"TTM", @"",
            @"", @"动", @"",
            @"TTM", @"静", @"",
            @"", @"", @"",
            @"", @"", @"",
            @"TTM", @"TTM", @"",
            ];
        
        NSArray *contentList = @[
            @"480.80", @"473.20", @"868.34万股",
            @"471.80", @"471.20", @"41.29亿",
            @"0.09%", @"20.15", @"4228.55万亿",
            @"10.02", @"20.15", @"98.55亿",
            @"2.80", @"20.15", @"4198.55亿",
            @"476.88", @"20.15", @"98.55亿",
            @"471.80", @"20.15", @"2.48%",
            @"0.80%", @"20.15", @"20股",
            ];
        
        NSArray *colorList = @[
            UIColor.upColor, UIColor.upColor, UIColor.handicapInfoTextColor,
            UIColor.downColor, UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor,
            UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor,
            UIColor.upColor, UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor,
            UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor,
            UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor,
            UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor,
            UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor, UIColor.handicapInfoTextColor,
            ];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [titleList enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMStockInfoModel *model = [[JMStockInfoModel alloc] init];
            model.titleStr = titleList[idx];
            model.describeStr = describeList[idx];
            model.contentStr = contentList[idx];
            model.myColor = colorList[idx];
            [array addObject:model];
        }];
        
        self.stockInfoView.stockInfoList = array;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kNoticeName_GetMoreData object:nil];
        
    }
    return self;
}

- (void)createUI {
    
    self.backgroundColor = UIColor.stockDetailsBackgroundColor;
    
    [self addSubview:self.delayPromptView];
    [self.delayPromptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_offset(kHeightScale(24));
    }];
    
    [self addSubview:self.stockInfoView];
    [self.stockInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.delayPromptView.mas_bottom).mas_offset(14);
        make.left.right.mas_equalTo(self);
    }];
    
    [self addSubview:self.middleLayerView];
    [self.middleLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stockInfoView.mas_bottom).mas_offset(14);
        make.left.right.mas_equalTo(self);
        make.height.mas_offset(kHeightScale(345));
    }];
    
}

#pragma mark - 通知方法

- (void)handleNotification:(NSNotification *)notification {
    if ([self.delegate respondsToSelector:@selector(GetMoreKLineDataWithTimestamp:)]) {
        [self.delegate GetMoreKLineDataWithTimestamp:[NSString stringWithFormat:@"%@",notification.object]];
    }
}

#pragma mark - MiddleLayerViewDelegate

- (void)KLineWeightsSelectionWithType:(NSString *)type {
    NSLog(@"权重选择 %@", type);
    if ([self.delegate respondsToSelector:@selector(KLineWeightsSelectionWithType:)]) {
        [self.delegate KLineWeightsSelectionWithType:type];
    }
}

- (void)KLineTimeSelectionWithIndex:(NSInteger)index {
    NSLog(@"图表时间 %ld", index);
    if ([self.delegate respondsToSelector:@selector(KLineTimeSelectionWithIndex:)]) {
        [self.delegate KLineTimeSelectionWithIndex:index];
    }
}

#pragma mark - DelayPromptViewDelegate

- (void)closePrompt {
    NSLog(@"关闭延时行情提示");
    self.delayPromptView.hidden = YES;
    [self.delayPromptView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(0);
    }];
}

#pragma mark — Lazy

- (JMMiddleLayerView *)middleLayerView {
    if (!_middleLayerView){
        _middleLayerView = [[JMMiddleLayerView alloc] init];
        _middleLayerView.delegate = self;
    }
    return  _middleLayerView;
}

- (JMStockInfoView *)stockInfoView {
    if (!_stockInfoView){
        _stockInfoView = [[JMStockInfoView alloc] init];
    }
    return  _stockInfoView;
}

- (JMDelayPromptView *)delayPromptView {
    if (!_delayPromptView){
        _delayPromptView = [[JMDelayPromptView alloc] init];
        _delayPromptView.delegate = self;
    }
    return  _delayPromptView;
}

#pragma mark - 数据重载

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    self.middleLayerView.dataSource = dataSource;
}

- (void)LoadMoreKLineData:(NSDictionary *)data {
    NSDictionary *dict = data[@"data"];
    NSArray * arr = dict[@"result"][@"data"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNoticeName_LoadMoreData object:arr];
}

@end
