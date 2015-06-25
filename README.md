# FEHeaderMenu
头部分组菜单，功能类似于UISegmentControl或者UITabBarController

![image](https://github.com/wzf/FEHeaderMenu/raw/master/ScreenShot/ScreenShot0.png)


用法：
    NSArray *titles = @[@"未读",@"已读",@"垃圾箱"];
    
    FEHeaderMenu *headMenu = [FEHeaderMenu menuWithTitleAtIndex:^NSString *(NSInteger index, BOOL *isStop) {
        if (index == titles.count-1) {
            *isStop = YES;
        }
        return titles[index];
        
    } clickAtIndex:^(NSInteger index, NSString *title) {
        [self reloadTableViewData:title];
    }];
    
说明：
  1. 菜单项小于4个的，全部展示，菜单不滚动。
  2. 菜单多余4个的，最多展示4个，超出部分依次往后排列，通过滑动展示。
  2. 标记红条，跟随menuItem滚动
