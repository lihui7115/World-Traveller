//
//  Menu.h
//  World Traveller
//
//  Created by chenlihui on 14-4-8.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TCRecord.h"

@class Venue;

@interface Menu : TCRecord

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Venue *venue;

@end
