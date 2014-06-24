//
//  PanoramioEntity.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/16.
//
//

#import "PanoramioEntity.h"

@implementation PanoramioEntity

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        [self attributes4Object:attributes];
    }
    return self;
}

- (void)attributes4Object:(NSDictionary *)attributes
{
	// self.photo_id = [(NSNumber *)[self null2nil:attributes[@"photo_id"]] intValue];
	self.photo_id = [(NSNumber *)[self null2nil:attributes[@"photo_id"]] intValue];
	self.photo_title = [self null2nil:attributes[@"photo_title"]];
	self.photo_url = [self null2nil:attributes[@"photo_url"]];
	self.photo_file_url = [self null2nil:attributes[@"photo_file_url"]];
	self.longitude = [(NSNumber *)[self null2nil:attributes[@"longitude"]] doubleValue];
	self.latitude = [(NSNumber *)[self null2nil:attributes[@"latitude"]] doubleValue];
	self.width = [(NSNumber *)[self null2nil:attributes[@"width"]] intValue];
	self.height = [(NSNumber *)[self null2nil:attributes[@"height"]] intValue];
	self.upload_date = [self null2nil:attributes[@"upload_date"]];
	self.owner_id = [(NSNumber *)[self null2nil:attributes[@"owner_id"]] intValue];
	self.owner_name = [self null2nil:attributes[@"owner_name"]];
	self.owner_url = [self null2nil:attributes[@"owner_url"]];
}

@end
