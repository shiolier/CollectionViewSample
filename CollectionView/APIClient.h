//
//  APIClient.h
//  Clipperd
//
//  Created by Takaaki Kakinuma on 2014/03/31.
//  Copyright (c) 2014年 Takaaki Kakinuma. All rights reserved.
//

#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"
#import "AFSecurityPolicy.h"
#import "AFNetworkReachabilityManager.h"
#import "AFURLConnectionOperation.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

#if ( ( defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090) || \
( defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 ) )
    #import "AFURLSessionManager.h"
    #import "AFHTTPSessionManager.h"
    #define AFNETWORKINGSUPERCLASS AFHTTPSessionManager
#else
    #define AFNETWORKINGSUPERCLASS AFHTTPRequestOperationManager
#endif

typedef NS_ENUM(NSInteger, METHOD) {
    GET,
    POST,
    PUT,
    DELETE,
};

typedef void (^UploadBlock)     (CGFloat progress);
typedef void (^DownloadBlock)   (CGFloat progress);
typedef void (^SuccessBlock)    (id response);
typedef void (^FailureBlock)    (NSError *error);

@interface APIClient : AFNETWORKINGSUPERCLASS

+ (void)asyncRequest:(METHOD)method path:(NSString *)path params:(NSDictionary *)params
              upload:(UploadBlock)uploadBlock
            download:(DownloadBlock)downloadBlock
             success:(SuccessBlock)successBlock
             failure:(FailureBlock)failureBlock;

+ (void)async0Request:(METHOD)method path:(NSString *)path params:(NSDictionary *)params
              upload:(UploadBlock)uploadBlock
            download:(DownloadBlock)downloadBlock
             success:(SuccessBlock)successBlock
             failure:(FailureBlock)failureBlock;




@end
