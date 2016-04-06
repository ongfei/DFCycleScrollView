//
//  DFCycleScrollView.h
//  DFCycleScrollView
//
//  Created by qqqq on 15/12/16.
//  Copyright © 2015年 董永飞. All rights reserved.
//

/**
 *
 *  网络请求 要往plist文件中写入http请求的代码
 *
 */



#import <UIKit/UIKit.h>

@interface DFCycleScrollView : UIView

/**
 *  @param frame       轮播图大小
 *  @param imagesGroup 图片数组
 *
 *  @return 轮播图view
 */
- (instancetype)initWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;
/**
 *  @param frame       轮播图大小
 *  @param imagesGroup 图片 URL 数组
 *
 *  @return 轮播图view
 */
- (instancetype)initWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup;
/**
 *  @param frame       轮播图大小
 *  @param imagesGroup 图片数组
 *
 *  @return 轮播图view
 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;
/**
 *  @param frame       轮播图大小
 *  @param imagesGroup 图片 URL 数组
 *
 *  @return 轮播图view
 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup;
@end
