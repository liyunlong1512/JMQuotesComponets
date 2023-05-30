//
//  JMQuotationListView.m
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/29.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import "JMQuotationListView.h"
#import "QuotationConstant.h"
#import "UIButton+KJContentLayout.h"
#import "JMQuotationListTableViewCell.h"
#import "JMDelayPromptView.h"
#import "JMQuotationListHeadView.h"

@interface JMQuotationListView () <UITableViewDataSource, UITableViewDelegate, DelayPromptViewDelegate, QuotationListHeadViewDelegate>

/** 延时行情提示 */
@property (nonatomic,strong) JMDelayPromptView *delayPromptView;

/** 行情列表头部 */
@property (nonatomic,strong) JMQuotationListHeadView *quotationListHeadView;

/** 名称代码 */
@property (nonatomic,strong) UILabel *nameCodeLab;

/** 最新价格排序按钮 */
@property (nonatomic,strong) UIButton *sortPriceBtn;

/** 涨跌幅排序按钮 */
@property (nonatomic,strong) UIButton *sortQuoteChangeBtn;

/** 行情列表 */
@property (nonatomic, strong) UITableView *tableView;

/** 处理后数据源 */
@property (nonatomic,strong) NSMutableArray *processedDataSource;

@end

@implementation JMQuotationListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.backgroundColor = UIColor.backgroundColor;
    
    [self addSubview:self.delayPromptView];
    [self.delayPromptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_offset(kHeightScale(24));
    }];
    
    [self addSubview:self.quotationListHeadView];
    [self.quotationListHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.delayPromptView.mas_bottom).mas_offset(16);
        make.left.mas_equalTo(self).mas_offset(16);
        make.right.mas_equalTo(self.mas_right).mas_offset(-16);
        make.height.mas_offset(kHeightScale(24));
    }];
    
    [self addSubview:self.nameCodeLab];
    [self.nameCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.quotationListHeadView.mas_bottom).mas_offset(16);
        make.left.mas_equalTo(self).mas_offset(16);
    }];

    [self addSubview:self.sortQuoteChangeBtn];
    [self.sortQuoteChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameCodeLab);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.width.mas_offset(kWidthScale(60));
        make.height.mas_offset(kHeightScale(14));
    }];

    [self addSubview:self.sortPriceBtn];
    [self.sortPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sortQuoteChangeBtn);
        make.right.mas_equalTo(self.sortQuoteChangeBtn.mas_left).mas_offset(-10);
        make.width.mas_offset(kWidthScale(80));
        make.height.mas_offset(kHeightScale(14));
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameCodeLab.mas_bottom).mas_offset(16);
        make.left.right.bottom.equalTo(self);
    }];
    
}

#pragma mark -  数据处理

- (void)setDataSource:(NSMutableArray *)dataSource {
    
    [dataSource enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        JMQuotationListModel *model = [[JMQuotationListModel alloc] init];
        model.stockMarketType = [dic[@"stockMarketType"] intValue];
        model.stockName = dic[@"stockName"];
        model.stockCode = dic[@"stockCode"];
        model.currentPrice = dic[@"currentPrice"];
        model.quoteChange = dic[@"quoteChange"];
        
        [self.processedDataSource addObject:model];
        
    }];
    
    [self.tableView reloadData];
    
}

#pragma mark - QuotationListHeadViewDelegate

- (void)quotationListHeadViewWithSelectionIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(quotationListDelegateWithSelectedCategoryIndex:)]) {
        [self.delegate quotationListDelegateWithSelectedCategoryIndex:index];
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

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView setEditing:NO animated:YES];  // 重置编辑状态
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 在这里执行删除操作
        [self.processedDataSource removeObjectAtIndex:indexPath.row];
        [self.tableView  deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView setEditing:NO animated:YES];
//        [self.tableView reloadData];
    }];
    return @[deleteAction];
}

// 处理某行的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(quotationListDelegateWithSelectedStockCode:)]) {
        JMQuotationListModel *model = self.processedDataSource[indexPath.row];
        NSString * stockMarketType = @"";
        //市场类型
        switch (model.stockMarketType) {
            case StockMarketType_HK:{
                stockMarketType = @"HK";
            }
                break;
            case StockMarketType_US:{
                stockMarketType = @"US";
            }
                break;
            case StockMarketType_SH:{
                stockMarketType = @"SH";
            }
                break;
            case StockMarketType_SZ:{
                stockMarketType = @"SZ";
            }
                break;
            default:
                break;
        }
        [self.delegate quotationListDelegateWithSelectedStockCode:[NSString stringWithFormat:@"%@.%@",model.stockCode, stockMarketType]];
    }
}

/// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.processedDataSource.count;
}

// 需要注意的是，这个代理方法和直接返回当前Cell高度的代理方法并不一样。
// 这个代理方法会将当前所有Cell的高度都预估出来，而不是只计算显示的Cell，所以这种方式对性能消耗还是很大的。
// 所以通过设置estimatedRowHeight属性的方式，和这种代理方法的方式，最后性能消耗都是一样的。
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50.f;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMQuotationListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMQuotationListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.quotationListModel = self.processedDataSource[indexPath.row];
    return cell;
}

#pragma mark — Lazy

- (NSMutableArray *)processedDataSource {
    if (!_processedDataSource) {
        _processedDataSource = [[NSMutableArray alloc] init];
    }
    return _processedDataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        // 设置tableView自动高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor = UIColor.backgroundColor;
        _tableView.separatorColor = UIColor.dividingLineColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
        [_tableView registerClass:[JMQuotationListTableViewCell class] forCellReuseIdentifier:@"JMQuotationListTableViewCell"];
        _tableView.allowsSelectionDuringEditing = YES;
    }
    return _tableView;
}

- (UIButton *)sortQuoteChangeBtn {
    if (!_sortQuoteChangeBtn) {
        _sortQuoteChangeBtn = [[UIButton alloc] init];
        
        UIImage *imgae = [UIImage imageWithContentsOfFile:kImageNamed(@"sort.png")];
        [_sortQuoteChangeBtn setImage:imgae forState:UIControlStateNormal];
        [_sortQuoteChangeBtn setTitle:@"涨跌幅" forState:UIControlStateNormal];
        [_sortQuoteChangeBtn setTitleColor:UIColor.quotesListHeadTitleColor forState:UIControlStateNormal];
        [_sortQuoteChangeBtn.titleLabel setFont:kFont_Regular(12)];
        [_sortQuoteChangeBtn setLayoutType:KJButtonContentLayoutStyleLeftImageRight];
        [_sortQuoteChangeBtn setPadding:2.f];
        [_sortQuoteChangeBtn setPeriphery:0.f];
    }
    return _sortQuoteChangeBtn;
}

- (UIButton *)sortPriceBtn {
    if (!_sortPriceBtn) {
        _sortPriceBtn = [[UIButton alloc] init];
        UIImage *imgae = [UIImage imageWithContentsOfFile:kImageNamed(@"sort.png")];
        [_sortPriceBtn setImage:imgae forState:UIControlStateNormal];
        [_sortPriceBtn setTitle:@"最新价格" forState:UIControlStateNormal];
        [_sortPriceBtn setTitleColor:UIColor.quotesListHeadTitleColor forState:UIControlStateNormal];
        [_sortPriceBtn.titleLabel setFont:kFont_Regular(12)];
        [_sortPriceBtn setLayoutType:KJButtonContentLayoutStyleLeftImageRight];
        [_sortPriceBtn setPadding:2.f];
        [_sortPriceBtn setPeriphery:0.f];
    }
    return _sortPriceBtn;
}

- (UILabel *)nameCodeLab {
    if (!_nameCodeLab){
        _nameCodeLab = [[UILabel alloc] init];
        _nameCodeLab.font = kFont_Regular(12);
        _nameCodeLab.text = @"名称代码";
        _nameCodeLab.textColor = UIColor.quotesListHeadTitleColor;
    }
    return  _nameCodeLab;
}

- (JMQuotationListHeadView *)quotationListHeadView {
    if (!_quotationListHeadView){
        _quotationListHeadView = [[JMQuotationListHeadView alloc] init];
        _quotationListHeadView.delegate = self;
    }
    return  _quotationListHeadView;
}

- (JMDelayPromptView *)delayPromptView {
    if (!_delayPromptView){
        _delayPromptView = [[JMDelayPromptView alloc] init];
        _delayPromptView.delegate = self;
    }
    return  _delayPromptView;
}

@end
