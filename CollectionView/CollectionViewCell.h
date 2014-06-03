//
//  CollectionViewCell.h
//  CollectionView
//
//  Created by Shiolier on 2014/06/02.
//
//

#import <UIKit/UIKit.h>

@class CollectionItem;

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic) CollectionItem *collectionItem;

+ (CGFloat)height:(CollectionItem *)item;

@end
