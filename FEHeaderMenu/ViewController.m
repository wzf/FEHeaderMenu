//
//  ViewController.m
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import "ViewController.h"
#import "FEHeaderMenu.h"

@interface ViewController ()

@end

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
        NSLog(@"wzf= log [%s](%d) => %@",__func__,__LINE__,title);
    }];
    
    headMenu.frame = _menuView.bounds;
    [_menuView addSubview:headMenu];
}

@end
