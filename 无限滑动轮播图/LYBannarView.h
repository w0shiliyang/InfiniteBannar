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
-(void)bannarClickWithIndex:(NSUInteger)index model:(id)model;

@end

@interface LYBannarView : UIView<XXNibBridge>
@property (weak,   nonatomic) id<LYBannarDelegate> delegate;
-(void)setData:(NSArray *)dataArray;
@end

/*
 
 for (NSInteger i = 0; i < _modelArray.count; i ++) {
 MKJItemModel *model = [[MKJItemModel alloc] init];
 model.imageName = [NSString stringWithFormat:@"%zd",i];
 model.titleName = [NSString stringWithFormat:@"原来第%zd张",i];
 [_datas addObject:model];
 }
 
 */
