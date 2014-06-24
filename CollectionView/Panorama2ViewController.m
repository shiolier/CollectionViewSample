//
//  Panorama2ViewController.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/17.
//
//

#import "Panorama2ViewController.h"
#import "GetPanorama.h"
#import "PanoramioEntity.h"

@implementation Panorama2ViewController

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
							@20, @"from",
							@40, @"to",
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
