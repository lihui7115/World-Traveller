//
//  TCViewController.m
//  World Traveller
//
//  Created by chenlihui on 14-4-8.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import "TCListViewController.h"
#import "TCFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializer.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "Venue.h"
#import "Location.h"

#import "TCMapViewController.h"



static NSString* const kCLIENTID = @"WH0TFP5N2SF4M2QQLGXZ5RFDUVG50HZFKW0EQCGEBVYBLNEE";

static NSString* const kCLIENTSECRET = @"LASOFUZQCPSMCY4FZAQZJEZZ0LETFKZYQXPHZHJ4FJWKU3O4";

#define latitudeOffset 0.00
#define longitudeOffset 0.00

//WH0TFP5N2SF4M2QQLGXZ5RFDUVG50HZFKW0EQCGEBVYBLNEE
//Client secret
//LASOFUZQCPSMCY4FZAQZJEZZ0LETFKZYQXPHZHJ4FJWKU3O4

@interface TCListViewController () <CLLocationManagerDelegate>      //@question clh

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation TCListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // location manager
    self.locationManager=[[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter=10.0;
    
    
    // get data
    TCFourSquareSessionManager *sessionManager = [TCFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper = [[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];

    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context
                                                                                       responseObjectSerializer:HTTPResponseSerializer
                                                                                                   entityMapper:mapper];
    sessionManager.responseSerializer = serializer;

    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)refreshBarItemButtonPressed:(UIBarButtonItem *)sender {
//    [[TCFourSquareSessionManager sharedClient] GET:@"venues/search?ll=30.25,-97.75"
//                                        parameters:@{@"client_id" : kCLIENTID, @"client_secret" : kCLIENTSECRET ,@"v": @"20140416"}
//                                           success:^(NSURLSessionDataTask *task, id responseObject) {
//                                               NSLog(@"%@",responseObject);
//                                               NSArray *venues = responseObject;
//                                               self.venues = venues;
//                                               [self.tableView reloadData];}
//                                           failure:^(NSURLSessionDataTask *task, NSError *error) { }
//     ];
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];

    [self.locationManager stopUpdatingLocation];
    [[TCFourSquareSessionManager sharedClient] GET:[NSString stringWithFormat:@"venues/search?ll=%f,%f",
                                                    location.coordinate.latitude+latitudeOffset, location.coordinate.longitude+longitudeOffset]
                                        parameters:@{@"client_id" : kCLIENTID, @"client_secret" : kCLIENTSECRET ,@"v": @"20140416"}
                                           success:^(NSURLSessionDataTask *task, id responseObject) {
                                               NSLog(@"%@",responseObject);
                                               NSArray *venues = responseObject;
                                               self.venues = venues;
                                               [self.tableView reloadData];}
                                           failure:^(NSURLSessionDataTask *task, NSError *error) { }
     ];
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.venues count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"listToMapSegue" sender:indexPath];
}

#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = sender;
    Venue *venue = self.venues[indexPath.row];
    TCMapViewController *mapVC = segue.destinationViewController;
    mapVC.venue = venue;
}

@end
