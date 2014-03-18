//
//  DetailView.h
//  Persistent Capture
//
//  Created by InternetCowboy | Codin Pangell on 2/3/14.
//  Copyright (c) 2014 InternetCowboy | Codin Pangell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayView.h"
#import "VideoCreateView.h"


@class DetailView;
@protocol DetailViewDelegate <NSObject>
@required
- (void)detailView:(DetailView *)dayView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DetailView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *albumTitle;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong)  NSMutableArray* daysOfTheWeek;
@property (nonatomic, weak) id<DetailViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) VideoPlayView *videoPlayView;
@property (nonatomic,strong) VideoCreateView *videoCreateView;

@property NSDictionary *weekInfo;
@end
