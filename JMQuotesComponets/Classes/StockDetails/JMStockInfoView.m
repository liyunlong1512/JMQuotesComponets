//
//  JMStockInfoView.m
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/30.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import "JMStockInfoView.h"
#import "QuotationConstant.h"
#import "JMHandicapInfoCollectionViewCell.h"

@interface JMStockInfoView ()<UICollectionViewDataSource, UICollectionViewDelegate>

/** 最新价格 */
@property (nonatomic, strong) UILabel *latestPriceLab;

/** 涨跌额 */
@property (nonatomic, strong) UILabel *changeAmountLab;

/// 涨跌幅
@property (nonatomic, strong) UILabel *quoteChangeLab;

/** 交易状态 */
@property (nonatomic, strong) UILabel *tradingStatusLab;

/** 盘口信息*/
@property (nonatomic, strong) UICollectionView *handicapInfoCollectionView;

/** 展开按钮 */
@property (nonatomic, strong) UIButton *expandBtn;

@end

@implementation JMStockInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        
    }
    return self;
}

- (void)createUI {
    
    self.backgroundColor = UIColor.backgroundColor;
    
    [self addSubview:self.latestPriceLab];
    [self.latestPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(16);
    }];
    
    [self addSubview:self.changeAmountLab];
    [self.changeAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.latestPriceLab.mas_top).mas_offset(5);
        make.left.mas_equalTo(self.latestPriceLab.mas_right).mas_offset(10);
    }];
    
    [self addSubview:self.quoteChangeLab];
    [self.quoteChangeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.changeAmountLab.mas_bottom);
        make.left.mas_equalTo(self.changeAmountLab);
    }];
    
    [self addSubview:self.tradingStatusLab];
    [self.tradingStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.latestPriceLab.mas_bottom);
        make.left.mas_equalTo(self.latestPriceLab);
    }];
    
    [self addSubview:self.handicapInfoCollectionView];
    [self.handicapInfoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tradingStatusLab.mas_bottom).mas_offset(16);
        make.left.right.mas_equalTo(self);
        make.height.mas_offset(kHeightScale(60));
    }];
    
    [self addSubview:self.expandBtn];
    [self.expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.handicapInfoCollectionView.mas_bottom);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        make.size.mas_offset(kWidthScale(10));
    }];
    
}

#pragma mark - ExpandBtnClick

- (void)ExpandBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.handicapInfoCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(kHeightScale(8*20));
        }];
    } else {
        [self.handicapInfoCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(kHeightScale(3*20));
        }];
    }
    [self.handicapInfoCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

// 点击元素响应方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        return headerView;
        
    } else {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        return footerView;
        
    }
    
}

//  设置页脚(水平滑动的时候设置width,垂直滑动的时候设置height)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(kSCREEN_WIDTH, 0);
}

//  设置页眉(水平滑动的时候设置width,垂直滑动的时候设置height)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kSCREEN_WIDTH, 0);
}

//  定义每个单元格相互之间的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 12;
}

//  定义单元格所在行line之间的距离,前一行和后一行的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 0;
}

//  设置分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//  定义每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.expandBtn.isSelected ? self.stockInfoList.count : 9;
}

//  设置每个元素大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //cell宽
    CGFloat width = (kSCREEN_WIDTH - 56) / 3;
    return CGSizeMake(width, kHeightScale(20));
}

//  定义每个元素的margin(边缘 上-左-下-右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 16, 0, 16);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JMHandicapInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JMHandicapInfoCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.stockInfoList[indexPath.row];
    return cell;
    
}

#pragma mark — Lazy

- (UIButton *)expandBtn {
    if (!_expandBtn) {
        _expandBtn = [[UIButton alloc] init];
        [_expandBtn setBackgroundImage:[UIImage imageWithContentsOfFile:kImageNamed(@"expand_n.png")] forState:UIControlStateNormal];
        [_expandBtn setBackgroundImage:[UIImage imageWithContentsOfFile:kImageNamed(@"expand_s.png")] forState:UIControlStateHighlighted];
        [_expandBtn setBackgroundImage:[UIImage imageWithContentsOfFile:kImageNamed(@"expand_s.png")] forState:UIControlStateSelected];
        [_expandBtn addTarget:self action:@selector(ExpandBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandBtn;
}

- (UICollectionView *)handicapInfoCollectionView {
    if (!_handicapInfoCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _handicapInfoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _handicapInfoCollectionView.backgroundColor = UIColor.backgroundColor;
        _handicapInfoCollectionView.dataSource = self;
        _handicapInfoCollectionView.delegate = self;
        _handicapInfoCollectionView.showsVerticalScrollIndicator = NO;
        _handicapInfoCollectionView.showsHorizontalScrollIndicator = NO;
        
        //默认cell
        [_handicapInfoCollectionView registerClass:[JMHandicapInfoCollectionViewCell class] forCellWithReuseIdentifier:@"JMHandicapInfoCollectionViewCell"];
        //默认组头
        [_handicapInfoCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        //默认组尾
        [_handicapInfoCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        
    }
    return _handicapInfoCollectionView;
}

- (UILabel *)tradingStatusLab {
    if (!_tradingStatusLab) {
        _tradingStatusLab = [[UILabel alloc] init];
        _tradingStatusLab.text = @"交易中  2023/05/14   11:10:50  北京时间";
        _tradingStatusLab.font = kFont_Regular(11);
        _tradingStatusLab.textColor = UIColor.secondaryTextColor;
    }
    return _tradingStatusLab;
}

- (UILabel *)quoteChangeLab {
    if (!_quoteChangeLab) {
        _quoteChangeLab = [[UILabel alloc] init];
        _quoteChangeLab.text = @"+1.62%";
        _quoteChangeLab.font = kFont_Regular(14);
        _quoteChangeLab.textColor = UIColor.upColor;
    }
    return _quoteChangeLab;
}

- (UILabel *)changeAmountLab {
    if (!_changeAmountLab) {
        _changeAmountLab = [[UILabel alloc] init];
        _changeAmountLab.text = @"+51.62";
        _changeAmountLab.font = kFont_Regular(14);
        _changeAmountLab.textColor = UIColor.upColor;
    }
    return _changeAmountLab;
}

- (UILabel *)latestPriceLab {
    if (!_latestPriceLab) {
        _latestPriceLab = [[UILabel alloc] init];
        _latestPriceLab.text = @"475.60";
        _latestPriceLab.font = kFont_Regular(40);
        _latestPriceLab.textColor = UIColor.upColor;
    }
    return _latestPriceLab;
}

#pragma mark - 数据重载

- (void)setStockInfoList:(NSArray *)stockInfoList {
    _stockInfoList = stockInfoList;
    [self.handicapInfoCollectionView reloadData];
}

@end