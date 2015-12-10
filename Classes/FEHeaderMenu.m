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
        self.edgeInsetsInSuperView = UIEdgeInsetsMake(0, 0, 0, 0);
        self.warningItems       = [NSMutableArray array];
        
        if ([FEHeaderMenu appearance].itemTitleNormalColor == nil) {
            [FEHeaderMenu appearance].itemTitleNormalColor = [UIColor blackColor];
        }
        
        if ([FEHeaderMenu appearance].itemTitleSelectedColor == nil) {
            [FEHeaderMenu appearance].itemTitleSelectedColor = [UIColor redColor];
        }
        
        if ([FEHeaderMenu appearance].markViewColor == nil) {
            [FEHeaderMenu appearance].markViewColor = [UIColor redColor];
        }
        
        if ([FEHeaderMenu appearance].warningViewColor == nil) {
            [FEHeaderMenu appearance].warningViewColor = [UIColor redColor];
        }
        
    }
    return self;
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"FEHeaderMenu dealloc");
#endif
    [self.iMarkView removeFromSuperview];
    [self setIMarkView:nil];
    
    [self.iCollectionView removeFromSuperview];
    [self setICollectionView:nil];

    self.iTitleAtIndex     = nil;
    self.iItemClickAtIndex = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 定位选中的item
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:_currentIndex inSection:0];
    UICollectionViewLayoutAttributes *attr = [self.iCollectionView layoutAttributesForItemAtIndexPath:currentIndexPath];
    
    // 转移坐标
    CGPoint point = [self convertPoint:attr.center fromView:self.iCollectionView];
    
    // 移动
    self.iMarkView.center = CGPointMake(point.x, self.iMarkView.center.y);
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    // 避免显示“半个item”的情况
    CGFloat offsetX   = scrollView.contentOffset.x;
    CGFloat itemWidth = [self.iCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]].size.width;
    //
    if (itemWidth) {
        // index
        NSInteger index = (int)offsetX/itemWidth;
        //
        CGFloat itemOffset = (int)offsetX % (int)itemWidth;
        if (itemOffset <= itemWidth/2.0) {
            [scrollView setContentOffset:CGPointMake(index*itemWidth, 0)  animated:YES];
        }
        else {
            [scrollView setContentOffset:CGPointMake((index+1)*itemWidth, 0)  animated:YES];
        }
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if (!_didAddConstranit) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *paddings = @{@"left"  : @(_edgeInsetsInSuperView.left),
                                   @"right" : @(_edgeInsetsInSuperView.right),
                                   @"top"   : @(_edgeInsetsInSuperView.top),
                                   @"bottom": @(_edgeInsetsInSuperView.bottom)};
        UIView *selfView = self;
        [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-left-[selfView]-right-|" options:0 metrics:paddings views:NSDictionaryOfVariableBindings(selfView)]];
        [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[selfView]-bottom-|" options:0 metrics:paddings views:NSDictionaryOfVariableBindings(selfView)]];
        
        _didAddConstranit = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self reloadItemsIfNeeds];
}

#pragma mark -
#pragma mark private method
- (void)_doInitailization
{
    // 初始化title
    [self _setupTitles:_iTitleAtIndex];
    
    // 初始化collectionView
    [self setupItemsMenu];
}

- (void)_setupTitles:(titleAtIndex)titleAtIndex
{
    // 是否停止
    BOOL isStop = NO;
    
    [_iTitles      removeAllObjects];
    [_warningItems removeAllObjects];
    
    while (isStop != YES) {
        NSString *title = titleAtIndex(_iTitles.count, &isStop);
        if (title != nil) {
            [_iTitles      addObject:title];
            [_warningItems addObject:@(NO)];
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

// 显示index位置的“警告view”
- (void)showWarning:(BOOL)showOrNot AtIndex:(NSInteger)index;
{
    if (self.warningItems.count > index) {
        [self.warningItems setObject:@(showOrNot) atIndexedSubscript:index];
        FEHeaderMenuItem *item = (FEHeaderMenuItem *)[self.iCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [item setWarningHidden:!showOrNot];
    }
}

@end
