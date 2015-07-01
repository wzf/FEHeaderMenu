//
//  ViewController.h
//  FEHeaderMenu
//
//  Created by wangzhanfeng-PC on 15/6/25.
//  Copyright (c) 2015年 F.E. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *menuView; //
@property (weak, nonatomic) IBOutlet UITableView *iTableView; //
@property (copy, nonatomic) NSString *cellPrefixStr; //
@end

