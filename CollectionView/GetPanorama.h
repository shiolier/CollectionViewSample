//
//  GetPanorama.h
//  CollectionView
//
//  Created by Shiolier on 2014/06/17.
//
//

#import <Foundation/Foundation.h>

@interface GetPanorama : NSObject

+ (void)getPanorama:(NSDictionary *)params
			success:(void (^)(id response))successBlock
			failure:(void (^)(NSError *))failureBlock;

@end
