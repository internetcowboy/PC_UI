//
//  videoplayview.h
//  Persistent Capture
//
//  Created by InternetCowboy | Codin Pangell on 2/3/14.
//  Copyright (c) 2014 InternetCowboy | Codin Pangell. All rights reserved.
//
#import "OCCalendarViewController.h"
#import <UIKit/UIKit.h>


@interface VideoPlayView : UIView  <UIGestureRecognizerDelegate, OCCalendarDelegate>
@property (nonatomic, strong) UILabel *closeIcon;
@property (nonatomic, strong) UILabel *mainTitle;

@property (nonatomic, strong) OCCalendarViewController *calVC;
@property (nonatomic, strong) UILabel *toolTipLabel;

-(void)startCal;
-(void)endCal;

@end
