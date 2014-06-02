//
//  CollectionViewCell.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/02.
//
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self.contentView addSubview:self.numberLabel];
    }
    return self;
}

- (UILabel *)numberLabel
{
	if (!_numberLabel) {
		_numberLabel = [[UILabel alloc] initWithFrame:self.contentView.frame];
		_numberLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _numberLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
