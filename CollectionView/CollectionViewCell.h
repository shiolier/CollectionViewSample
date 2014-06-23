//
//  CollectionViewCell.h
//  CollectionView
//
//  Created by Shiolier on 2014/06/02.
//
//

#import <UIKit/UIKit.h>

@class PanoramioEntity;

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic) PanoramioEntity *entity;

+ (CGFloat)height:(PanoramioEntity *)item;

@end
