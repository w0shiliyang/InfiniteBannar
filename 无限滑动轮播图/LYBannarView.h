//
//  LYBannarView.h
//  练习轮播图
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXNibBridge.h"

@protocol LYBannarDelegate <NSObject>

/**
 点击后的回调

 @param index 第几个
 @param model 数据回调
 */
-(void)bannarClickWithIndex:(NSUInteger)index model:(id)model;

@end

@interface LYBannarView : UIView<XXNibBridge>
@property (weak,   nonatomic) id<LYBannarDelegate> delegate;

/**
 传数据

 @param dataArray 数组里是字符串
 */
-(void)setData:(NSArray *)dataArray;

/**
 暂停自动轮播
 */
-(void)stopTimer;

/**
 开始自动轮播
 */
-(void)startTimer;
@end
