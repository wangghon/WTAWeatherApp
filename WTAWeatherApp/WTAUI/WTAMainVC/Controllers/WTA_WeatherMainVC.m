//
//  WTA_WeatherMainVC.m
//  WtaWeatherDemo
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import "WTA_WeatherMainVC.h"
#import "WTA_WeatherViewModel.h"
#import "WTA_WeatherDataService.h"
#import "WTA_WeatherDataManager.h"
#import "WTA_WeatherCurrentView.h"

@interface WTA_WeatherMainVC () <WTA_WeatherViewModelDelegate>

@property (nonatomic, strong) WTA_WeatherViewModel *viewModel;
@property (nonatomic, strong) WTA_WeatherCurrentView *currentView;

@end

@implementation WTA_WeatherMainVC

#pragma mark -- View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.currentView];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    [self.viewModel loadWeatherData:WTAWeatherTypeCurrent];
    //    [self.viewModel loadWeatherData:WTAWeatherTypeForecastHourly];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- WTA_WeatherViewModelDelegate

- (void)weather:(WTA_WeatherViewModel *)viewModel type:(WTAWeatherType)type didLoadData:(id)data
{
    if (data == nil) {
        return;
    }
    
    if (type == WTAWeatherTypeCurrent) {
        
        //update view data
        if ([data isKindOfClass:[WTA_BriefWeatherViewData class]]) {
            [self updateCurrentViewData:data];
        }
    }
}
- (void)weather:(WTA_WeatherViewModel *)viewModel type:(WTAWeatherType)type loadDataFailWithError:(NSError *)error;
{
    
}

#pragma mark -- Private Methods

- (void)updateCurrentViewData:(WTA_BriefWeatherViewData*) briefData
{
    if (!briefData) {
        return;
    }
    
    self.currentView.locationName = [briefData.locationName capitalizedString];
    self.currentView.condition = [briefData.condition  capitalizedString];
    self.currentView.temperatureStr = [NSString stringWithFormat:@"%.0f°",briefData.temperature.floatValue];
    
    [self.currentView setNeedsDisplay];
}

#pragma mark -- Setter and Getter

- (WTA_WeatherViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[WTA_WeatherViewModel alloc] initWithService:[WTA_WeatherDataManager sharedInstance]];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

- (WTA_WeatherCurrentView *)currentView
{
    if (!_currentView) {
        _currentView = [[WTA_WeatherCurrentView alloc] initWithFrame:self.view.bounds];
        _currentView.backgroundColor = [UIColor clearColor];
        
    }
    return _currentView;
}


@end
