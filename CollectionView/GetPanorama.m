//
//  GetPanorama.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/17.
//
//

#import "GetPanorama.h"
#import "APIClient.h"

@implementation GetPanorama

+ (void)getPanorama:(NSDictionary *)params
			success:(void (^)(id))successBlock
			failure:(void (^)(NSError *))failureBlock
{
	[APIClient asyncRequest:GET
					   path:@"get_panoramas.php"
					 params:params
					 upload:nil
				   download:nil
					success:successBlock
					failure:failureBlock];
}

@end
