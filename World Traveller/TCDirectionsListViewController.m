//
//  TCDirectionsListViewController.m
//  World Traveller
//
//  Created by chenlihui on 14-4-9.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import "TCDirectionsListViewController.h"

@interface TCDirectionsListViewController ()

@end

@implementation TCDirectionsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MKRoute *route = self.steps[section];
    return [route.steps count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    MKRoute *route = self.steps[indexPath.section];
    MKRouteStep *step = route.steps[indexPath.row];
    cell.textLabel.text = step.instructions;
    cell.detailTextLabel.text = step.notice;
    
    [self loadSnapshots:indexPath];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont systemFontOfSize:14];
    label.text = [NSString stringWithFormat:@"Route %i", section +1];
    return label;
}

#pragma mark - Map Snapshots Helper
-(void)loadSnapshots:(NSIndexPath *)indexPath {
    MKRoute *route = self.steps[indexPath.section];
    MKRouteStep *step = route.steps[indexPath.row];
    
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc]init];
    options.scale = [UIScreen mainScreen].scale;
    MKMapRect rect;
    rect.origin = step.polyline.points[0];
    rect.size = MKMapSizeMake(0.0, 0.0);
    
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(rect);
    region.span.latitudeDelta = 0.001;
    region.span.longitudeDelta = 0.001;
    
    options.region = region;
    options.size = CGSizeMake(40.0, 40.0);
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc]initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.imageView.image = snapshot.image;
            [cell setNeedsLayout];
        }
    }];
}

@end
