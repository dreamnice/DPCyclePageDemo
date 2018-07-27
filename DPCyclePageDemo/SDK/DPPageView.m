//
//  DPPageView.m
//  DPCyclePageDemo
//
//  Created by 朱力珅 on 2018/7/10.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#define SWidth self.bounds.size.width
#define Sheight self.bounds.size.height
#define SCellWidthAndHeight 300

#import "DPPageView.h"
#import "DPPageCell.h"
#import "DPPageControl.h"
#import "DPCollectionFlowLayout.h"

@interface DPPageView()<UICollectionViewDelegate,UICollectionViewDataSource,DPPageControlDelegate>

@property (nonatomic, strong) UICollectionView *imageCollectionView;

@property (nonatomic, strong) DPPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray <UIImage *>*imageArray;

@property (nonatomic, strong) NSMutableArray <NSArray *>*imageTextArray;

@property (nonatomic, assign) NSTimeInterval timeinterval;

@property (nonatomic, assign) BOOL stared;

@property (nonatomic, strong) dispatch_source_t rollTimer;;

@property (nonatomic, assign) scorllType type;

@end

@implementation DPPageView

#pragma mark 获取属性接口

- (BOOL)isCarousel{
    return _stared;
}

- (NSInteger)currentPage{
    return _pageControl.currentPage;
}

- (NSInteger)numberOfPages{
    return _pageControl.numberOfPages;
}

#pragma mark - 接口

- (void)setCardBackgroundColor:(UIColor *)color{
    _imageCollectionView.backgroundColor = color;
}

//设置是否隐藏圆点
- (void)setHiddenPageContro:(BOOL)hiden{
    _pageControl.hidden = hiden;
}

//设置正常圆点颜色
- (void)setPageIndicatorTintColor:(UIColor *)color{
    _pageControl.pageIndicatorTintColor = color;
}

//设置当前圆点颜色
- (void)setCurrentPageIndicatorTintColor:(UIColor *)color{
    _pageControl.currentPageIndicatorTintColor = color;
}

//设置圆点位置
- (void)setPageAlignment:(DPPageAlignment)alignment{
    if(alignment == DPPageAlignmentCenter){
        _pageControl.alignment = DPPrivatePageAlignmentCenter;
    }else if(alignment == DPPageAlignmentLeft){
        _pageControl.alignment = DPPrivatePageAlignmentLeft;
    }else{
        _pageControl.alignment = DPPrivatePageAlignmentRight;
    }
}

- (void)setImageText:(NSArray<NSString *> *)textArray{
    _imageTextArray = [textArray mutableCopy];
    //[self.]
}

//设置轮播间隔
- (void)setTimeInterval:(NSTimeInterval)timeinterval{
    _timeinterval = timeinterval;
    if(_stared){
        [self stop];
        [self star];
    }
}

//开始轮播
- (void)star{
    if(!_stared && _imageArray.count > 1){
        [self setRollTimer];
        _stared = YES;
    }
}

//暂停轮播
- (void)stop{
    if(_stared){
//        dispatch_cancel(_rollTimer);
//        _rollTimer = nil;
        _stared = NO;
    }
}

//滚到指定页面
- (void)scrollToPage:(NSInteger)pageNumbe{
    if(pageNumbe < _pageControl.numberOfPages - 1){
        return;
    }
    [_imageCollectionView setContentOffset:CGPointMake((pageNumbe + 1) * SWidth, 0)];
    _pageControl.currentPage = pageNumbe;
}

#pragma mark - 初始化

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray <UIImage *>*)array scrollType:(scorllType)type{
    self = [super initWithFrame:frame];
    if(self){
        _imageArray = [array mutableCopy];
        _type = type;
        if(array.count > 1){
//            [_imageArray addObject:[array firstObject]];
//            [_imageArray insertObject:[array lastObject] atIndex:0];
        }
        [self setView];
    }
  
    return self;
}

#pragma mark -

- (void)setView{
    [self addSubview:self.imageCollectionView];
    self.pageControl.numberOfPages = _imageArray.count;
    [self addSubview:self.pageControl];
    [_imageCollectionView setContentOffset:CGPointMake(SWidth, 0)];
    _timeinterval = 5.0;
}

//设置自动轮播GCD定时器
- (void)setRollTimer{
//    if(!_rollTimer){
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        _rollTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_timeinterval * NSEC_PER_SEC));
//        dispatch_source_set_timer(_rollTimer, start , _timeinterval * NSEC_PER_SEC, 0);
//        __weak __typeof(self)weakSelf = self;
//        dispatch_source_set_event_handler(_rollTimer, ^{
//            NSLog(@"滚动一次");
//            [weakSelf pageChange];
//        });
//        dispatch_resume(_rollTimer);
//    }
    [self performSelector:@selector(pageChange) withObject:nil afterDelay:_timeinterval];
    //代码简单
    /* [self performSelector:@selector(pageChange) withObject:nil afterDelay:3] */
}

- (void)pageChange{
    
    //判断是否停止
//    __weak __typeof(self)weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
        //判断最后一张还是第一张
//    if(self.pageControl.currentPage == self.pageControl.numberOfPages - 1){
//        [self.imageCollectionView setContentOffset:CGPointMake(0, 0) animated:NO];
//        [self.imageCollectionView setContentOffset:CGPointMake(SWidth, 0) animated:YES];
//        self.pageControl.currentPage = 0;
//    }else{
//        [self.imageCollectionView setContentOffset:CGPointMake((self.pageControl.currentPage + 2) * SWidth, 0) animated:YES];
//        self.pageControl.currentPage += 1;
//    }
//    });
    NSLog(@"1");
    if(_stared){
        [self performSelector:@selector(pageChange) withObject:nil afterDelay:_timeinterval];
    }
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    //判断滚动结束后第几张
    if(targetContentOffset -> x >= (_imageArray.count + 1) * SWidth){
        _pageControl.currentPage = 0;
    }else if(targetContentOffset -> x < SWidth){
        _pageControl.currentPage = _imageArray.count - 1;
    }else{
        _pageControl.currentPage = targetContentOffset -> x / SWidth - 1;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);
    //判断是否是最后一张或第一张
    if(scrollView.contentOffset.x >= (_imageArray.count + 1) * SWidth){
        [scrollView setContentOffset:CGPointMake(SWidth, 0) animated:NO];
    }else if(scrollView.contentOffset.x < SWidth){
        [scrollView setContentOffset:CGPointMake(_imageArray.count * SWidth, 0) animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(_imageArray.count == 1){
        return 1;
    }
    return _imageArray.count + 2;
}

//直接返回image
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DPPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if(indexPath.row == _imageArray.count + 1){
        [cell.imageView setImage:_imageArray[0]];
    }else if(indexPath.row == 0){
        [cell.imageView setImage:_imageArray[_imageArray.count - 1]];
    }else{
        [cell.imageView setImage:_imageArray[indexPath.row - 1]];
    }
    cell.wordlabel.text = @"23";
    return cell;
}

#pragma mark - DPPageControlDelegate

- (void)didClickAtPage:(NSInteger)page{
    [_imageCollectionView setContentOffset:CGPointMake((page + 1) * SWidth, 0) animated:NO];
}

#pragma mark - 懒加载

- (UICollectionView *)imageCollectionView{
    if(!_imageCollectionView){
        UICollectionViewFlowLayout *layout;
        if(_type == DPScrollTypeCard){
            layout = [[DPCollectionFlowLayout alloc] init];
        }else{
            layout = [[UICollectionViewFlowLayout alloc] init];
        }
        layout.minimumLineSpacing = 0;
        layout.itemSize = self.bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _imageCollectionView.dataSource = self;
        _imageCollectionView.delegate = self;
        _imageCollectionView.pagingEnabled = YES;
        _imageCollectionView.bounces = NO;
        _imageCollectionView.showsHorizontalScrollIndicator = NO;
        [_imageCollectionView registerClass:[DPPageCell class] forCellWithReuseIdentifier:@"cellID"];
    }
    return _imageCollectionView;
}

- (DPPageControl *)pageControl{
    if(!_pageControl){
        _pageControl = [[DPPageControl alloc] initWithFrame:CGRectMake(0, Sheight - 15, SWidth, 10)];
        _pageControl.pageIndicatorTintColor = [UIColor blackColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.delegate = self;
    }
    return _pageControl;
}

#pragma mark - delloc

//销毁定时器
- (void)dealloc{
//    if(_stared){
//        dispatch_cancel(_rollTimer);
//        _rollTimer = nil;
//    }
}
@end
