//
//  WTA_NetworkAgent.h
//  WTAWeatherApp
//
//  Created by wanghongbo on 16/11/22.
//  Copyright © 2016年 wanghongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTA_BaseRequest;

typedef void (^WTA_NetworkAgentSuccessBlock)(id responseObject);
typedef void (^WTA_NetworkAgentFailureBlock)(NSError *error);

@interface WTA_NetworkAgent : NSObject

- (id)initWithBaseURLStr:(NSString *)urlStr;

- (void)getDataWithRequest:(WTA_BaseRequest *)request
              successBlock:(WTA_NetworkAgentSuccessBlock)successBlock
              failureBlock:(WTA_NetworkAgentFailureBlock)failureBlock;

@end
