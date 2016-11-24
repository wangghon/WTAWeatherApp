//
//  WTA_LocationService.m
//  WTAWeatherApp
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import "WTA_LocationService.h"
#import <CoreLocation/CoreLocation.h>


NSString *const kWTALocationServiceErrorDomain = @"com.wtaweatherapp.location.errordomain";
#define kLocationUpdatingTimeout 10

@interface WTA_LocationService () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;;

@end

@implementation WTA_LocationService
{
    CLLocation *_location;
    BOOL _locationRequesting;
    BOOL _authRequesting;
    NSDate *_startTime;
    
    WTA_LocationRequestCompletionHandler _completeBlock;
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}


#pragma mark -- Public Methods

- (LocationServicesEnabledType)locationServicesEnabled
{
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        if (status == kCLAuthorizationStatusNotDetermined) {
            return kLocationServicesEnabledTypeNotDetermined;
        }else {
            if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
                return kLocationServicesEnabledTypeAllow;
            }else {
                return kLocationServicesEnabledTypeDeny;
            }
        }
    }else {
        return kLocationServicesEnabledTypeDeny;
    }
}
- (void)requestLocationAuthorization
{
    if (_authRequesting) {
        return;
    }
    
    _authRequesting = YES;
    
    if ([self.cllocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.cllocationManager requestWhenInUseAuthorization];
    }
    else {
        [self startLocationUpdating];
    }
}

- (void)getCurrentLocationWithBlock:(void (^)(CLLocation *location, BOOL success, NSError *error))completeBlock
{
    LocationServicesEnabledType lsEnableType = [self locationServicesEnabled];
    
    if (lsEnableType == kLocationServicesEnabledTypeDeny) {
        if (completeBlock) {
            
            NSError *error = [self getErrorInfoByType:kWTALocationServicesErrorTypeNoAuthority];
            
            completeBlock(nil, NO, error);
        }
        return;
    }
    
    if (lsEnableType == kLocationServicesEnabledTypeNotDetermined) {
        _completeBlock = completeBlock;
        [self requestLocationAuthorization];
        return;
    }
    
    if (_locationRequesting) {
        return;
    }
    
    _completeBlock = completeBlock;
    
    [self startLocationUpdating];
}

- (CLLocation *)getLastLocation
{
    return _location;
}

#pragma mark -- CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if ([CLLocationManager locationServicesEnabled]) {
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:
                _authRequesting = NO;
                [self requestLocationAuthorization];
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                [self startLocationUpdating];
                break;
            default:
                break;
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (![self canStopLocationUpdating:locations]) {
        return;
    }
    
    [self stopLocationUpdating];
    
    CLLocation *location = [locations lastObject];
    if (location) {
        NSLog(@"coordinate info: latitude ＝ %f, longitude = %f", location.coordinate.latitude, location.coordinate.longitude);
        
        _location = location;
        
        if (_completeBlock) {
            _completeBlock(location, YES, nil);
        }
    } else {
        if (_completeBlock) {

            NSError *error = [self getErrorInfoByType:kWTALocationServicesErrorTypeNoData];
            _completeBlock(nil, NO, error);
        }
    }
    
    _completeBlock = nil;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self stopLocationUpdating];
    
    if (_completeBlock) {
        _completeBlock(nil, NO, error);
        _completeBlock = nil;
    }
}

#pragma mark -- Private Methods

- (BOOL)canStopLocationUpdating:(NSArray *)locations
{
    if (!_startTime) {
        _startTime = [NSDate date];
        return NO;
    }
    
    CLLocation* loc = locations.lastObject;
    NSDate* time = loc.timestamp;
    
    NSTimeInterval elapsed = [time timeIntervalSinceDate:_startTime];
    if (elapsed > kLocationUpdatingTimeout) {
        _startTime = nil;
        return YES;
    }
    
    CLLocationAccuracy acc = loc.horizontalAccuracy;
    if (acc < 0 || acc > 100) {
        return NO;
    }
    
    _startTime = nil;
    return YES;
}

- (void)startLocationUpdating
{
    _locationRequesting = YES;
    
    [self.cllocationManager startUpdatingLocation];
}

- (void) stopLocationUpdating
{
    [self.cllocationManager stopUpdatingLocation];
    _locationManager.delegate = nil;
    _locationManager = nil;
    
    _locationRequesting = NO;
}

- (NSError *)getErrorInfoByType:(WTALocationServicesErrorType)errorType
{
    NSString *errorDesc = [self getErrorDescByType:errorType];
    
    NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(errorDesc, @"WTAWeatherApp", nil)};
    
    NSError *error = [[NSError alloc] initWithDomain:kWTALocationServiceErrorDomain code:errorType userInfo:userInfo];
    return error;
}

- (NSString *)getErrorDescByType:(WTALocationServicesErrorType)errorType
{
    NSString *errorDesc;
    
    switch (errorType) {
        case kWTALocationServicesErrorTypeNoAuthority:
            errorDesc = @"No uesr authority to locate the position";
            break;
        case kWTALocationServicesErrorTypeNoData:
            errorDesc = @"No available location data";
            break;
        case kWTALocationServicesErrorTypeFailure:
            errorDesc = @"fail to locate the position";
            break;
        default:
            break;
    }
    
    return errorDesc;
}

#pragma mark - Setter and Getter

- (CLLocationManager *)cllocationManager
{
    // WARNING: if no location feedback is recieved, please check if locationManager is not created on main Thread.
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    return _locationManager;
}


@end
