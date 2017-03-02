//
//  CeshiViewController.h
//  练习轮播图
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 liyang. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol LYBannarCollectionViewFlowLayoutDelegate <NSObject>

- (void)collectioViewScrollToIndex:(NSInteger)index;

@end

@interface LYBannarCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) id<LYBannarCollectionViewFlowLayoutDelegate>delegate;

@property (nonatomic,assign) BOOL needAlpha;

@end
