//
//  WTA_WeatherViewModel.h
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/23.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WTAWeatherType) {
    WTAWeatherTypeCurrent = 1,
    WTAWeatherTypeForecastHourly,
    WTAWeatherTypeForecastDaily,
};


@protocol WTA_WeatherDataService;
@protocol WTA_WeatherViewModelDelegate;

@interface WTA_WeatherViewModel : NSObject

@property (nonatomic, weak) id<WTA_WeatherViewModelDelegate> delegate;

- (instancetype)initWithService:(id<WTA_WeatherDataService>) service;

- (void)loadWeatherData:(WTAWeatherType)type;

@end


/**
 Delegate
 */
@protocol WTA_WeatherViewModelDelegate <NSObject>

@optional
- (void)weather:(WTA_WeatherViewModel *)viewModel type:(WTAWeatherType)type didLoadData:(id)data;
- (void)weather:(WTA_WeatherViewModel *)manager type:(WTAWeatherType)type loadDataFailWithError:(NSError *)error;
@end


@interface WTA_BriefWeatherViewData : NSObject

@property (nonatomic, copy)NSDate *date;
@property (nonatomic, copy)NSString *locationName;
@property (nonatomic, copy)NSString *condition;
@property (nonatomic, strong)NSNumber *temperature;
@property (nonatomic, strong)NSNumber *tempHi;
@property (nonatomic, strong)NSNumber *tempLo;
    

@end
