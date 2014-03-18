//
//  DetailView.m
//  Persistent Capture
//
//  Created by InternetCowboy | Codin Pangell on 2/3/14.
//  Copyright (c) 2014 InternetCowboy | Codin Pangell. All rights reserved.
//

#import "DetailView.h"
#import "UIComponentsClass.h"
#import "DetailViewCell.h"
#import "DetailCollectionViewLayout.h"
#import "VideoCreateView.h"

#import <QuartzCore/QuartzCore.h>


@implementation DetailView{
    UIComponentsClass * uicore;
    int cellWidth;
    int cellHeight;
    UICollectionViewFlowLayout *layout;
    
    //determine direction of swipe
    float firstX;
    float lastX;
    
    //scrollview items
    bool pullDownInProgress;
    
    //play video items
    bool showingCalendar;
}

static NSString * const kFontName = @"HelveticaNeue-Bold";
static NSString * const kFontNameMed = @"HelveticaNeue-Medium";
static float kFontSize = 13.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"Album Detail View...");
        self.backgroundColor = [UIColor clearColor];
        uicore = [UIComponentsClass new];
        
        cellHeight = 60;
        cellWidth = self.frame.size.width;
        
        self.daysOfTheWeek = [[NSMutableArray alloc] initWithArray:@[@"HELLO", @"WORLD", @"ITS", @"FRIDAY"]];
       
        //create collectionview
        //[self.scrollView addSubview:self.collectionView];
        
        //add views to self
        //[self addSubview:self.scrollView];
        
        [self addSubview:self.videoPlayView];
        [self addSubview:self.videoCreateView];
        [self addSubview:self.collectionView];
        
    }
    return self;
}


- (void)layoutSubviews {
	[super layoutSubviews];
    
    NSInteger setHeight = (cellHeight * [self.daysOfTheWeek count]);
    if (setHeight<self.frame.size.height){
        setHeight = self.frame.size.height;
    }
    
    self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.collectionView.frame = self.frame;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height+10.0f); //10 is to allow a scroll
    self.videoPlayView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.videoCreateView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Inside detail view, try to forward action");
    
    //forward delegate to view controller
   // [self.delegate detailView: self didSelectItemAtIndexPath:indexPath];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.daysOfTheWeek count];
}

- (DetailViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DetailViewCell *cell = (DetailViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"dayCell" forIndexPath:indexPath];
    int ind = indexPath.item;
    cell.tag = ind;
    
    NSArray *dayInformation = [self.weekInfo valueForKey:self.daysOfTheWeek[ind]];
    
    //title
    cell.dayTitle.text = [self.daysOfTheWeek[ind] uppercaseString];
    cell.dayTitle.frame = CGRectMake(0, 0, cellWidth, cellHeight);
    cell.dayTitle.textAlignment = NSTextAlignmentCenter;
    
    //subtitle
    cell.albumSubTitle.text = [dayInformation[0] uppercaseString];
    cell.albumSubTitle.frame = CGRectMake(0, 15, cellWidth, cellHeight);
    cell.albumSubTitle.textAlignment = NSTextAlignmentCenter;
    
    //detect pans
    UIPanGestureRecognizer * pan1 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didSwipe:) ];
    pan1.minimumNumberOfTouches = 1;
    [cell addGestureRecognizer:pan1];
    
    //custom variable color
    cell.topLayerView.backgroundColor = [UIColor colorWithRed:0.3 green:0.80 blue:(0.20 + (ind * .2)) alpha:1.0];
    
    return cell;
    
}

-(void) didSwipe: (UIPanGestureRecognizer *)sender {
 
    //obtain the cell
    NSInteger cellTag = sender.view.tag;
    NSIndexPath *cellIndex = [NSIndexPath indexPathForRow:cellTag inSection:0];
    DetailViewCell *cell = (DetailViewCell *)[self.collectionView cellForItemAtIndexPath:cellIndex];
    CGPoint translation = [sender translationInView:cell];

    //only allow a 100px movement.
    float movementLimit = 90.0;
    float differenceBetweenStartAndCurrent = 0.0;
    CGRect cellFrame = cell.topLayerView.frame;
    float startMovementAt = 0.0f;
    bool isRight = NO;
    bool isEnded = NO;
    float current = translation.x;

    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        //this will detect if the position should start from a point left off from
        if (cellFrame.origin.x !=0) {
            firstX = -cellFrame.origin.x;
        } else {
            firstX = translation.x;
        }
    } else if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded){
        //nothing
        isEnded = YES;
    } else {
        
    }
    
    //start the movement here because the current position is not at 0,0
    if (cellFrame.origin.x != 0){
        startMovementAt = cellFrame.origin.x;
    }
    
    //determine direction of swipe and the amount of movement
    if (firstX < current){ //right
        isRight = YES;
        differenceBetweenStartAndCurrent = current - firstX;
    } else { //left
        isRight = NO;
        differenceBetweenStartAndCurrent = firstX - current;
    }
    
    //enforce movement limit
    if (differenceBetweenStartAndCurrent > movementLimit) {
        differenceBetweenStartAndCurrent = movementLimit;
    }
    
    //move the layer
    if (isRight) {
        differenceBetweenStartAndCurrent = differenceBetweenStartAndCurrent;
        cell.backgroundColor =  [UIColor colorWithRed:0.8 green:0.20 blue:0.6 alpha:1.0];
    } else {
        differenceBetweenStartAndCurrent = -differenceBetweenStartAndCurrent;
        cell.backgroundColor =  [UIColor colorWithRed:0.4 green:0.80 blue:1 alpha:1.0];
    }
    
    //if ended and user hasn't slide entire way then set back to zero.
    if (isEnded && (differenceBetweenStartAndCurrent != movementLimit && differenceBetweenStartAndCurrent != -movementLimit) ) {
        differenceBetweenStartAndCurrent = 0;
    }
   
    //determine velocity
    CGFloat velocityX = (0.2*[(UIPanGestureRecognizer*)sender velocityInView:self].x);
    CGFloat animationDuration = (ABS(velocityX)*.0002)+.2;
    
    //animate
    [UIView transitionWithView:self duration:animationDuration options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect cellFrame = cell.topLayerView.frame;
        cellFrame.origin.x = differenceBetweenStartAndCurrent;
        cell.topLayerView.frame = cellFrame;
        
    } completion:^(BOOL finished) {
        
        if (differenceBetweenStartAndCurrent == 90 && isEnded) {
           
            [UIView transitionWithView:self.collectionView duration:0.5
                               options:UIViewAnimationOptionTransitionNone animations:^{
                                   
                                   //set up some of the attributes for this player
                                   self.videoPlayView.backgroundColor = cell.backgroundColor;
                                   self.videoPlayView.mainTitle.text = [NSString stringWithFormat:@"Play %@", cell.dayTitle.text];
                                   
                                   //position player view
                                   CGRect pvFrame = self.videoPlayView.frame;
                                   pvFrame.origin.x = 0;
                                   self.videoPlayView.frame = pvFrame;
                                   
                                   //position collectionview
                                   CGRect cvFrame = self.collectionView.frame;
                                   cvFrame.origin.x = self.frame.size.width; //move to right
                                   self.collectionView.frame = cvFrame;
                                   
                               } completion:nil];
            
        } else if (differenceBetweenStartAndCurrent == -90 && isEnded) {
            
            [UIView transitionWithView:self.collectionView duration:0.5
                               options:UIViewAnimationOptionTransitionNone animations:^{
                                   
                                   //set up some of the attributes for this recorder
                                   self.videoCreateView.backgroundColor = cell.backgroundColor;
                                   self.videoCreateView.mainTitle.text = @"Video Recorder";
                                   
                                   //position recorder view
                                   CGRect pvFrame = self.videoCreateView.frame;
                                   pvFrame.origin.x = 0;
                                   self.videoCreateView.frame = pvFrame;
                                   
                                   //position collectionview
                                   CGRect cvFrame = self.collectionView.frame;
                                   cvFrame.origin.x = -self.frame.size.width; //move to left
                                   self.collectionView.frame = cvFrame;
                                   
                               } completion:nil];
            
        }
        
        
        
        
    }];
    
}

-(void) swipedOpenCalendar: (UISwipeGestureRecognizer *)sender {
    
    if (showingCalendar) {
        
        [self closeCalendarView];
        
    } else {
        //hide the title
        self.videoPlayView.mainTitle.hidden = YES;
        showingCalendar = YES;
        
        //show calendar
        //[self.videoPlayView startCal];
        self.videoPlayView.calVC.view.hidden = NO;
        
        //flip view
        [UIView transitionWithView:self.videoPlayView duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                               
                           } completion:nil];
    }
    
    
}

-(void)closeCalendarView {
    
    //show the title
    self.videoPlayView.mainTitle.hidden = NO;
    showingCalendar = NO;
    
    //hide calendar
    self.videoPlayView.calVC.view.hidden = YES;
    
    //flip view
    [UIView transitionWithView:self.videoPlayView duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                           //[self.videoPlayView endCal];
                       } completion:nil];

    
}

-(void) swipedCloseVideoPlayer: (UISwipeGestureRecognizer *)sender {
    
    //this could have been triggered in the video view with the calendar open. If this is the case, close the calendar
    if (showingCalendar) {
        
        [self closeCalendarView];
        
    } else {
        
        [UIView transitionWithView:self duration:0.5f options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            //position player view
            CGRect pvFrame = self.videoPlayView.frame;
            pvFrame.origin.x = -self.videoPlayView.frame.size.width;
            self.videoPlayView.frame = pvFrame;
            
            //all cells should be back in zero
            for(DetailViewCell* cell in [[self collectionView] visibleCells]){
                CGRect cellFrame = cell.topLayerView.frame;
                cellFrame.origin.x = 0;
                cell.topLayerView.frame = cellFrame;
            }
            
            //position collectionview back in users view
            CGRect cvFrame = self.collectionView.frame;
            cvFrame.origin.x = 0;
            self.collectionView.frame = cvFrame;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
    
}


-(void) swipedCloseVideoRecorder: (UISwipeGestureRecognizer *)sender {
    
    [UIView transitionWithView:self duration:0.5f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //position player view
        CGRect pvFrame = self.videoCreateView.frame;
        pvFrame.origin.x = self.videoCreateView.frame.size.width;
        self.videoCreateView.frame = pvFrame;
        
        //all cells should be back in zero
        for(DetailViewCell* cell in [[self collectionView] visibleCells]){
            CGRect cellFrame = cell.topLayerView.frame;
            cellFrame.origin.x = 0;
            cell.topLayerView.frame = cellFrame;
        }
        
        //position collectionview back in users view
        CGRect cvFrame = self.collectionView.frame;
        cvFrame.origin.x = 0;
        self.collectionView.frame = cvFrame;
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // this behaviour starts when a user pulls down while at the top of the table
    pullDownInProgress = scrollView.contentOffset.y <= 0.0f;
    NSLog(@"scroll %i", pullDownInProgress);
    
    if (pullDownInProgress)
    {
        // add our placeholder
        DetailViewCell *cell = [DetailViewCell new];
        cell.frame=CGRectMake(0, -cellHeight, 320, cellHeight);
        cell.dayTitle.text = @"test";
        
        
        UILabel *lbl = [uicore newCustomFontLabel:@" " y:0 x:0 w:0 h:0 fontName:kFontNameMed fontSize:kFontSize];
        lbl.textColor = [UIColor whiteColor];
        lbl.text = @"New Shit";
        lbl.backgroundColor =[UIColor yellowColor];
        lbl.frame = CGRectMake(0, 0, self.frame.size.width, 100);

        
        [self.scrollView insertSubview:lbl atIndex:0];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    bool _metNegativePullDown;
    
    if (scrollView.contentOffset.y < -50) _metNegativePullDown = YES;
    if (fabs(scrollView.contentOffset.y) < 1 && _metNegativePullDown) {
        //do your refresh here
        _metNegativePullDown = NO;
    }
    
    NSLog(@"%i",_metNegativePullDown);
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (pullDownInProgress && - self.collectionView.contentOffset.y > cellHeight)
    {
       // [data insertObject:@"" atIndex:0];
       // [myTableView reloadData];
    }
    
    pullDownInProgress = false;
   // [placeholderCell removeFromSuperview];
}



-(void)addNewCell:(UISwipeGestureRecognizer *)downGesture
{
    NSMutableArray *newData = [[NSMutableArray alloc] initWithObjects:@"otherData", nil];
    [self.collectionView performBatchUpdates:^{
        int resultsSize = [self.daysOfTheWeek count]; //data is the previous array of data
        [self.daysOfTheWeek addObjectsFromArray:newData];
        
        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
        for (int i = resultsSize; i < resultsSize + newData.count; i++)
        {
            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
    }
                                    completion:nil];
    
}


- (UILabel *)albumTitle {
 
    if (!_albumTitle) {
        _albumTitle = [uicore newCustomFontLabel:@" " y:0 x:0 w:0 h:0 fontName:kFontNameMed fontSize:kFontSize];
        _albumTitle.textColor = [UIColor whiteColor];
        _albumTitle.frame = CGRectMake(20, 20, self.frame.size.width, self.albumTitle.frame.size.height);
    }
    
    return _albumTitle;
}

-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        //create collection view layout
        DetailCollectionViewLayout *detailLayout = [[DetailCollectionViewLayout alloc] init];
        detailLayout.cellWidth = self.frame.size.width;
        detailLayout.cellHeight = cellHeight;
        
        //collectionview
        _collectionView=[[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:detailLayout];
        _collectionView.dataSource = self;
        [_collectionView setDelegate:self];
        [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        _collectionView.pagingEnabled = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[DetailViewCell class] forCellWithReuseIdentifier:@"dayCell"];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        
        
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(addNewCell:)];
        swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
        [_collectionView addGestureRecognizer:swipeDown];
        
    }
    
    return _collectionView;
    
}

-(UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.delegate = self;
        [_scrollView setScrollEnabled:YES];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setMultipleTouchEnabled:YES];

    }
    
    return _scrollView;
}


- (VideoPlayView *)videoPlayView {
    if (!_videoPlayView) {
        _videoPlayView = [[VideoPlayView alloc] initWithFrame:self.frame];
        
        //close view
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(swipedCloseVideoPlayer:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [_videoPlayView addGestureRecognizer:swipeLeft];
        
        //show calendar
        showingCalendar = NO;
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(swipedOpenCalendar:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [_videoPlayView addGestureRecognizer:swipeRight];
        
        
        
    }
    
    return _videoPlayView;
}
- (VideoCreateView *)videoCreateView {
    if (!_videoCreateView) {
        _videoCreateView = [[VideoCreateView alloc] initWithFrame:self.frame];
        
        //close view
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(swipedCloseVideoRecorder:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [_videoCreateView addGestureRecognizer:swipeRight];
        
    }
    
    return _videoCreateView;
}



@end
