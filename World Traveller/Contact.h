//
//  Contact.h
//  World Traveller
//
//  Created by chenlihui on 14-4-8.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TCRecord.h"

@class Venue;

@interface Contact : TCRecord

@property (nonatomic, retain) NSString * formattedPhone;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) Venue *venue;

@end
