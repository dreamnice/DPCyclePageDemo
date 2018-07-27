//
//  DPPageControl.h
//  DPCyclePageDemo
//
//  Created by 朱力珅 on 2018/7/11.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DPPrivatePageAlignment){
    DPPrivatePageAlignmentCenter  =  0,//默认
    
    DPPrivatePageAlignmentLeft    =  1,
    
    DPPrivatePageAlignmentRight   =  2
};

@protocol DPPageControlDelegate<NSObject>

- (void)didClickAtPage:(NSInteger)page;

@end

@interface DPPageControl : UIView

@property (nonatomic, assign) NSInteger numberOfPages;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, assign) DPPrivatePageAlignment alignment;

@property (nonatomic, weak) id <DPPageControlDelegate>delegate;

@end
