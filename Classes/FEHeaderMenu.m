//
//  FEHeaderMenu.m
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import "FEHeaderMenu.h"
#import "FEHeaderMenu+Private.h"

@implementation FEHeaderMenu

#pragma mark -
#pragma mark lifeCircle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iTitles = [NSMutableArray arrayWithCapacity:3];    //title数组
        self.currentIndex       = 0;    //默认显示
    }
    return self;
}

- (void)dealloc
{
    [self.iCollectionView removeObserver:self forKeyPath:@"contentOffset"];
    
    [self.iCollectionView removeFromSuperview];
    [self setICollectionView:nil];
    
    [self.iMarkView removeFromSuperview];
    [self setIMarkView:nil];
    
    
    self.iTitleAtIndex     = nil;
    self.iItemClickAtIndex = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];    
    [self reloadItemsIfNeeds];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.iCollectionView && [keyPath isEqualToString:@"contentOffset"]) {
        // 定位选中的item
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:_currentIndex inSection:0];
        UICollectionViewLayoutAttributes *attr = [self.iCollectionView layoutAttributesForItemAtIndexPath:currentIndexPath];
        
        // 转移坐标
        CGPoint point = [self convertPoint:attr.center fromView:self.iCollectionView];
        
        // 移动
        self.iMarkView.center = CGPointMake(point.x, self.iMarkView.center.y);
    }
}

#pragma mark -
#pragma mark private method
- (void)_doInitailization
{
    // 初始化title
    [self _setupTitles:_iTitleAtIndex];
    
    // 初始化collectionView
    [self setupItemsMenu];
    
    //
    [self.iCollectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

}

- (void)_setupTitles:(titleAtIndex)titleAtIndex
{
    // 是否停止
    BOOL isStop = NO;
    
    [_iTitles removeAllObjects];
    while (isStop != YES) {
        NSString *title = titleAtIndex(_iTitles.count, &isStop);
        if (title != nil) {
            [_iTitles addObject:title];
        }
    }
}


#pragma mark -
#pragma mark public method
// 初始化菜单界面
+ (instancetype)menuWithTitleAtIndex:(titleAtIndex)titleAtIndex clickAtIndex:(itemClickAtIndex)clickAtIndex;
{
    FEHeaderMenu *menu = [[FEHeaderMenu alloc] init];
    
    // 记录值
    menu.iTitleAtIndex     = titleAtIndex;
    menu.iItemClickAtIndex = clickAtIndex;
    
    // 初始化
    [menu _doInitailization];
    
    return menu;
}

- (void)reloadItems
{
    [self _doInitailization];
    [self reloadItemsIfNeeds];
}

// 获取index位置上的title
- (NSString *)titleAtIndexPath:(NSInteger)index;
{
    return _iTitles[index];
}


// 显示index位置的item
- (void)changeItemToIndex:(NSInteger)index animation:(BOOL)animation;
{
    UICollectionViewLayoutAttributes *attr = [self.iCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    CGPoint point = [self convertPoint:attr.center fromView:self.iCollectionView];
    
    [UIView animateWithDuration:(animation ? 0.1 : 0) animations:^{
        self.iMarkView.center = CGPointMake(point.x, self.iMarkView.center.y);
    }];
}

@end
