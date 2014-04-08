//
//  Venue.m
//  World Traveller
//
//  Created by chenlihui on 14-4-8.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"
#import "Location.h"
#import "Menu.h"


@implementation Venue

@dynamic id;
@dynamic name;
@dynamic categories;
@dynamic contact;
@dynamic location;
@dynamic menu;

+ (NSString *)keyPathForResponseObject {
    return @"response.venues";
}

@end
