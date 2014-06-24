//
//  APIClient.m
//  Clipperd
//
//  Created by Takaaki Kakinuma on 2014/03/31.
//  Copyright (c) 2014年 Takaaki Kakinuma. All rights reserved.
//

#import "APIClient.h"

// #define BASE_URL @"http://dev.imakuru.axis-motion.co.jp/api/"
#define BASE_URL @"http://www.panoramio.com/map/"

@interface APIClient ()

@property (nonatomic, copy) UploadBlock     uploadBlock;
@property (nonatomic, copy) DownloadBlock   downloadBlock;
@property (nonatomic, copy) SuccessBlock    successBlock;
@property (nonatomic, copy) FailureBlock    failureBlock;

@end

@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    return _sharedClient;
}

#pragma mark -
+ (void)asyncRequest:(METHOD)method path:(NSString *)path params:(NSDictionary *)params
              upload:(UploadBlock)uploadBlock
            download:(DownloadBlock)downloadBlock
             success:(SuccessBlock)successBlock
             failure:(FailureBlock)failureBlock {
    NSLog(@"params : %@",params);
    NSArray *items = [self expandDictionary:params];
    NSLog(@"items : %@",items);
    __block BOOL isFormData = NO;
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIImage class]]) {
            isFormData = YES;
            *stop = YES;
        }
    }];

    NSURLRequest *request;
    NSError *error = nil;
    APIClient *client = [APIClient sharedClient];
    AFHTTPRequestSerializer *requestSerializer = [client requestSerializer];
    if (isFormData) {
        __block NSString *formKey;
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            formKey = key;
        }];
        request = [requestSerializer multipartFormRequestWithMethod:[client method:method]
                                                          URLString:[client urlString:path]
                                                         parameters:params
                                          constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                              [client formData:formData withParams:params
                                                       withKey:formKey withParentKey:nil prevArray:NO];
                                          } error:&error];
    } else {
        request = [requestSerializer requestWithMethod:[client method:method]
                                             URLString:[client urlString:path]
                                            parameters:params
                                                 error:&error];
    }
    if (error) {
        if (failureBlock) failureBlock(error);
        return;
    }
    client.uploadBlock      = uploadBlock;
    client.downloadBlock    = downloadBlock;
    client.successBlock     = successBlock;
    client.failureBlock     = failureBlock;
    [client requestOperation:request];
}

+ (void)async0Request:(METHOD)method path:(NSString *)path params:(NSDictionary *)params
              upload:(UploadBlock)uploadBlock
            download:(DownloadBlock)downloadBlock
             success:(SuccessBlock)successBlock
             failure:(FailureBlock)failureBlock {
    NSArray *items = [self expandDictionary:params];
    __block BOOL isFormData = NO;
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIImage class]]) {
            isFormData = YES;
            *stop = YES;
        }
    }];
    isFormData = YES;
    
    NSURLRequest *request;
    NSError *error = nil;
    APIClient *client = [APIClient sharedClient];
    AFHTTPRequestSerializer *requestSerializer = [client requestSerializer];
    if (isFormData) {
        __block NSString *formKey;
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            formKey = key;
        }];
        request = [requestSerializer multipartFormRequestWithMethod:[client method:method]
                                                          URLString:[client urlString:path]
                                                         parameters:nil
                                          constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                              [client formData:formData withParams:params
                                                       withKey:formKey withParentKey:nil prevArray:NO];
                                          } error:&error];
    } else {
        request = [requestSerializer requestWithMethod:[client method:method]
                                             URLString:[client urlString:path]
                                            parameters:params
                                                 error:&error];
    }
    if (error) {
        if (failureBlock) failureBlock(error);
        return;
    }
    client.uploadBlock      = uploadBlock;
    client.downloadBlock    = downloadBlock;
    client.successBlock     = successBlock;
    client.failureBlock     = failureBlock;
    [client requestOperation:request];
}

- (void)requestOperation:(NSURLRequest *)request {
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progress = (CGFloat)totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
        if (self.uploadBlock) { self.uploadBlock(progress); }
    }];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        CGFloat progress = (CGFloat)totalBytesRead/(CGFloat)totalBytesExpectedToRead;
        if (self.downloadBlock) { self.downloadBlock(progress); }
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        application.networkActivityIndicatorVisible = NO;
        if (self.successBlock) { self.successBlock(responseObject); }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        application.networkActivityIndicatorVisible = NO;
        if (self.failureBlock) { self.failureBlock(error); }
    }];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue addOperation:operation];
}

#pragma mark -
- (NSString *)method:(METHOD)method {
    NSString *methodString = nil;
    switch (method) {
        case GET:    { methodString = @"GET";    } break;
        case POST:   { methodString = @"POST";   } break;
        case PUT:    { methodString = @"PUT";    } break;
        case DELETE: { methodString = @"DELETE"; } break;
    }
    return methodString;
}

#pragma mark -
- (NSString *)urlString:(NSString *)path {
    return ((NSURL *)[NSURL URLWithString:path relativeToURL:[NSURL URLWithString:BASE_URL]]).absoluteString;
}

#pragma mark -
+ (NSArray *)expandDictionary:(NSDictionary *)dictionary {
    NSMutableArray *output = @[].mutableCopy;
    [self expandDictionary:dictionary into:output];
    return output;
}

+ (void)expandDictionary:(NSDictionary *)dict into:(NSMutableArray *)output {
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self parseObj:obj into:output];
    }];
}

+ (void)expandArray:(NSArray *)ary into:(NSMutableArray *)output {
   [ary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       [self parseObj:obj into:output];
   }];
}

+ (void)parseObj:(id)obj into:(NSMutableArray *)output {
    if ([obj isKindOfClass:[NSDictionary class]]) {
        [self expandDictionary:obj into:output];
    } else if ([obj isKindOfClass:[NSArray class]]) {
        [self expandArray:obj into:output];
    } else {
        [output addObject:obj];
    }
}

#pragma mark -
- (id)formData:(id)formData withParams:(id)params withKey:(NSString *)key withParentKey:(NSString *)parentKey prevArray:(BOOL)prevArray {
    id object = [self params2obj:params withKey:key prevArray:prevArray];
    
    NSString *formName = [self formName:parentKey withKey:key];
    if ([object isKindOfClass:[NSDictionary class]]) {
        [object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [self formData:formData withParams:object withKey:key withParentKey:formName prevArray:NO];
        }];
    } else if([object isKindOfClass:[NSArray class]]) {
        [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self formData:formData withParams:obj withKey:[NSString stringWithFormat:@"%d", idx] withParentKey:formName prevArray:YES];
        }];
    } else if([object isMemberOfClass:[UIImage class]]) {
        NSData *pngData = UIImagePNGRepresentation(object);
        [formData appendPartWithFileData:pngData name:formName fileName:@"photo.png" mimeType:@"image/png"];
    } else {
        NSData *data = [[NSString stringWithFormat:@"%@", object] dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:data name:formName];
    }
    return formData;
}

- (NSString *)formName:(NSString *)parentKey withKey:(NSString *)key {
    NSString *formName = nil;
    if (parentKey)  {
        formName = [NSString stringWithFormat:@"%@[%@]", parentKey, key];
    } else {
        formName = key;
    }
    return formName;
}

- (id)params2obj:(id)params withKey:(NSString *)key prevArray:(BOOL)prevArray {
    id obj = nil;
    if(prevArray || [params isMemberOfClass:[UIImage class]] || [params isMemberOfClass:[NSString class]]) {
        obj = params;
    } else {
        obj = [params valueForKey:key];
    }
    return obj;
}

@end
