//
//  VideoCreateView.m
//  Persistent Capture
//
//  Created by InternetCowboy | Codin Pangell on 2/3/14.
//  Copyright (c) 2014 InternetCowboy | Codin Pangell. All rights reserved.
//

#import "VideoCreateView.h"
#import "UIComponentsClass.h"

#import <QuartzCore/QuartzCore.h>

@implementation VideoCreateView{
    UIComponentsClass * uicore;
    
}

//constants
static NSString * const kFontName = @"HelveticaNeue-Bold";
static NSString * const kFontNameMed = @"HelveticaNeue-Medium";
static float kFontSize = 16.0f;
static float kDirectionsFontSize = 10.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"Record Video View...");
        self.backgroundColor = [UIColor clearColor];
        uicore = [UIComponentsClass new];
        
        [self addSubview:self.mainTitle];

        
    }
    return self;
}


- (void)layoutSubviews {
    
	[super layoutSubviews];
    self.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);

}


- (UILabel *)mainTitle {
    
    if (!_mainTitle) {
        _mainTitle = [uicore newCustomFontLabel:@"Record Video" y:0 x:0 w:0 h:0 fontName:kFontName fontSize:kFontSize];
        _mainTitle.textColor = [UIColor whiteColor];
        _mainTitle.textAlignment = NSTextAlignmentCenter;
        _mainTitle.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    
    return _mainTitle;
}

@end
