//
//  WTA_WeatherCurrentView.h
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/24.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTA_WeatherCurrentView : UIView

@property (nonatomic, copy) NSString *locationName;
@property (nonatomic, copy) NSString *condition;
@property (nonatomic, copy) NSString *temperatureStr;

@end
