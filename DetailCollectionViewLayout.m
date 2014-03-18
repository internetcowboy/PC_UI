//
//  DetailCollectionViewLayout.m
//  UI_Test_Accordion
//
//  Created by Hal on 3/1/14.
//  Copyright (c) 2014 Hal. All rights reserved.
//

#import "DetailCollectionViewLayout.h"
#import "DetailViewCell.h"



@interface DetailCollectionViewLayout()

// arrays to keep track of insert, delete index paths
@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;

@end


// Degrees to radians
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation DetailCollectionViewLayout


-(void)prepareLayout
{
    [super prepareLayout];
    
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    CGSize size = self.collectionView.frame.size;
    _center = CGPointMake(size.width / 2.0, size.height / 2.0);
    
}

-(CGSize)collectionViewContentSize
{
    return [self collectionView].frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
   

    //frame size
    attributes.frame = CGRectMake(0, 0, self.cellWidth, self.cellHeight);
    
    //determine center point of cell
    float cellSizeWithOffset = (self.cellHeight)+0; //0px spacing
    attributes.center = CGPointMake(_center.x, (path.item * cellSizeWithOffset) + self.cellHeight );
    
    
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}

// Note: name of method changed
// Also this gets called for all visible cells (not just the inserted ones) and
// even gets called when deleting cells!
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    
    // Must call super
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    
    //NSLog(@"PATH WITH UPDATED ITEM %@", self.insertIndexPaths);
    
    if ([self.insertIndexPaths containsObject:itemIndexPath])
    {
        //NSLog(@"found path %@", self.insertIndexPaths);

            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
            attributes.alpha = 0.0;
        //}
        
        
        CATransform3D transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(180.0), 0.0, 1.0, 0.0);
        attributes.transform3D = transform;
        
    }
    
    return attributes;
}

// Note: name of method changed
// Also this gets called for all visible cells (not just the deleted ones) and
// even gets called when inserting cells!
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // So far, calling super hasn't been strictly necessary here, but leaving it in
    // for good measure
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deleteIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        //attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    
    return attributes;
}

@end
