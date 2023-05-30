//
//  JMMenuView.h
//  JMQuotesComponets_Example
//
//  Created by fargowealth on 2023/5/30.
//  Copyright © 2023 liyunlong1512. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//箭头在上或者下边的前中后位置枚举（从左到右）
typedef NS_ENUM(NSInteger, PopMenuArrowPosition) {
    PopMenuArrowTopHeader = 0,//默认从0开始
    PopMenuArrowTopCenter,
    PopMenuArrowTopfooter,
    PopMenuArrowBottomHeader,
    PopMenuArrowBottomCenter,
    PopMenuArrowBottomfooter,
};

@interface JMMenuView : UIView

//菜单蒙版的透明度 default bgViewAlpha = 0.2;设置alpha属性时会被bgAlpha接管
@property (nonatomic, assign)CGFloat bgAlpha;

//菜单背景色 default menuViewBgColor = [UIColor whiteColor];
@property (nonatomic, assign)UIColor *menuViewBgColor;

//菜单圆角 default menuRadius = 5.f;
@property (nonatomic, assign)CGFloat menuRadius;

//箭头宽度 default arrowWidth = 15.f;
@property (nonatomic, assign)CGFloat arrowWidth;

//箭头高度 default arrowHeight = 10.f;
@property (nonatomic, assign)CGFloat arrowHeight;

//菜单核心视图
@property (nonatomic, readonly)UITableView *menuView;

//cell高度 default cellHeight = 40.f;
@property (nonatomic, assign)CGFloat cellHeight;

@property (nonatomic, weak)id<UITableViewDataSource> dataSource;

@property (nonatomic, weak)id<UITableViewDelegate> delegate;

/**
 @param point 箭头箭尖的坐标
 @param size 菜单的视图的大小
 @param position 箭头的方位(同时决定缩放动画的锚点)
 */
- (instancetype)initWithArrow:(CGPoint)point menuSize:(CGSize)size arrowStyle:(PopMenuArrowPosition)position;

//显示 *属性设置需要在show之前*
- (void)showMenu:(BOOL)animated;

//关闭
- (void)closeMenu:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
