//
//  TCMenuViewController.h
//  World Traveller
//
//  Created by chenlihui on 14-4-10.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
