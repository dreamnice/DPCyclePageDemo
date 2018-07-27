//
//  DPPageControl.m
//  DPCyclePageDemo
//
//  Created by 朱力珅 on 2018/7/11.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#define SWidth self.bounds.size.width
#define Sheight self.bounds.size.height
#define SBtnDstance 9
#define SBtnWithAndHeight 7

#import "DPPageControl.h"

@interface DPPageControl()

@property (nonatomic, assign) BOOL isSet;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) UIView *btnView;

@property (nonatomic, strong) NSMutableArray <UIButton *>* btnArray;

@end

@implementation DPPageControl

- (id)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        _pageIndicatorTintColor = [UIColor blackColor];
        _currentPageIndicatorTintColor = [UIColor redColor];
        _currentPage = 0;
        _numberOfPages = 0;
        _alignment = DPPrivatePageAlignmentCenter;
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
    
    //设置btn位置
    CGFloat BtnViewWidth = SBtnWithAndHeight * numberOfPages + SBtnDstance * (numberOfPages - 1);
    if(_alignment == DPPrivatePageAlignmentCenter){
        CGFloat BtnViewX = (SWidth - BtnViewWidth)/2.0;
        self.btnView.frame = CGRectMake(BtnViewX, 0, BtnViewWidth, Sheight);
    }else if(_alignment == DPPrivatePageAlignmentLeft){
        self.btnView.frame = CGRectMake(10, 0, BtnViewWidth, Sheight);
    }else{
        CGFloat BtnViewX = (SWidth - BtnViewWidth) - 10;
        self.btnView.frame = CGRectMake(BtnViewX, 0, BtnViewWidth, Sheight);
    }
    
    [self.btnArray removeAllObjects];
    //删除子控件
    [self.btnView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //添加点击按钮
    CGFloat BtnY = (Sheight - SBtnWithAndHeight)/2.0;
    CGFloat BtnX = 0;
    for(NSInteger i = 1; i <= numberOfPages; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(BtnX, BtnY, SBtnWithAndHeight, SBtnWithAndHeight);
        btn.layer.cornerRadius = SBtnWithAndHeight/2.0;
        btn.backgroundColor = [UIColor blackColor];
        btn.tag = i - 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnView addSubview:btn];
        [self.btnArray addObject:btn];
        BtnX = BtnX + SBtnDstance + SBtnWithAndHeight;
    }
    if(numberOfPages > 0){
        _selectBtn = self.btnArray[_currentPage];
        _selectBtn.backgroundColor = _currentPageIndicatorTintColor;
    }
}

//currentPage的set方法
- (void)setCurrentPage:(NSInteger)currentPage{
    if(currentPage >= _numberOfPages){
        NSLog(@"超过最大页数");
        return;
    }
    if(_currentPage == currentPage){
        return;
    }
    _currentPage = currentPage;
    _selectBtn.backgroundColor = _pageIndicatorTintColor;
    _selectBtn = _btnArray[_currentPage];
    _selectBtn.backgroundColor = _currentPageIndicatorTintColor;
}

//pageIndicatorTintColor的set方法
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    for (UIButton *btn in self.subviews){
        btn.backgroundColor = _pageIndicatorTintColor;
    }
    _selectBtn.backgroundColor = _currentPageIndicatorTintColor;
}

//currentPageIndicatorTintColor的set方法
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    _selectBtn.backgroundColor = _currentPageIndicatorTintColor;
}

//Alignment的set方法
- (void)setAlignment:(DPPrivatePageAlignment)alignment{
    if(_alignment == alignment){
        return;
    }
    _alignment = alignment;
    //设置btn位置
    CGFloat BtnViewWidth = SBtnWithAndHeight * _numberOfPages + SBtnDstance * (_numberOfPages - 1);
    if(_alignment == DPPrivatePageAlignmentCenter){
        CGFloat BtnViewX = (SWidth - BtnViewWidth)/2.0;
        self.btnView.frame = CGRectMake(BtnViewX, 0, BtnViewWidth, Sheight);
    }else if(_alignment == DPPrivatePageAlignmentLeft){
        self.btnView.frame = CGRectMake(10, 0, BtnViewWidth, Sheight);
    }else{
        CGFloat BtnViewX = (SWidth - BtnViewWidth) - 10;
        self.btnView.frame = CGRectMake(BtnViewX, 0, BtnViewWidth, Sheight);
    }
}

//代理方法
- (void)btnClick:(UIButton *)btn{
    if([self.delegate respondsToSelector:@selector(didClickAtPage:)]){
        [self.delegate didClickAtPage:btn.tag];
        self.currentPage = btn.tag;
    }
}

#pragma mark - 懒加载

- (NSMutableArray  <UIButton *>*)btnArray{
    if(!_btnArray){
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (UIView *)btnView{
    if(!_btnView){
        _btnView = [[UIView alloc] init];
        _btnView.backgroundColor = [UIColor clearColor];
        [self addSubview:_btnView];
    }
    return _btnView;
}

@end
