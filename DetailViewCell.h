//
//  DetailViewCell.h
//  Persistent Capture
//
//  Created by InternetCowboy | Codin Pangell on 2/3/14.
//  Copyright (c) 2014 InternetCowboy | Codin Pangell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *dayTitle;
@property (nonatomic, strong) UILabel *albumSubTitle;
@property (nonatomic, strong) UIImageView *recorderIcon;
@property (nonatomic, strong) UIView *topLayerView;


@property (nonatomic, strong) UIView *bottomLayerView;
@property (nonatomic, strong) UILabel *playTitle;
@property (nonatomic, strong) UILabel *recordTitle;

@end
