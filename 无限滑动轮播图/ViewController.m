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

@interface ViewController ()<LYBannarDelegate>
@property (weak, nonatomic) IBOutlet LYBannarView *banarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    NSMutableArray * arr = [NSMutableArray new];
    for (NSInteger i = 0; i < 11; i ++) {
        LYBannarItemModel *model = [[LYBannarItemModel alloc] init];
        model.imageName = [NSString stringWithFormat:@"%zd",i];
        model.titleName = [NSString stringWithFormat:@"原来第%zd张",i];
        [arr addObject:model];
    }
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
