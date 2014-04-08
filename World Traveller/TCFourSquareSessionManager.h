//
//  TCFourSquareSessionManager.h
//  World Traveller
//
//  Created by chenlihui on 14-4-8.
//  Copyright (c) 2014年 Future Game. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface TCFourSquareSessionManager : AFHTTPSessionManager

+ (instancetype)sharedClient;
@end
