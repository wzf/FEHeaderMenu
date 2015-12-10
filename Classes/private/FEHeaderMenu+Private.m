//
//  FEHeaderMenu+Private.m
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import "FEHeaderMenu+Private.h"
#import <objc/runtime.h>

static const NSString *kICollectionKey = @"iCollection";
static const NSString *kIMarkViewKey   = @"iMarkView";
static const NSString *kMarkViewLayoutCenterKey  = @"markViewLayoutCenter";
static const NSString *kMarkViewLayoutWidthKey   = @"markViewLayoutWidth";
static const NSString *kFirstSelect   = @"firstSelect";

@implementation FEHeaderMenu (Private)
//@dynamic iCollectionView;


// 重新调整宽度
- (void)reloadItemsIfNeeds;
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 宽度、高度
    CGFloat horizonWidth   = self.iCollectionView.bounds.size.width;
    CGFloat verticalHeight = self.iCollectionView.bounds.size.height;
    
    // 最大显示数据为4个
    NSInteger maxItems  = (self.iTitles.count > 4) ? 4 : self.iTitles.count;
    CGFloat   itemWidth = horizonWidth/maxItems;
    
    // 确定layout
    layout.itemSize = CGSizeMake(itemWidth, verticalHeight);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing      = 0;
    layout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
    
    [self.iCollectionView setCollectionViewLayout:layout animated:NO];
    
    // 重新设置
    self.iMarkView.frame = CGRectMake( (self.currentIndex * itemWidth), verticalHeight-3, itemWidth, 3);
}

// 初始化menu、markView
- (void)setupItemsMenu;
{
    self.iCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(10, 10);
        layout;
    })];
    [self.iCollectionView setBackgroundColor:[UIColor clearColor]];
    [self.iCollectionView setDataSource:self];
    [self.iCollectionView setDelegate:self];
    [self.iCollectionView registerClass:[FEHeaderMenuItem class] forCellWithReuseIdentifier:@"cell"];
    [self.iCollectionView setShowsHorizontalScrollIndicator:NO];
    [self.iCollectionView setShowsVerticalScrollIndicator:NO];
//    [self.iCollectionView setPagingEnabled:YES];
    
    //
    [self addSubview:self.iCollectionView];
    
    // layout
    [self.iCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    UIView *consView = self.iCollectionView;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[consView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(consView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[consView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(consView)]];
    

    self.iMarkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 3)];
    [self.iMarkView setBackgroundColor:[FEHeaderMenu appearance].markViewColor];
    [self addSubview:self.iMarkView];
    [self sendSubviewToBack:self.iMarkView];
}

#pragma mark -
#pragma mark UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.iTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    FEHeaderMenuItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.titleLabel.text = self.iTitles[indexPath.item];
    
    [cell setSelected:(indexPath.item == self.currentIndex)];
    
    [cell setWarningHidden:![self.warningItems[indexPath.item] boolValue]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.firstSelect == NO) {
        self.firstSelect = YES;
        [[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]] setSelected:NO];
    }
    
    self.currentIndex = indexPath.item;
    
    if (self.iItemClickAtIndex) {
        self.iItemClickAtIndex(self, indexPath.item, self.iTitles[indexPath.item]);
    }
    
    [self changeItemToIndex:indexPath.item animation:YES];
}


#pragma mark -
#pragma mark Setter/getter

- (void)setICollectionView:(UICollectionView *)iCollectionView
{
    objc_setAssociatedObject(self, &kICollectionKey, iCollectionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UICollectionView *)iCollectionView
{
    return objc_getAssociatedObject(self, &kICollectionKey);
}

- (void)setIMarkView:(UIView *)iMarkView
{
    objc_setAssociatedObject(self, &kIMarkViewKey, iMarkView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)iMarkView
{
    return objc_getAssociatedObject(self, &kIMarkViewKey);
}

- (void)setFirstSelect:(BOOL)firstSelect
{
    objc_setAssociatedObject(self, &kFirstSelect, @(firstSelect), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)firstSelect
{
    return [objc_getAssociatedObject(self, &kFirstSelect) boolValue];
}
@end
