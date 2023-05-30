//
//  JMQuotationListTableViewCell.m
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/29.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import "JMQuotationListTableViewCell.h"

@interface JMQuotationListTableViewCell ()

/// 股票名称
@property (nonatomic, strong) UILabel *stockNameLab;

/// 股票市场icon
@property (nonatomic, strong) UIImageView *stockMarketIcon;

/// 股票代码
@property (nonatomic, strong) UILabel *stockCodeLab;

/// 最新价格
@property (nonatomic, strong) UILabel *latestPriceLab;

/// 涨跌幅
@property (nonatomic, strong) UILabel *quoteChangeLab;

@end

@implementation JMQuotationListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.backgroundColor;
        
        [self createUI];
    }
    return self;
}

#pragma mark -  创建UI

- (void)createUI {
    
    /// 市场icon
    [self.contentView addSubview:self.stockMarketIcon];
    [self.stockMarketIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).mas_offset(16);
        make.width.mas_offset(kWidthScale(16));
        make.height.mas_offset(kHeightScale(12));
    }];
    
    /// 股票名称
    [self.contentView addSubview:self.stockNameLab];
    [self.stockNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(11);
        make.left.equalTo(self.stockMarketIcon.mas_right).mas_offset(4);
        make.width.mas_lessThanOrEqualTo(kWidthScale(140));
    }];

    /// 股票代码
    [self.contentView addSubview:self.stockCodeLab];
    [self.stockCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stockNameLab.mas_bottom).mas_offset(5);
        make.left.equalTo(self.stockNameLab);
        make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-12);
    }];

    /// 涨跌幅
    [self.contentView addSubview:self.quoteChangeLab];
    [self.quoteChangeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).mas_offset(-16);
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(kWidthScale(72));
        make.height.mas_offset(kHeightScale(24));
    }];
    
    /// 最新价格
    [self.contentView addSubview:self.latestPriceLab];
    [self.latestPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.quoteChangeLab.mas_left).mas_offset(-9);
    }];
    
}

#pragma mark — Lazy

- (UILabel *)quoteChangeLab {
    if (!_quoteChangeLab) {
        _quoteChangeLab = [[UILabel alloc] init];
        _quoteChangeLab.text = @"0.00%";
        _quoteChangeLab.font = kFont_Regular(14.f);
//        _quoteChangeLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.f];
        _quoteChangeLab.textColor = [UIColor whiteColor];
        _quoteChangeLab.backgroundColor = UIColor.flatColor;
        // 设置圆角
        _quoteChangeLab.layer.cornerRadius = 4.f;
        _quoteChangeLab.layer.masksToBounds = YES;
        _quoteChangeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _quoteChangeLab;
}

- (UILabel *)latestPriceLab {
    if (!_latestPriceLab) {
        _latestPriceLab = [[UILabel alloc] init];
        _latestPriceLab.text = @"--";
        _latestPriceLab.font = kFont_Regular(16.f);
//        _latestPriceLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.f];
        _latestPriceLab.textColor = UIColor.primaryTextColor;
    }
    return _latestPriceLab;
}

- (UILabel *)stockCodeLab {
    if (!_stockCodeLab) {
        _stockCodeLab = [[UILabel alloc] init];
        _stockCodeLab.text = @"--";
        _stockCodeLab.font = kFont_Semibold(11.f);
//        _stockCodeLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:11.f];
        _stockCodeLab.textColor = UIColor.secondaryTextColor;
    }
    return _stockCodeLab;
}

- (UIImageView *)stockMarketIcon {
    if (!_stockMarketIcon) {
        _stockMarketIcon = [[UIImageView alloc] init];
        _stockMarketIcon.image = [UIImage imageNamed:@"stockMarketIcon_HK"];
    }
    return _stockMarketIcon;
}

- (UILabel *)stockNameLab {
    if (!_stockNameLab) {
        _stockNameLab = [[UILabel alloc] init];
        _stockNameLab.text = @"--";
        _stockNameLab.font = kFont_Regular(16.f);
//        _stockNameLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.f];
        _stockNameLab.textColor = UIColor.primaryTextColor;
    }
    return _stockNameLab;
}

#pragma mark -  数据重载

- (void)setQuotationListModel:(JMQuotationListModel *)quotationListModel {
    _quotationListModel = quotationListModel;
    
    //市场类型
    switch (quotationListModel.stockMarketType) {
        case StockMarketType_HK:{
            self.stockMarketIcon.image = [UIImage imageWithContentsOfFile:kImageNamed(@"stockMarketIcon_HK.png")];
        }
            break;
        case StockMarketType_US:{
            self.stockMarketIcon.image = [UIImage imageWithContentsOfFile:kImageNamed(@"stockMarketIcon_US.png")];
        }
            break;
        case StockMarketType_SH:{
            self.stockMarketIcon.image = [UIImage imageWithContentsOfFile:kImageNamed(@"stockMarketIcon_SH.png")];
        }
            break;
        case StockMarketType_SZ:{
            self.stockMarketIcon.image = [UIImage imageWithContentsOfFile:kImageNamed(@"stockMarketIcon_SZ.png")];
        }
            break;
        default:
            break;
    }
    
    // 股票名称
    self.stockNameLab.text = quotationListModel.stockName;
    // 股票代码
    self.stockCodeLab.text = quotationListModel.stockCode;
    // 最新价格
    self.latestPriceLab.text = quotationListModel.currentPrice;
    // 涨跌幅
    if ([quotationListModel.quoteChange floatValue]  == 0.00){
        self.quoteChangeLab.text = [NSString stringWithFormat:@"%@%%",quotationListModel.quoteChange];
        self.quoteChangeLab.backgroundColor = UIColor.flatColor;
    } else {
        if ([quotationListModel.quoteChange hasPrefix:@"-"]) {
            self.quoteChangeLab.text = [NSString stringWithFormat:@"%@%%",quotationListModel.quoteChange];
            self.quoteChangeLab.backgroundColor = UIColor.downColor;
        } else {
            self.quoteChangeLab.text = [NSString stringWithFormat:@"+%@%%",quotationListModel.quoteChange];
            self.quoteChangeLab.backgroundColor = UIColor.upColor;
        }
    }
    
}

@end
