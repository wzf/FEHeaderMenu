//
//  ViewController.m
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import "ViewController.h"
#import "FEHeaderMenu.h"

@interface ViewController()
@property (weak, nonatomic) FEHeaderMenu *headerMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *titles = @[@"未读",@"已读",@"垃圾箱",@"未读",@"已读",@"垃圾箱",@"未读",@"已读",@"垃圾箱",@"未读",@"已读",@"垃圾箱"];

    __weak typeof(self) weakSelf = self;
    // set appearnce color
    [[FEHeaderMenu appearance] setItemTitleNormalColor:[UIColor blueColor]];
    [[FEHeaderMenu appearance] setItemTitleSelectedColor:[UIColor redColor]];
    [[FEHeaderMenu appearance] setMarkViewColor:[UIColor greenColor]];
    [[FEHeaderMenu appearance] setWarningViewColor:[UIColor orangeColor]];
    
    // init
    FEHeaderMenu *headMenu = [FEHeaderMenu menuWithTitleAtIndex:^NSString *(NSInteger index, BOOL *isStop) {
        if (index == titles.count-1) {
            *isStop = YES;
        }
        return titles[index];
        
    } clickAtIndex:^(FEHeaderMenu *menu, NSInteger index, NSString *title) {
        [menu showWarning:NO AtIndex:index];
        [weakSelf reloadTableViewData:title];
    }];
    
    //不需要添加frame,FEHeaderMenu会根据edgeInsetsInSuperView增加constranits，通过autolayout方式完成布局
    [_menuView addSubview:headMenu];
    
    //
    [self reloadTableViewData:titles[headMenu.currentIndex]];
    
    self.headerMenu = headMenu;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_headerMenu showWarning:YES AtIndex:1];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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
