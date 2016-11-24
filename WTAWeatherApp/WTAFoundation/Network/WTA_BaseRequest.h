//
//  WTA_BaseRequest.h
//  WTAWeatherApp
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WTA_RequestMethod) {
    kWTA_RequestMethodPost = 0,
    kWTA_RequestMethodGet  = 1,
};

@interface WTA_BaseRequest : NSObject

@property (nonatomic, readonly, copy) NSString *apiHostHttp;

/*
 *  RequestURL
 *
 *  Discussion:
 *    You must implement the method in subclass to return the specified URL
 */
- (NSString *)requestURL;

/*
 *  RequestParams
 *
 *  Discussion:
 *    You should always call super requestParams before your subclass implementation to secure APP key are added in subclass params dictionary
 */
- (NSDictionary *)requestParams;

@end
