//
//  VideoPlayView.M
//  Persistent Capture
//
//  Created by InternetCowboy | Codin Pangell on 2/3/14.
//  Copyright (c) 2014 InternetCowboy | Codin Pangell. All rights reserved.
//

#import "VideoPlayView.h"
#import "UIComponentsClass.h"
#import "OCCalendarViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation VideoPlayView{
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
        NSLog(@"Play Video View...");
        self.backgroundColor = [UIColor clearColor];
        uicore = [UIComponentsClass new];
        
        [self addSubview:self.mainTitle];
        [self addSubview:self.calVC.view];
        
    }
    return self;
}


- (void)layoutSubviews {
    
	[super layoutSubviews];
    self.frame = CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);

}


-(void)endCal {

    self.calVC = nil;
    
}


-(void)startCal {
    
    self.calVC = [[OCCalendarViewController alloc] initAtPoint:CGPointMake(self.frame.size.width-20, 50) inView:self arrowPosition:OCArrowPositionRight];
    
}


- (UILabel *)mainTitle {
    
    if (!_mainTitle) {
        _mainTitle = [uicore newCustomFontLabel:@"Playing Video" y:0 x:0 w:0 h:0 fontName:kFontName fontSize:kFontSize];
        _mainTitle.textColor = [UIColor whiteColor];
        _mainTitle.textAlignment = NSTextAlignmentCenter;
        _mainTitle.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    
    return _mainTitle;
}

- (UILabel *)closeIcon {
    if (!_closeIcon) {
        _closeIcon = [uicore newCustomFontLabel:@"B" y:0 x:0 w:0 h:0 fontName:@"Untitled-Regular" fontSize:24.0f];
        _closeIcon.backgroundColor = [UIColor clearColor];
        _closeIcon.frame = CGRectMake((self.frame.size.width-55), 50, 40, 40);
    }
    
    return _closeIcon;
}

-(OCCalendarViewController *)calVC {
    
    if (!_calVC) {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        _calVC = [[OCCalendarViewController alloc] initAtPoint:CGPointMake(self.frame.size.width-20, 50) inView:self arrowPosition:OCArrowPositionRight];
        _calVC.delegate = self;
        
        //Test ONLY
        //_calVC.selectionMode = OCSelectionSingleDate;
        //Now we're going to optionally set the start and end date of a pre-selected range.
        //This is totally optional.
       /* NSDateComponents *dateParts = [[NSDateComponents alloc] init];
        [dateParts setMonth:5];
        [dateParts setYear:2012];
        [dateParts setDay:8];
        
        NSDate *sDate = [calendar dateFromComponents:dateParts];
        
        dateParts = [[NSDateComponents alloc] init];
        [dateParts setMonth:5];
        [dateParts setYear:2012];
        [dateParts setDay:14];
        
        NSDate *eDate = [calendar dateFromComponents:dateParts];
        
        //[_calVC setStartDate:sDate];
        //[_calVC setEndDate:eDate];
        */
        
        _calVC.view.hidden = YES;
        
    }
    
    return _calVC;
}



#pragma mark -
#pragma mark OCCalendarDelegate Methods

- (void)completedWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    
    NSLog(@"startDate:%@, endDate:%@", startDate, endDate);
    
    [self showToolTip:[NSString stringWithFormat:@"%@ - %@", [df stringFromDate:startDate], [df stringFromDate:endDate]]];
    
}

-(void) completedWithNoSelection{
    NSLog(@"completed calendar");
}


#pragma mark -
#pragma mark Prettifying Methods...


//Create our little toast notifications.....
- (void)showToolTip:(NSString *)str {

    
    NSLog(@"CALENDAR SELECTION :: %@", str);
    
}



@end
