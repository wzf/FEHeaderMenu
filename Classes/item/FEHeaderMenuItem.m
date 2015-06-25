//
//  FEHeaderMenuItem.m
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import "FEHeaderMenuItem.h"

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
    self.titleLabel = [UILabel new];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font            = [UIFont systemFontOfSize:14];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor       = [UIColor blackColor];
    _titleLabel.highlightedTextColor = [UIColor redColor];
    _titleLabel.textAlignment   = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_titleLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_titleLabel]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_titleLabel]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    
    
    self.markView = [UIView new];
    _markView.translatesAutoresizingMaskIntoConstraints = NO;
    _markView.backgroundColor = [UIColor redColor];
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

@end
