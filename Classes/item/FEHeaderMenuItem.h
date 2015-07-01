//
//  FEHeaderMenuItem.h
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FEHeaderMenuItem : UICollectionViewCell

@property (strong, nonatomic) UILabel *titleLabel; //
@property (strong, nonatomic) UIView  *markView; //
@property (strong, nonatomic) UIView  *warningView; //提示


- (void)setWarningHidden:(BOOL)hidden;
///**
// * 实例化
// * @param title 显示的标题
// */
//+ (instancetype)itemWithTitle:(NSString *)title;

@end
