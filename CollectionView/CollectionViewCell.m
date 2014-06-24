//
//  CollectionViewCell.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/02.
//
//

#import "CollectionViewCell.h"
#import "PanoramioEntity.h"

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

- (void)setEntity:(PanoramioEntity *)entity
{
	CGSize resizeImageSize = [CollectionViewCell getResizeImageSize:CGSizeMake(entity.width, entity.height)];
	self.imageView.frame = CGRectMake(25, 10, 100, resizeImageSize.height);
	
	self.label.frame = CGRectMake(0, 10 + self.imageView.frame.size.height, 150, 40);
	self.label.text = entity.photo_title;
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:entity.photo_file_url]];
		dispatch_async(dispatch_get_main_queue(), ^{
			UIImage *image = [[UIImage alloc] initWithData:data];
			
			UIImage *resizeImage = [CollectionViewCell changeImageSize:image];
			
			self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y,
											  resizeImage.size.width, resizeImage.size.height);
			self.label.frame = CGRectMake(0, 10 + resizeImage.size.height, 150, 40);
			self.imageView.image = resizeImage;
		});
	});
}

- (UILabel *)label
{
	if (!_label) {
		_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 150, 40)];
		_label.textAlignment = NSTextAlignmentCenter;
		_label.font = [UIFont systemFontOfSize:10];
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

+ (UIImage *)changeImageSize:(UIImage *)image
{
	CGSize resizeSize = [CollectionViewCell getResizeImageSize:image.size];
	UIGraphicsBeginImageContext(resizeSize);
	[image drawInRect:CGRectMake(0, 0, resizeSize.width, resizeSize.height)];
	UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return resizeImage;
}

+ (CGSize)getResizeImageSize:(CGSize)size
{
	// 縦横比を変えずに横幅を100に変更
	float widthRatio = 100 / size.width;
	return CGSizeMake(size.width * widthRatio, size.height * widthRatio);
}

+ (CGFloat)height:(PanoramioEntity *)entity
{
	CGSize resizeSize = [CollectionViewCell getResizeImageSize:CGSizeMake(entity.width, entity.height)];
	return resizeSize.height + 50;
}

@end
