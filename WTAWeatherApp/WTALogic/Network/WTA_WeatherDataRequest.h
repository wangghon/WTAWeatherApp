//
//  WTA_WeatherDataRequest.h
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import "WTA_BaseRequest.h"
#import "WTA_WeatherDataService.h"

extern NSString * const kWTAOpenWeatherMapAPIURL;

@interface WTA_WeatherDataRequest : WTA_BaseRequest

+ (WTA_WeatherDataRequest *)createWeatherDataRequest:(WTAWeatherDataType)requestType
                                             withLat:(double) latitude
                                             andLong:(double) longitude;

@end

@interface WTA_WeatherForecastRequest : WTA_WeatherDataRequest

@end
