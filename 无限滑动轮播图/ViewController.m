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
    
#pragma mark - xib创建
    //多个轮播
//    NSMutableArray * arr = [NSMutableArray new];
//    for (NSInteger i = 0; i < 11; i ++) {
//        LYBannarItemModel *model = [[LYBannarItemModel alloc] init];
//        model.imageName = [NSString stringWithFormat:@"%zd",i];
//        [arr addObject:model];
//    }
//    //单个不轮播
//    /*
//        LYBannarItemModel *model = [[LYBannarItemModel alloc] init];
//        model.imageName = [NSString stringWithFormat:@"1zd"];
//        [arr addObject:model];
//     */
//    //传递数据
//    [_banarView setData:arr];
//    //设置代理
//    _banarView.delegate = self;
    
    
#pragma mark - 纯代码创建
    self.banarView.hidden = YES;
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
    self.banarView = [[NSBundle mainBundle]loadNibNamed:@"LYBannarView" owner:nil options:nil].lastObject;
    self.banarView.frame = CGRectMake(0, 100, SCREEN_WIDTH, 200);
    [_banarView setData:arr];
    //传递数据
    _banarView.delegate = self;
    //设置代理
    [self.view addSubview:self.banarView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LYBannarDelegate

-(void)bannarClickWithIndex:(NSUInteger)index model:(id)model{
    NSLog(@"点击了第%ld个，数据是:%@",index,model);
}


@end
