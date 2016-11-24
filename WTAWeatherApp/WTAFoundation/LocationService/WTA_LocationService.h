//
//  WTA_LocationService.h
//  WTAWeatherApp
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, LocationServicesEnabledType) {
    kLocationServicesEnabledTypeDeny          = 0,
    kLocationServicesEnabledTypeAllow         = 1,
    kLocationServicesEnabledTypeNotDetermined = 2,
};

typedef NS_ENUM(NSInteger, WTALocationServicesErrorType) {
    kWTALocationServicesErrorTypeNone          = 0,
    kWTALocationServicesErrorTypeNoAuthority   = -1001,
    kWTALocationServicesErrorTypeFailure       = -1002,
    kWTALocationServicesErrorTypeNoData        = -1003,
};

extern NSString *const kWTALocationServiceErrorDomain;

@class CLLocation;

typedef void (^WTA_LocationRequestCompletionHandler) (CLLocation *location, BOOL success, NSError *error);

@interface WTA_LocationService : NSObject

- (void)getCurrentLocationWithBlock:(WTA_LocationRequestCompletionHandler)completeBlock;

- (CLLocation *)getLastLocation;

@end
