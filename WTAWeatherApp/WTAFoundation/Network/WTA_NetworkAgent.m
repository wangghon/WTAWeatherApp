//
//  WTA_NetworkAgent.m
//  WTAWeatherApp
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import "WTA_NetworkAgent.h"
#import "WTA_BaseRequest.h"
#import "AFNetworking.h"

NSString * const kWTAOpenWeatherMapAPI = @"http://api.openweathermap.org/";

@interface WTA_NetworkAgent ()

@property (nonatomic, strong) AFHTTPSessionManager* manager;

@end

@implementation WTA_NetworkAgent

//+ (WTA_NetworkAgent *)sharedNetworkAgent
//{
//    static WTA_NetworkAgent *_sharedInstance = nil;
//    static dispatch_once_t oncePredicate;
//    
//    dispatch_once(&oncePredicate, ^{
//        _sharedInstance = [[WTA_NetworkAgent alloc] init];
//    });
//    return _sharedInstance;
//}

- (id)initWithBaseURLStr:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURL *URL = [NSURL URLWithString:urlStr];
        
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL
                                            sessionConfiguration:configuration];
        
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (void)getDataWithRequest:(WTA_BaseRequest *)request
              successBlock:(WTA_NetworkAgentSuccessBlock)successBlock
              failureBlock:(WTA_NetworkAgentFailureBlock)failureBlock
{
    if (!request) {
        NSLog(@"No available request");
        return;
    }
    
    NSString *urlStr = [request requestURL];
    if (!urlStr || urlStr.length == 0) {
        NSLog(@"No available URI");
        return;
    }
    
    NSDictionary *params = [request requestParams];
    
    if (params.count == 0) {
        params = nil;
    }
    
    [_manager GET:urlStr
       parameters:params
         progress:nil
          success: ^(NSURLSessionDataTask *task, id responseObject) {
              
              if (responseObject && successBlock) {
                  successBlock(responseObject);
              }
              
          } failure: ^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"get data error, error is %@", error.description);
          }];
}

@end
