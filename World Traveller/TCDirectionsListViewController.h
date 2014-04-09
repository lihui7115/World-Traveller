//
//  TCDirectionsListViewController.h
//  World Traveller
//
//  Created by chenlihui on 14-4-9.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface TCDirectionsListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *steps;

@end
