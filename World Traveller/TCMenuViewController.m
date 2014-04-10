//
//  TCMenuViewController.m
//  World Traveller
//
//  Created by chenlihui on 14-4-10.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import "TCMenuViewController.h"
#import "TCListViewController.h"
#import "TCAppDelegate.h"

@interface TCMenuViewController ()

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) UINavigationController *listNavigationViewController;

@end

@implementation TCMenuViewController

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
    
    if (!self.viewControllers) {
        self.viewControllers = [[NSMutableArray alloc]initWithCapacity:3];
    }
    
}

-(void)viewDidAppear:(BOOL)animated {
    if (!self.listNavigationViewController){
        MMDrawerController *drawController = [self drawControllerFromAppDelegate];
        self.listNavigationViewController = (UINavigationController *)drawController.centerViewController;
        [self.viewControllers addObject:self.listNavigationViewController];
    }
    
    [self.tableView reloadData];  //重要 140410 clh
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
    return [self.viewControllers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row == 0){
        cell.textLabel.text = @"Home";
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MMDrawerController *drawerController = [self drawControllerFromAppDelegate];
    [drawerController setCenterViewController:self.viewControllers[indexPath.row] withCloseAnimation:YES completion:nil];
}


#pragma mark - DrawController Helper
-(MMDrawerController *)drawControllerFromAppDelegate {
    TCAppDelegate *appDelegate = (TCAppDelegate *)[[UIApplication sharedApplication]delegate];
    return appDelegate.drawerController;
}


@end
