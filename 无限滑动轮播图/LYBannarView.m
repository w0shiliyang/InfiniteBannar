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
#import "UIView+Ext.h"

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

#define kItemWidth ((SCREEN_WIDTH*0.8/1.45)+20)
//#define kPageCount (11)
#define kTime (8)
#define kTimerInterval (4)

static NSString *indentify = @"LYBannarCollectionViewCell";

@interface LYBannarView()<UICollectionViewDelegate,UICollectionViewDataSource,LYBannarCollectionViewFlowLayoutDelegate>
@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) BOOL canRemove;
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
    if (dataArray.count <= 0) {
        return;
    }
    _pageController.numberOfPages = self.pageCount;
    if (dataArray.count == 1) {
        _datas = _modelArray.mutableCopy;
    }else{
        _datas = [[NSMutableArray alloc] init];
        for (int j = 0; j < kTime; j++) {
            [_datas addObjectsFromArray:_modelArray];
        }
        self.currentIndex = (self.datas.count/(self.pageCount)/2)*self.pageCount;
        [self addtimer];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        });
    }
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
    CGFloat oneX = (SCREEN_WIDTH-kItemWidth)/2;
    flow.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
    self.flow = flow;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self UIInit];
}

-(void)UIInit{
    self.backgroundColor = [UIColor grayColor];
    [self.collectionView setCollectionViewLayout:self.flow];
    //增加滑动阻力
    _collectionView.decelerationRate = 20;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:indentify bundle:nil] forCellWithReuseIdentifier:indentify];
    
    _pageController.pageIndicatorTintColor = [UIColor grayColor];
    _pageController.currentPageIndicatorTintColor = [UIColor orangeColor];
}


-(void)addtimer
{
    if(self.timer) return;
    self.canRemove = YES;
    __weak typeof (self)weakself = self;
    self.timer = [NSTimer timerWithTimeInterval:kTimerInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (weakself.canRemove) {
            NSIndexPath * index =  [NSIndexPath indexPathForRow:self.currentIndex+1 inSection:0];
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode: NSRunLoopCommonModes];
}

#pragma CustomLayout的代理方法
- (void)collectioViewScrollToIndex:(NSInteger)index
{
    NSLog(@"第%ld个",index);
    self.currentIndex = index;
    NSInteger current = index % self.pageCount;
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
//    [cell.heroImageVIew sd_setImageWithURL:[NSURL URLWithString:model.imageName]];
    [cell.heroImageVIew setImage:[UIImage imageNamed:model.imageName]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = kItemWidth/2.14;
    return CGSizeMake(kItemWidth, height);
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
    self.canRemove = YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.canRemove = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayScrolling) object:nil];
    [self performSelector:@selector(delayScrolling) withObject:nil afterDelay:1];
    [self correctScroll];
}

//滑动减速是触发的代理，当用户用力滑动或者清扫时触发
CGFloat _offer;
//手动
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if(self.datas.count == 1) return;
    if (fabs(scrollView.contentOffset.x -_offer) > 10) {
        if (scrollView.contentOffset.x > _offer) {
            NSIndexPath * index =  [NSIndexPath indexPathForRow:self.currentIndex+1 inSection:0];
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }else{
            NSIndexPath * index =  [NSIndexPath indexPathForRow:self.currentIndex-1 inSection:0];
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

-(void)correctScroll{
    if ((self.currentIndex <= self.pageCount) || (self.currentIndex >= self.datas.count - self.pageCount)) {
        NSLog(@"改之前%ld",self.currentIndex);
        NSInteger currentPageIndex = self.currentIndex % self.pageCount;
        NSInteger terminal = (self.datas.count/(self.pageCount)/2)*self.pageCount+currentPageIndex;
        NSIndexPath * index =  [NSIndexPath indexPathForRow:terminal inSection:0];
        NSLog(@"改之后%ld",(self.datas.count/self.pageCount/2)*self.pageCount+currentPageIndex);
        self.currentIndex = terminal;
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

-(NSInteger)pageCount{
    return self.modelArray.count;
}

-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)startTimer{
    if (!self.timer) {
        if (_modelArray.count <= 0) {
            return;
        }
        [self addtimer];
    }
}
@end
