//
//  CeshiViewController.h
//  练习轮播图
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 liyang. All rights reserved.
//


#import "LYBannarItemModel.h"

@implementation LYBannarItemModel
-(NSString *)description{
    return [NSString stringWithFormat:@"图片是：%@",self.imageName];//图片是数字
}
@end
