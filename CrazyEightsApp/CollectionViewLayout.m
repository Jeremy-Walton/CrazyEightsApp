//
//  CollectionViewLayout.m
//  CrazyEightsApp
//
//  Created by Jeremy on 1/30/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "CollectionViewLayout.h"

static NSString * const CollectionViewLayoutCellKind = @"Cell";

@interface CollectionViewLayout ()

@property (nonatomic, strong) NSDictionary *layoutInfo;

@end

@implementation CollectionViewLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize = CGSizeMake(125.0f, 125.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
}

- (CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.section / self.numberOfColumns;
    NSInteger column = indexPath.section % self.numberOfColumns;
    
    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
    
//    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
    CGFloat originX = 100;
    CGFloat originY = 100;
//    CGFloat originY = floor(self.itemInsets.top +
//                            (self.itemSize.height + self.interItemSpacingY) * row);
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

- (void)prepareLayout
{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForAlbumPhotoAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    newLayoutInfo[CollectionViewLayoutCellKind] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

-(CGSize)collectionViewContentSize {
//    CGSize contentSize = [super collectionViewContentSize];
//    
//    if (self.collectionView.bounds.size.width > contentSize.width)
//        contentSize.width = self.collectionView.bounds.size.width;
//    
//    if (self.collectionView.bounds.size.height > contentSize.height)
//        contentSize.height = self.collectionView.bounds.size.height;
//    
//    return contentSize;
    CGSize contentSize = [super collectionViewContentSize];
    
    if (self.collectionView.bounds.size.width > contentSize.width)
        contentSize.width = self.collectionView.bounds.size.width;
    
    if (self.collectionView.bounds.size.height > contentSize.height)
        contentSize.height = self.collectionView.bounds.size.height;
    
    return contentSize;
}

- (void)setStackFactor:(CGFloat)stackFactor {
    _stackFactor = stackFactor;
    
    [self invalidateLayout];
}

- (void)setStackCenter:(CGPoint)stackCenter {
    _stackCenter = stackCenter;
    
    [self invalidateLayout];
}

//-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray* attributesArray = [super layoutAttributesForElementsInRect:rect];
//    
//    // Calculate the new position of each cell based on stackFactor and stackCenter
//    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
//        CGFloat xPosition = self.stackCenter.x + (attributes.center.x - self.stackCenter.x) * self.stackFactor;
//        CGFloat yPosition = self.stackCenter.y + (attributes.center.y - self.stackCenter.y) * self.stackFactor;
//        
//        attributes.center = CGPointMake(xPosition, yPosition);
//        
//        if (attributes.indexPath.row == 0) {
//            attributes.alpha = 1.0;
//            attributes.zIndex = 1.0; // Put the first cell on top of the stack
//        } else {
//            attributes.alpha = self.stackFactor; // fade the other cells out
//            attributes.zIndex = 0.0; //Other cells below the first one
//        }
//    }
//    
//    return attributesArray;
//}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
                
                for (UICollectionViewLayoutAttributes *attributes in allAttributes) {

                    if (self.stackCenter.x + (attributes.center.x - self.stackCenter.x) + self.stackFactor < self.collectionView.frame.size.width) {
                        attributes.center = CGPointMake(self.stackCenter.x + (attributes.center.x - self.stackCenter.x) + self.stackFactor, 100);
                    } else {
                        
                    }
                    
                    if (attributes.indexPath.row == 0) {
                        attributes.alpha = 1.0;
                        attributes.zIndex = 1.0; // Put the first cell on top of the stack
                    } else {
                        attributes.alpha = self.stackFactor; // fade the other cells out
                        attributes.zIndex = 0.0; //Other cells below the first one
                    }
                }
                
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[CollectionViewLayoutCellKind][indexPath];
}


@end
