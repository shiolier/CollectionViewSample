//
//  Panorama3ViewController.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/17.
//
//

#import "Panorama3ViewController.h"
#import "PanoramioEntity.h"
#import "GetPanorama.h"

@implementation Panorama3ViewController

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
							@40, @"from",
							@60, @"to",
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
