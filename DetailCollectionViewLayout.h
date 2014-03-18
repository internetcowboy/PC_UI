//
//  DetailCollectionViewLayout.h
//  UI_Test_Accordion
//
//  Created by Hal on 3/1/14.
//  Copyright (c) 2014 Hal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCollectionViewLayout : UICollectionViewLayout


@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, assign) NSInteger cellWidth;
@property (nonatomic, assign) NSInteger cellHeight;

@end
