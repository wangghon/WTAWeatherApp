//
//  WTA_WeatherDataService.h
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#ifndef WTA_WeatherDataService_h
#define WTA_WeatherDataService_h

typedef NS_ENUM(NSUInteger, WTAWeatherDataType) {
    WTAWeatherDataTypeCurrent = 1,
    WTAWeatherDataTypeForecast24H,
    WTAWeatherDataTypeForecast5d,
    WTAWeatherDataTypeHistory
};

@protocol WTA_WeatherDataServiceDelegate;

@protocol WTA_WeatherDataService <NSObject>

- (void)getWeatherDataFromServer:(WTAWeatherDataType) dataType;
- (void)getWeatherDataFromLocal:(WTAWeatherDataType) dataType;

@property (nonatomic, weak) id <WTA_WeatherDataServiceDelegate> delegate;

@end

/**
 Delegate
 */
@protocol WTA_WeatherDataServiceDelegate <NSObject>

@optional
- (void)weatherManager:(id<WTA_WeatherDataService>)manager didParseWeatherData:(id)data;
- (void)weatherManager:(id<WTA_WeatherDataService>)manager didFailWithError:(NSError *)error;
@end

#endif /* WTA_WeatherDataService_h */
