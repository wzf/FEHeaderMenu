//
//  FEHeaderMenu+Private.h
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import "FEHeaderMenu.h"
#import "FEHeaderMenuItem.h"

@interface FEHeaderMenu (Private)<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *iCollectionView; //

/**
 * 设置itemsMenu
 */
- (void)setupItemsMenu;

/**
 * 重新调整宽度
 */
- (void)reloadItemsIfNeeds;


@property (strong, nonatomic) UIView *iMarkView; //
@end
