//
//  JMPopMenuCell.m
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/30.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import "JMPopMenuCell.h"
#import "QuotationConstant.h"

@implementation JMPopMenuCell

#pragma mark — life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        
    }
    
    return self;
}

#pragma mark — UI

- (void)createUI {
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
}

#pragma mark — Lazy

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"60分";
        _titleLab.font = kFont_Regular(14.f);
        _titleLab.textColor = UIColor.handicapInfoTextColor;
    }
    return _titleLab;
}

@end
