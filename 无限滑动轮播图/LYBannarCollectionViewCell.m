//
//  CeshiViewController.h
//  练习轮播图
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 liyang. All rights reserved.
//


#import "LYBannarCollectionViewCell.h"

@implementation LYBannarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.shadowOpacity = 0.75;
    self.backView.layer.shadowRadius = 2.5f;
    self.backView.layer.shadowOffset = CGSizeMake(2, 2);
    self.backView.layer.masksToBounds = YES;
}

@end
