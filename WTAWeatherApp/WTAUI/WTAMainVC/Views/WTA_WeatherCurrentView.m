//
//  WTA_WeatherCurrentView.m
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/24.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import "WTA_WeatherCurrentView.h"
#import "WTA_UIKit.h"

@interface WTA_WeatherCurrentView ()

@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *conditionLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *tempHiLabel;
@property (nonatomic, strong) UILabel *tempLoLabel;

@end

@implementation WTA_WeatherCurrentView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupSubViews];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat y = 100.0;
    CGFloat width = self.bounds.size.width;
    
    self.locationLabel.frame = CGRectMake(0, y, width, DuNativeResourceHeight(40));
    
    y = CGRectGetMaxY(self.locationLabel.frame) + DuNativeResourceHeight(40);
    self.conditionLabel.frame = CGRectMake(0, y, width, DuNativeResourceHeight(20));
    
    y = CGRectGetMaxY(self.conditionLabel.frame) + DuNativeResourceHeight(40);
    self.temperatureLabel.frame = CGRectMake(0, y, width, DuNativeResourceHeight(50));
}

#pragma mark -- Private Methods

- (void)setupSubViews
{
    [self addSubview:self.locationLabel];
    [self addSubview:self.conditionLabel];
    [self addSubview:self.temperatureLabel];
    [self addSubview:self.dateLabel];
}


#pragma mark -- Setters and Getters

- (void)setLocationName:(NSString *)locationName
{
    self.locationLabel.text = locationName;
}

- (void)setCondition:(NSString *)condition
{
    self.conditionLabel.text = condition;
}

- (void)setTemperatureStr:(NSString *)temperatureStr
{
    self.temperatureLabel.text = temperatureStr;
}

- (void)setTempLoStr:(NSString *)tempLoStr
{
    self.tempLoLabel.text = tempLoStr;
}

- (void)setTempHiStr:(NSString *)tempHiStr
{
    self.tempHiLabel.text = tempHiStr;
}

- (void)setDateStr:(NSString *)dateStr
{
    self.dateLabel.text = dateStr;
}

- (UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.backgroundColor = [UIColor clearColor];
        _locationLabel.font = UINativeFontOfSize(22.0);
        _locationLabel.textColor = [UIColor whiteColor];
        _locationLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _locationLabel;
}

- (UILabel *)conditionLabel
{
    if (!_conditionLabel) {
        _conditionLabel = [[UILabel alloc] init];
        _conditionLabel.backgroundColor = [UIColor clearColor];
        _conditionLabel.font = UINativeFontOfSize(15.0);
        _conditionLabel.textColor = [UIColor whiteColor];
        _conditionLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _conditionLabel;
}

- (UILabel *)temperatureLabel
{
    if (!_temperatureLabel) {
        _temperatureLabel = [[UILabel alloc] init];
        _temperatureLabel.backgroundColor = [UIColor clearColor];
        _temperatureLabel.font = UINativeFontOfSize(30.0);
        _temperatureLabel.textColor = [UIColor whiteColor];
        _temperatureLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _temperatureLabel;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.font = UINativeFontOfSize(15.0);
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _dateLabel;
}

@end
