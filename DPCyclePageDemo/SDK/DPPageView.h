//
//  DPPageView.h
//  DPCyclePageDemo
//
//  Created by 朱力珅 on 2018/7/10.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, scorllType){
    DPScrollTypeNormal  =  0, //默认
    
    DPScrollTypeCard    =  1  //卡片式
};

typedef NS_ENUM(NSInteger, DPPageAlignment){
    DPPageAlignmentCenter  =  0,//默认
    
    DPPageAlignmentLeft    =  1,

    DPPageAlignmentRight   =  2
};

@interface DPPageView : UIView

//是否轮播
@property (nonatomic, readonly, assign) BOOL isCarousel;

//当前页码
@property (nonatomic, readonly, assign) NSInteger currentPage;

//页码数
@property (nonatomic, readonly, assign) NSInteger numberOfPages;

/**
 初始化方法
 @param array Uiimage数组
 @param type 类型
 */
- (id)initWithFrame:(CGRect)frame imageArray:(NSArray <UIImage *>*)array scrollType:(scorllType)type;

/**
 设置卡片式的背景颜色
 */
- (void)setCardBackgroundColor:(UIColor *)color;

/**
 设置是否隐藏圆点,默认不隐藏
 */
- (void)setHiddenPageContro:(BOOL)hiden;

/**
 设置未中圆点颜色,默认黑色
 */
- (void)setPageIndicatorTintColor:(UIColor *)color;

/**
 设置选中圆点颜色,默认红色
 */
- (void)setCurrentPageIndicatorTintColor:(UIColor *)color;

/**
 设置圆点位置

 @param alignment 枚举,默认中间
 */
- (void)setPageAlignment:(DPPageAlignment)alignment;


/**
 设置image上的文字
 @param textArray 字符数组,对应每个image
 */
- (void)setImageText:(NSArray <NSString *>*)textArray;

/**
 设置轮播时间,默认5.0s
 */
- (void)setTimeInterval:(NSTimeInterval)timeinterval;

/**
 开始轮播
 */
- (void)star;

/**
 暂停轮播
 */
- (void)stop;

/**
  滚动到指定页面,默认从0开始

 @param pageNumber 页码
 */
- (void)scrollToPage:(NSInteger)pageNumber;

@end
