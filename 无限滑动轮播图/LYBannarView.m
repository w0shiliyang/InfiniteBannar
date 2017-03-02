//
//  LYBannarView.m
//  练习轮播图
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "LYBannarView.h"
#import "LYBannarCollectionViewFlowLayout.h"
#import "LYBannarItemModel.h"
#import "LYBannarCollectionViewCell.h"
#import "UIView+Extension.h"

#define kItemWidth ((SCREEN_WIDTH*0.8/1.45)+20)
#define kPageCount (11)
#define kTimerInterval (4)

static NSString *indentify = @"LYBannarCollectionViewCell";

@interface LYBannarView()<UICollectionViewDelegate,UICollectionViewDataSource,LYBannarCollectionViewFlowLayoutDelegate>{
    NSInteger currentIndex;
    BOOL canRemove;
}
//原本数据
@property (strong, nonatomic) NSMutableArray *modelArray;
@property (strong, nonatomic) NSTimer *timer;
//scroll数据
@property (nonatomic,strong) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (strong, nonatomic) LYBannarCollectionViewFlowLayout *flow;
@end

@implementation LYBannarView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self dataInit];
    }
    return self;
}

-(void)setData:(NSArray *)dataArray{
    _modelArray = dataArray.mutableCopy;
    _datas = [[NSMutableArray alloc] init];
    for (int j = 0; j < 4; j++) {
        [_datas addObjectsFromArray:_modelArray];
    }
    currentIndex = (self.datas.count/(kPageCount)/2)*kPageCount;

    dispatch_async(dispatch_get_main_queue(), ^{
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    });
    
    [self addtimer];
}

-(void)dataInit
{
    LYBannarCollectionViewFlowLayout *flow = [[LYBannarCollectionViewFlowLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat height = kItemWidth/2.14;
    flow.itemSize = CGSizeMake(kItemWidth, height);
    flow.minimumLineSpacing = 28;
    flow.minimumInteritemSpacing = 28;
    flow.needAlpha = YES;
    flow.delegate = self;
    CGFloat oneX =self.width / 4;
    flow.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
    self.flow = flow;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self UIInit];
}

-(void)UIInit{
    self.backgroundColor = [UIColor blackColor];
    [self.collectionView setCollectionViewLayout:self.flow];
    //增加滑动阻力
    _collectionView.decelerationRate = 20;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:indentify bundle:nil] forCellWithReuseIdentifier:indentify];
    
    _pageController.numberOfPages = kPageCount;
    _pageController.pageIndicatorTintColor = [UIColor grayColor];
    _pageController.currentPageIndicatorTintColor = [UIColor orangeColor];
}


-(void)addtimer
{
    if(self.timer) return;
    canRemove = YES;
    self.timer = [NSTimer timerWithTimeInterval:kTimerInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (canRemove) {
            NSIndexPath * index =  [NSIndexPath indexPathForRow:currentIndex+1 inSection:0];
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode: NSDefaultRunLoopMode];
}

#pragma CustomLayout的代理方法
- (void)collectioViewScrollToIndex:(NSInteger)index
{
    NSLog(@"第%ld个",index);
    currentIndex = index;
    int current = index%kPageCount;
    self.pageController.currentPage = (NSUInteger)current;
}

#pragma makr - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYBannarItemModel *model = self.datas[indexPath.item];
    LYBannarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    cell.heroImageVIew.image = [UIImage imageNamed:model.imageName];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[LYBannarCollectionViewFlowLayout class]]) {
        CGPoint pInUnderView = [self convertPoint:collectionView.center toView:collectionView];
        
        // 获取中间的indexpath
        NSIndexPath *indexpathNew = [collectionView indexPathForItemAtPoint:pInUnderView];
        
        if (indexPath.row == indexpathNew.row)
        {
            if ([self.delegate respondsToSelector:@selector(bannarClickWithIndex:model:)]) {
                [self.delegate bannarClickWithIndex:indexPath.row model:self.datas[indexPath.row]];
            }
            return;
        }
        else
        {
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}
-(void)delayScrolling{
    canRemove = YES;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    canRemove = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayScrolling) object:nil];
    [self performSelector:@selector(delayScrolling) withObject:nil afterDelay:1];
    [self correctScroll];
}

//滑动减速是触发的代理，当用户用力滑动或者清扫时触发
CGFloat _offer;
//手动
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (fabs(scrollView.contentOffset.x -_offer) > 10) {
        if (scrollView.contentOffset.x > _offer) {
            NSIndexPath * index =  [NSIndexPath indexPathForRow:currentIndex+1 inSection:0];
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }else{
            NSIndexPath * index =  [NSIndexPath indexPathForRow:currentIndex-1 inSection:0];
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

//////用户拖拽是调用
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    if (fabs(scrollView.contentOffset.x -_offer) > 20) {
//        if (scrollView.contentOffset.x > _offer) {
//            NSIndexPath * index =  [NSIndexPath indexPathForRow:currentIndex+1 inSection:0];
//            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//        }else{
//            NSIndexPath * index =  [NSIndexPath indexPathForRow:currentIndex-1 inSection:0];
//            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//        }
//    }
//}

-(void)correctScroll{
    if ((currentIndex < kPageCount ) || (currentIndex > self.datas.count - kPageCount)) {
        NSLog(@"改之前%ld",currentIndex);
        NSInteger currentPageIndex = currentIndex % kPageCount;
        NSInteger terminal = (self.datas.count/(kPageCount)/2)*kPageCount+currentPageIndex;
        NSIndexPath * index =  [NSIndexPath indexPathForRow:terminal inSection:0];
        NSLog(@"改之后%ld",(self.datas.count/kPageCount/2)*kPageCount+currentPageIndex);
        currentIndex = terminal;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            _offer = _collectionView.contentOffset.x;
        });
    }
}

//定时器
//系统动画停止是刷新当前偏移量_offer是我定义的全局变量
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _offer = scrollView.contentOffset.x;
    [self correctScroll];
}

-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
@end
