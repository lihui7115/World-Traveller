//
//  TCViewController.h
//  World Traveller
//
//  Created by chenlihui on 14-4-8.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)refreshBarItemButtonPressed:(UIBarButtonItem *)sender;

@end
