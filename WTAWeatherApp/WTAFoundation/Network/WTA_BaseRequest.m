//
//  WTA_BaseRequest.m
//  WTAWeatherApp
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import "WTA_BaseRequest.h"

@implementation WTA_BaseRequest

- (NSString *)requestURL
{
    @throw [NSException exceptionWithName:@"NoImplementationException"
                                   reason:@"You must implement the method in subclass"
                                 userInfo:nil];
}

- (NSDictionary *)requestParams
{    
    @throw [NSException exceptionWithName:@"NoImplementationException"
                                   reason:@"You must implement the method in subclass"
                                 userInfo:nil];
}

@end
