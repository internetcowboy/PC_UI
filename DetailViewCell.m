//
//  DetailViewCell.m
//  Persistent Capture
//
//  Created by InternetCowboy | Codin Pangell on 2/3/14.
//  Copyright (c) 2014 InternetCowboy | Codin Pangell. All rights reserved.
//

#import "DetailViewCell.h"
#import "UIComponentsClass.h"

@implementation DetailViewCell {
    UIComponentsClass * uicore;
}


//constants
static NSString * const kFontName = @"HelveticaNeue-Bold";
static float kFontSize = 12.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        uicore = [UIComponentsClass new];
        self.backgroundColor = [UIColor clearColor];
        
        [self.topLayerView addSubview:self.dayTitle];
        [self.topLayerView addSubview:self.recorderIcon];
        [self addSubview:self.topLayerView];
        
        [self.bottomLayerView addSubview:self.playTitle];
        [self.bottomLayerView addSubview:self.recordTitle];
        
        [self.bottomLayerView addSubview:self.albumSubTitle];
        [self addSubview:self.bottomLayerView];
        
        
        [self bringSubviewToFront:self.topLayerView];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
}



- (UILabel *)dayTitle {
    
    if (!_dayTitle) {
        _dayTitle = [uicore newCustomFontLabel:@" " y:0 x:0 w:0 h:0 fontName:kFontName fontSize:(kFontSize+5)];
        _dayTitle.textColor = [UIColor whiteColor];
    }
    
    return _dayTitle;
}

- (UILabel *)albumSubTitle {
    
    if (!_albumSubTitle) {
        _albumSubTitle = [uicore newCustomFontLabel:@" " y:0 x:0 w:0 h:0 fontName:kFontName fontSize:kFontSize];
        _albumSubTitle.textColor = [UIColor whiteColor];
    }
    
    return _albumSubTitle;
}


- (UIImageView *)recorderIcon {
    if (!_recorderIcon) {
        _recorderIcon = [[UIImageView alloc] initWithFrame:self.frame];
        _recorderIcon.backgroundColor = [UIColor clearColor];
        _recorderIcon.frame = CGRectMake( 20 , 20, 45, 30);
    }
    
    return _recorderIcon;
}

- (UIView *)topLayerView {
    if (!_topLayerView) {
        _topLayerView = [[UIView alloc] initWithFrame:self.frame];
        _topLayerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _topLayerView.backgroundColor = [UIColor grayColor];
    }
    
    return _topLayerView;
}


- (UIView *)bottomLayerView {
    if (!_bottomLayerView) {
        _bottomLayerView = [[UIView alloc] initWithFrame:self.frame];
        _bottomLayerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _bottomLayerView.backgroundColor = [UIColor clearColor];
    }
    
    return _bottomLayerView;
}

- (UILabel *)playTitle {
    
    if (!_playTitle) {
        _playTitle = [uicore newCustomFontLabel:@"PLAY TODAY" y:0 x:0 w:0 h:0 fontName:kFontName fontSize:(kFontSize)];
        _playTitle.frame = CGRectMake(15, 0, 50, self.frame.size.height);
        _playTitle.numberOfLines = 0;
        _playTitle.textAlignment = NSTextAlignmentCenter;
        _playTitle.textColor = [UIColor whiteColor];
    }
    
    return _playTitle;
}

- (UILabel *)recordTitle {
    
    if (!_recordTitle) {
        _recordTitle = [uicore newCustomFontLabel:@"RECORD TODAY" y:0 x:0 w:0 h:0 fontName:kFontName fontSize:(kFontSize)];
        _recordTitle.frame = CGRectMake(self.frame.size.width-75, 0, 60, self.frame.size.height);
        _recordTitle.numberOfLines = 0;
        _recordTitle.textAlignment = NSTextAlignmentCenter;
        _recordTitle.textColor = [UIColor whiteColor];
    }
    
    return _recordTitle;
}




@end
