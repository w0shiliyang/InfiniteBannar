//
//  CeshiViewController.m
//  练习轮播图
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "ViewController.h"
#import "LYBannarView.h"
#import "LYBannarItemModel.h"
#import "LYConstant.h"

@interface ViewController ()<LYBannarDelegate>
@property (weak, nonatomic) IBOutlet LYBannarView *banarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(97, 183, 247, 1);
    //多个轮播
    NSMutableArray * arr = [NSMutableArray new];
    for (NSInteger i = 0; i < 11; i ++) {
        LYBannarItemModel *model = [[LYBannarItemModel alloc] init];
        model.imageName = [NSString stringWithFormat:@"%zd",i];
        [arr addObject:model];
    }
    //单个不轮播
    /*
        LYBannarItemModel *model = [[LYBannarItemModel alloc] init];
        model.imageName = [NSString stringWithFormat:@"1zd"];
        [arr addObject:model];
     */
    [_banarView setData:arr];
    _banarView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)bannarClickWithIndex:(NSUInteger)index model:(id)model{
    NSLog(@"点击了第%ld个，数据是:%@",index,model);
}


@end
