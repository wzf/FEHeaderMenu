//
//  FEHeaderMenuItem.m
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import "FEHeaderMenuItem.h"
#import "FEHeaderMenu.h"

@implementation FEHeaderMenuItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _loadSubviews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _loadSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _loadSubviews];
    }
    return self;
}

- (void)_loadSubviews
{
    /* -------------------- label -------------------- */
    self.titleLabel = [UILabel new];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font            = [UIFont systemFontOfSize:14];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor       = [UIColor blackColor];
    _titleLabel.highlightedTextColor = [FEHeaderMenu appearance].itemTitleSelectedColor;
    _titleLabel.textColor       = [FEHeaderMenu appearance].itemTitleNormalColor;//_itemTitleNormalColor ? _itemTitleNormalColor : [UIColor blackColor];
    _titleLabel.textAlignment   = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_titleLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_titleLabel]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:-2];
    [self.contentView addConstraint:centerY];
    
    
    /* -------------------- warning view -------------------- */
    self.warningView = [UIView new];
    _warningView.translatesAutoresizingMaskIntoConstraints = NO;
    _warningView.backgroundColor = [FEHeaderMenu appearance].warningViewColor;
    
    _warningView.layer.masksToBounds = YES;
    _warningView.layer.cornerRadius  = 3;
    
    _warningView.hidden = YES;
    
    [self.contentView addSubview:_warningView];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_warningView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:2];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_warningView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.contentView addConstraints:@[top,centerX]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_warningView(6)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_warningView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_warningView(6)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_warningView)]];
    
    
    /* -------------------- mark view -------------------- */
    self.markView = [UIView new];
    _markView.translatesAutoresizingMaskIntoConstraints = NO;
    _markView.backgroundColor = [FEHeaderMenu appearance].markViewColor;
    [self.contentView addSubview:_markView];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_markView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_markView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_markView(3)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_markView)]];
    
    
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [_titleLabel setHighlighted:selected];
    [_markView setHidden:!selected];
    [_markView setHidden:YES];
}


- (void)setWarningHidden:(BOOL)hidden;
{
    _warningView.hidden = hidden;
}

@end
