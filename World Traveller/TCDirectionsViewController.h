//
//  TCDirectionsViewController.h
//  World Traveller
//
//  Created by chenlihui on 14-4-9.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Venue.h"
#import "Location.h"
@import MapKit;

@interface TCDirectionsViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *directionsMap;
@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *steps;

- (IBAction)listDirectionsBarItemButtonPressed:(UIBarButtonItem *)sender;
@end
