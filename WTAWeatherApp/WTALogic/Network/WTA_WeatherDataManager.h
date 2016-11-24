//
//  WTA_WeatherDataManager.h
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTA_WeatherDataService.h"

typedef void(^WTA_WeatherDataSuccessBlock)(NSObject *object);
typedef void(^WTA_WeatherDataErrorBlock)(NSError *error);


@interface WTA_WeatherDataManager : NSObject <WTA_WeatherDataService>

@property (nonatomic, weak) id<WTA_WeatherDataServiceDelegate> delegate;

+ (WTA_WeatherDataManager*)sharedInstance;

- (void)getWeatherDataFromServer:(WTAWeatherDataType) dataType;
- (void)getWeatherDataFromLocal: (WTAWeatherDataType) dataType;

@end
