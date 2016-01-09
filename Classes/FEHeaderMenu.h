//
//  FEHeaderMenu.h
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEHeaderMenuItem.h"

@class FEHeaderMenu;

typedef NSString *(^titleAtIndex)(NSInteger index, BOOL *isStop);
typedef void      (^itemClickAtIndex)(FEHeaderMenu *menu, NSInteger index, NSString *title);

@interface FEHeaderMenu : UIView

@property (copy,   nonatomic) titleAtIndex     iTitleAtIndex; //获取title
@property (copy,   nonatomic) itemClickAtIndex iItemClickAtIndex; //点击item处理
@property (strong, nonatomic) NSMutableArray   *iTitles; //所有title的集合
//@property (assign, nonatomic) NSInteger        maxItemVisible; //能够显示的最大数量，默认值3；多于maxItemVisible的通过滑动显示
@property (assign, nonatomic) NSInteger  currentIndex; //当前选中的item位置
@property (assign, nonatomic) BOOL       didAddConstranit; //是否添加了constranit

@property (strong, nonatomic) UIColor *itemTitleNormalColor UI_APPEARANCE_SELECTOR; //普通状态的title color
@property (strong, nonatomic) UIColor *itemTitleSelectedColor UI_APPEARANCE_SELECTOR; //选中状态的title color
@property (strong, nonatomic) UIColor *markViewColor UI_APPEARANCE_SELECTOR; //
@property (strong, nonatomic) UIColor *warningViewColor UI_APPEARANCE_SELECTOR; //

/**
 * 初始化菜单界面
 * @param titleAtIndex index位置上显示的title
 * @param clickAtIndex 点击index位置上的item
 */
+ (instancetype)menuWithTitleAtIndex:(titleAtIndex)titleAtIndex clickAtIndex:(itemClickAtIndex)clickAtIndex;

/**
 * 重新布局
 */
- (void)reloadItems;

/**
 * 获取index位置上的title
 * @param index 位置
 */
- (NSString *)titleAtIndexPath:(NSInteger)index;


/**
 * 显示index位置的item
 * @param index 要显示的位置
 * @param animation 是否需要动画
 */
- (void)changeItemToIndex:(NSInteger)index animation:(BOOL)animation;

/**
 * 选中index位置上的item
 * @param index 要显示的位置
 * @param animation 是否需要动画
 */
- (void)selectItemAtIndex:(NSInteger)index animation:(BOOL)animation;

/**
 * 在父类中的UIEdgeInsets
 */
@property (assign, nonatomic) UIEdgeInsets edgeInsetsInSuperView; //


/**
 * 显示index位置的“警告view”
 */
@property (strong, nonatomic) NSMutableArray *warningItems; //
- (void)showWarning:(BOOL)showOrNot AtIndex:(NSInteger)index;

@end
