//
//  TCFourSquareSessionManager.m
//  World Traveller
//
//  Created by chenlihui on 14-4-8.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import "TCFourSquareSessionManager.h"

static NSString * const TCFoursquareBaseURLString = @"https://api.foursquare.com/v2/";

@implementation TCFourSquareSessionManager

+ (instancetype)sharedClient {
    static TCFourSquareSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TCFourSquareSessionManager alloc] initWithBaseURL:[NSURL URLWithString:TCFoursquareBaseURLString]];
    });
    return _sharedClient;
}
@end
