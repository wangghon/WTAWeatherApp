//
//  WTA_WeatherDataManager.m
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import "WTA_WeatherDataManager.h"
#import "WTA_WeatherDataRequest.h"
#import "WTA_NetworkAgent.h"
#import "WTA_CurrentModel.h"
#import "WTA_LocationService.h"
#import <CoreLocation/CoreLocation.h>

@interface WTA_WeatherDataManager ()
{
    WTA_LocationService *_locationService;
    WTA_NetworkAgent    *_networkAgent;
}
@end

@implementation WTA_WeatherDataManager

+ (WTA_WeatherDataManager*)sharedInstance
{
    static WTA_WeatherDataManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[WTA_WeatherDataManager alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationService = [[WTA_LocationService alloc] init];
        _networkAgent = [[WTA_NetworkAgent alloc] initWithBaseURLStr:kWTAOpenWeatherMapAPIURL];
    }
    return self;
}

- (void)getWeatherDataFromServer:(WTAWeatherDataType) dataType
{
    __block __weak typeof(self) blockSelf = self;
    
    [_locationService getCurrentLocationWithBlock:^(CLLocation *location, BOOL success, NSError *error) {
        
        CLLocation *currentLocation = location;
        if (!success) {
            NSLog(@"Fail to request current location info");
            currentLocation = [_locationService getLastLocation];
        }
        if (currentLocation == nil) {
            NSLog(@"no available location info at all");
            return;
        }
        
        double lat = currentLocation.coordinate.latitude;
        double lon = currentLocation.coordinate.longitude;
        
        WTA_WeatherDataRequest *request = [WTA_WeatherDataRequest createWeatherDataRequest:dataType
                                                                                   withLat:lat
                                                                                   andLong:lon];
        
        if (!request) {
            NSLog(@"Could not create data request based on datatype = %d", (int)dataType);
            return;
        }
        
        [blockSelf getWeatherData:request
                     SuccessBlock:^(id responseObject) {
                         
                         NSDictionary *dic = (NSDictionary *)responseObject;
                         
                         Class class = NSClassFromString([blockSelf getModelClassString:dataType]);
                         
                         NSError *error = nil;
                         id model = [MTLJSONAdapter modelOfClass:class
                                              fromJSONDictionary:dic
                                                           error:&error];
                         
                         if (model == nil) {
                             return;
                         }
                         
                         if ([blockSelf.delegate respondsToSelector:@selector(weatherManager:dataType:didParseWeatherData:)]) {
                             [blockSelf.delegate weatherManager:blockSelf dataType:dataType didParseWeatherData:model];
                         }
                     }
                       ErrorBlock:^(NSError *error) {
                           if([blockSelf.delegate respondsToSelector:@selector(weatherManager:dataType:didFailWithError:)]) {
                               [blockSelf.delegate weatherManager:blockSelf dataType:dataType didFailWithError:error];
                           }
                       }];
    }];
}

- (void)getWeatherDataFromLocal: (WTAWeatherDataType) dataType
{
    //TODO: get data from Local
}

-(void)getWeatherData:(WTA_WeatherDataRequest *)dataReqeust
         SuccessBlock:(WTA_WeatherDataSuccessBlock)successBlock
           ErrorBlock:(WTA_WeatherDataErrorBlock)errorBlock
{
    if (!dataReqeust) {
        NSLog(@"No data request");
        return;
    }
    
    [_networkAgent getDataWithRequest:dataReqeust successBlock:^(id responseObject) {
        if (!responseObject || ![responseObject isKindOfClass:[NSDictionary class]]) {
            if (errorBlock) {
                errorBlock(nil);
            }
            return;
        }
                                                     
        if (successBlock) {
            successBlock(responseObject);
        }
    } failureBlock:^(NSError *error) {
        if(errorBlock) {
            errorBlock(error);
        }
     
    }];
}

#pragma mark -- Private Methods
- (NSString *)getModelClassString:(WTAWeatherDataType)modelType
{
    NSString *classStr;
    switch (modelType) {
        case WTAWeatherDataTypeCurrent:
            classStr = @"WTA_CurrentModel";
            break;
            
        default:
            break;
    }
    return classStr;
}

@end
