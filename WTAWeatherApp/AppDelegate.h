//
//  AppDelegate.h
//  WTAWeatherApp
//
//  Created by wanghongbo on 16/11/24.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

