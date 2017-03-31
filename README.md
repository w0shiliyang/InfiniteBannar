# InfiniteBannnar

InfiniteBannnar 是一个适用于 iOS 的轮播图，支持纯代码、xib/Storyboard,使用方便。

功能特性

- [x] 可开始、暂停轮播定时器
- [x] 纯代码、xib/Storyboard
- [x] 一个数据的时候显示一个 多个数据的时候可无限轮播，拓展性高。

##### 纯代码 

```objc
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
```

#####  Xib Or Storyboard

```objc
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
    //传递数据
    [_banarView setData:arr];
    //设置代理
    _banarView.delegate = self;
```

#####  点击回调
```objc
-(void)bannarClickWithIndex:(NSUInteger)index model:(id)model{
    NSLog(@"点击了第%ld个，数据是:%@",index,model);
}
```

### 图片效果演示

![图片效果演示](https://github.com/w0shiliyang/InfiniteBannar/blob/master/bannar%E6%88%AA%E5%9B%BE.gif)

# Contact me
- Weibo: [@李洋](http://weibo.com/3297900977)
- Email:  13363182679@163.com
- QQ：353368653

# 期待
- 如果在使用过程中遇到BUG，或发现功能不够用，希望你能Issues我
- 如果觉得好用请Star!
