### 图片效果演示

![图片效果演示](https://github.com/w0shiliyang/InfiniteBannar/blob/master/bannar%E6%88%AA%E5%9B%BE.png)

##### 纯代码 usage

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

#####  Xib Or Storyboard  usage

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

# 期待
- 如果在使用过程中遇到BUG，或发现功能不够用，希望你能Issues我,或者微博联系我：[@李洋](http://weibo.com/3297900977)
- 如果觉得好用请Star!
