//
//  TCMapViewController.h
//  World Traveller
//
//  Created by chenlihui on 14-4-8.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
#import "Venue.h"

@interface TCMapViewController : UIViewController

@property (strong, nonatomic) Venue *venue;
//IBOutlets
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

- (IBAction)showDirectionsBarItemButtonPressed:(UIBarButtonItem *)sender;
@end
