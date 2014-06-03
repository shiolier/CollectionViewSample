//
//  CollectionViewCell.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/02.
//
//

#import "CollectionViewCell.h"
#import "CollectionItem.h"

@interface CollectionViewCell ()

@property (nonatomic) UILabel *label;
@property (nonatomic) UIImageView *imageView;

@end

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self.contentView addSubview:self.label];
		[self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setCollectionItem:(CollectionItem *)collectionItem
{
	UIImage *image = [UIImage imageNamed:collectionItem.image_name];
	self.imageView.frame = CGRectMake(25, 10, image.size.width, image.size.height);
	self.imageView.image = image;
	
	self.label.frame = CGRectMake(0, 10 + image.size.height, 150, 40);
	self.label.text = collectionItem.text;
	
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:collectionItem.image_url]];
//		dispatch_async(dispatch_get_main_queue(), ^{
//			UIImage *image = [[UIImage alloc] initWithData:data];
//			self.imageView.image = image;
//		});
//	});
}

- (UILabel *)label
{
	if (!_label) {
		_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 150, 40)];
		_label.textAlignment = NSTextAlignmentCenter;
	}
	return _label;
}

- (UIImageView *)imageView
{
	if (!_imageView) {
		_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 10, 100, 100)];
	}
	return _imageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (CGFloat)height:(CollectionItem *)item
{
	UIImage *image = [UIImage imageNamed:item.image_name];
	return image.size.height + 50;
}

@end
