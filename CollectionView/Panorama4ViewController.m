//
//  Panorama4ViewController.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/23.
//
//

#import "Panorama4ViewController.h"
#import "GetPanorama.h"
#import "PanoramioEntity.h"

@implementation Panorama4ViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							@"public", @"set",
							@"medium", @"size",
							@60, @"from",
							@80, @"to",
							@true, @"mapfilter", nil];
	
	[GetPanorama getPanorama:params
					 success:^(id response){
						 for (NSDictionary *dict in response[@"photos"]) {
							 PanoramioEntity *entity = [[PanoramioEntity alloc] initWithAttributes:dict];
							 [self.entities addObject:entity];
						 }
						 dispatch_async(dispatch_get_main_queue(), ^{
							 [self.collectionView reloadData];
						 });
					 }
					 failure:^(NSError *error){
						 NSLog(@"ERROR!!");
						 NSLog(@"localizedDescription\n%@", error.localizedDescription);
					 }];
}

@end
