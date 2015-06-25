//
//  ViewController.m
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import "ViewController.h"
#import "FEHeaderMenu.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *titles = @[@"未读",@"已读",@"垃圾箱"];
    
    FEHeaderMenu *headMenu = [FEHeaderMenu menuWithTitleAtIndex:^NSString *(NSInteger index, BOOL *isStop) {
        if (index == titles.count-1) {
            *isStop = YES;
        }
        return titles[index];
        
    } clickAtIndex:^(NSInteger index, NSString *title) {
        [self reloadTableViewData:title];
    }];
    
    headMenu.frame = _menuView.bounds;
    [_menuView addSubview:headMenu];
    
    //
    [self reloadTableViewData:titles[headMenu.currentIndex]];
}

- (void)reloadTableViewData:(NSString *)string
{
    self.cellPrefixStr = string;
    [self.iTableView reloadData];
}

#pragma mark -
#pragma mark UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //
    [cell prepareForReuse];
    
    //
    cell.textLabel.text = [NSString stringWithFormat:@"[%@]菜单下的第%d个",self.cellPrefixStr,(int)indexPath.row];
    
    //
    return cell;
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
