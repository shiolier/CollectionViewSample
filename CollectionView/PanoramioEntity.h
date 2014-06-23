//
//  PanoramioEntity.h
//  CollectionView
//
//  Created by Shiolier on 2014/06/16.
//
//

#import "BaseEntity.h"

@interface PanoramioEntity : BaseEntity

@property int photo_id;
@property NSString *photo_title;
@property NSString *photo_url;
@property NSString *photo_file_url;
@property double longitude;
@property double latitude;
@property int width;
@property int height;
@property NSString *upload_date;
@property int owner_id;
@property NSString *owner_name;
@property NSString *owner_url;

@end
