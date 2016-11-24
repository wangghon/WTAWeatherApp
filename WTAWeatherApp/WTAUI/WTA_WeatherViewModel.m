//
//  WTA_WeatherViewModel.m
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/23.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import "WTA_WeatherViewModel.h"
#import "WTA_WeatherDataService.h"
#import "WTA_CurrentModel.h"

@interface WTA_WeatherViewModel () <WTA_WeatherDataServiceDelegate>

@property (nonatomic, weak) id<WTA_WeatherDataService> weatherService;

@property (nonatomic, strong) WTA_BriefWeatherViewData *currentViewData;
@property (nonatomic, strong) NSArray<WTA_BriefWeatherViewData *> *forecast24HArray;

@end

@implementation WTA_WeatherViewModel

- (instancetype)initWithService:(id<WTA_WeatherDataService>)service
{
    if (!service) {
        NSLog(@"no data service at all");
        return nil;
    }
    
    self = [super init];
    
    if (self) {
        _weatherService = service;
        _weatherService.delegate = self;
        _currentViewData = [[WTA_BriefWeatherViewData alloc] init];
    }
    
    return self;
}

#pragma mark -- Public Methods

- (void)loadWeatherData:(WTAWeatherType)type
{
    [_weatherService getWeatherDataFromServer:(WTAWeatherDataType)type];
}

- (void)loadCurrentDetailData
{
    
}

#pragma mark -- WTA_WeatherDataServiceDelegate

- (void)weatherManager:(id<WTA_WeatherDataService>)manager
              dataType:(WTAWeatherDataType)dataType
   didParseWeatherData:(id)data
{
    if (data == nil) {
        return;
    }
    
    //TODO: translate the data to the structure of view display
    
    if (dataType == WTAWeatherDataTypeCurrent) {
        
        if ([data isKindOfClass:[WTA_CurrentModel class]]) {
            
            [self updateCurrentBriefViewData:data];
        }
        
        if ([self.delegate respondsToSelector:@selector(weather:type:didLoadData:)]) {
            [self.delegate weather:self type:(WTAWeatherType)dataType didLoadData:self.currentViewData];
        }
    } else if (dataType == WTAWeatherDataTypeForecastHourly) {
        
    }
    
}
- (void)weatherManager:(id<WTA_WeatherDataService>)manager
              dataType:(WTAWeatherDataType)dataType
      didFailWithError:(NSError *)error
{
    //TODO: call delegate method to notify the fail of data loading
}

#pragma mark -- Private Methods

- (void)updateCurrentBriefViewData:(WTA_CurrentModel *)current
{
    _currentViewData.date = current.date;
    _currentViewData.temperature = current.temperature;
    _currentViewData.tempLo = current.tempLow;
    _currentViewData.tempHi = current.tempHigh;
    _currentViewData.locationName = current.locationName;
    _currentViewData.condition = current.condition;
}

- (void)updateForecast24HViewData
{
    
}

@end

@implementation WTA_BriefWeatherViewData

@end
