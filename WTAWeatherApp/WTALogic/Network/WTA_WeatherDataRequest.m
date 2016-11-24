//
//  WTA_WeatherDataRequest.m
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import "WTA_WeatherDataRequest.h"
#import "WTA_WeatherDataService.h"

NSString * const kWTAOpenWeatherMapAPIURL = @"http://api.openweathermap.org/";
NSString * const kWTAOpenWeatherMapAPPID = @"946d2c63e2b8b51dfc76702bf894670d";
NSString * const kOpenWeatherMapCurrentURLStr = @"data/2.5/weather";
NSString * const kOpenWeatherMapForecastHourlyURLStr = @"data/2.5/forecast";
NSString * const kOpenWeatherMapForecastDailyURLStr = @"data/2.5/forecast/daily";

@interface WTA_WeatherDataRequest ()

@property (nonatomic, strong) NSString *urlStr;

@end

@implementation WTA_WeatherDataRequest
{
    NSString *_latStr;
    NSString *_lonStr;
}

+ (WTA_WeatherDataRequest *)createWeatherDataRequest:(WTAWeatherDataType)requestType
                                             withLat:(double) latitude
                                             andLong:(double) longitude
{
    NSString *classString;
    
    NSString *url;
    
    switch (requestType) {
        case WTAWeatherDataTypeCurrent:
        {
            classString = @"WTA_WeatherDataRequest";
            url = kOpenWeatherMapCurrentURLStr;
            break;
        }
        case WTAWeatherDataTypeForecastHourly:
        {
            classString = @"WTA_WeatherForecastRequest";
            url = kOpenWeatherMapForecastHourlyURLStr;
            break;
        }
        default:
            break;
    }
    if (!classString || classString.length == 0) {
        return nil;
    }
    Class class = NSClassFromString(classString);
    return [[class alloc] initRequestWithUrl:url
                                     withLat:latitude
                                     andLong:longitude];
}

- (instancetype) initRequestWithUrl:(NSString *)urlStr
                            withLat:(double) latitude
                            andLong:(double) longitude
{
    self = [super init];
    if (self) {
        _urlStr = urlStr;
        _latStr = [NSString stringWithFormat:@"%f", latitude];
        _lonStr = [NSString stringWithFormat:@"%f", longitude];
    }
    
    return self;
}

- (NSDictionary *)requestParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:_latStr forKey:@"lat"];
    [params setValue:_lonStr forKey:@"lon"];
    [params setValue:@"imperial" forKey:@"units"];
    [params setValue:kWTAOpenWeatherMapAPPID forKey:@"APPID"];
    
    return params;
}

- (NSString *)requestURL
{
    return _urlStr;
}

@end

@implementation WTA_WeatherForecastRequest

- (NSDictionary *)requestParams
{
    NSDictionary *dic = [super requestParams];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    if([self.urlStr isEqualToString:kOpenWeatherMapForecastHourlyURLStr]) {
        //24 hours
        [params setValue:@"8" forKey:@"cnt"];
    } else { // 7 days
        [params setValue:@"7" forKey:@"cnt"];
    }
    
    return params;
}

@end

