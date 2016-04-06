//
//  DFCycleScrollView.m
//  DFCycleScrollView
//
//  Created by qqqq on 15/12/16.
//  Copyright © 2015年 董永飞. All rights reserved.
//

#import "DFCycleScrollView.h"

@interface DFCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *sourceArr;
@end
@implementation DFCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup {
    self = [super initWithFrame:frame];
    if (self) {
        self.sourceArr = [NSMutableArray arrayWithArray:imagesGroup];
        [self.sourceArr insertObject:[imagesGroup lastObject] atIndex:0];
        [self.sourceArr addObject:[imagesGroup firstObject]];
        
        [self subViewScrollView];
        [self subViewPageControl];
    }
    return self;
}
- (void)subViewScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.sourceArr.count, self.frame.size.height);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);

    for (int i = 0; i < self.sourceArr.count; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        imageV.image = self.sourceArr[i];
        [self.scrollView addSubview:imageV];
    }
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    [self subViewsTime];
}
- (void)subViewsTime {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
//    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)scroll {
    
    CGFloat width = self.frame.size.width;
    NSInteger index = self.pageControl.currentPage;
    index ++;
    [self.scrollView setContentOffset:CGPointMake((index + 1) * width, 0) animated:YES];
}
- (void)subViewPageControl {
    UIPageControl *pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.frame) + 20, CGRectGetMaxY(self.frame) - 20, CGRectGetWidth(self.frame) - 40, 30)];
    pageC.numberOfPages = self.sourceArr.count - 2;
    pageC.currentPage = 0;
//    这里可以修改pageControl的选中和未选中的颜色
    pageC.currentPageIndicatorTintColor = [UIColor blueColor];
    pageC.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl = pageC;
    [self addSubview:pageC];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    结束计时
    [self.timer invalidate];
    self.timer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    开始计时
    [self subViewsTime];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.x < self.frame.size.width) {
        self.scrollView.contentOffset = CGPointMake((self.sourceArr.count - 2) * self.frame.size.width, 0);
    }
    if (offset.x > (self.sourceArr.count - 2) * self.frame.size.width) {
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    self.pageControl.currentPage = scrollView.contentOffset.x/self.bounds.size.width - 1;
}

- (instancetype)initWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup {
    self = [super initWithFrame:frame];
    if (self) {
        self.sourceArr = [NSMutableArray array];
        
        for (NSString *strUrl in imageURLStringsGroup) {
            [self requestDataWithUrl:strUrl blockHandle:^(UIImage *image) {
                if (image == nil) {
                    return;
                }
                if (self.sourceArr.count != 0) {
                    [self releaseSubViews];
                }
                [self.sourceArr addObject:image];
                [self.sourceArr insertObject:[self.sourceArr lastObject] atIndex:0];
                [self.sourceArr addObject:[self.sourceArr objectAtIndex:1]];
                
                [self subViewScrollView];
                [self subViewPageControl];
            }];
        }
    }
    return self;
}
- (void)requestDataWithUrl:(NSString *)strUrl blockHandle:(void(^)(UIImage *image))handle {
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:strUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            handle(image);
        });
    }];
    [dataTask resume];
}
- (void)releaseSubViews {
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
    [self.pageControl removeFromSuperview];
    self.pageControl = nil;
    [self.timer invalidate];
    self.timer = nil;
    [self.sourceArr removeObjectAtIndex:0];
    [self.sourceArr removeLastObject];
}
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup {
    DFCycleScrollView *cycleS = [[self alloc] initWithFrame:frame imagesGroup:imagesGroup];
    return cycleS;
}
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup {
    DFCycleScrollView *cycleS = [[self alloc] initWithFrame:frame imageURLStringsGroup:imageURLStringsGroup];
    return cycleS;
}
@end
