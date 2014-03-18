//
//  PCMainViewController.m
//  Persistent Capture
//
//  Created by InternetCowboy | Codin Pangell on 1/29/14.
//  Copyright (c) 2014 InternetCowboy | Codin Pangell. All rights reserved.
//

#import "PCMainViewController.h"
#import "DetailView.h"


@interface PCMainViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) DetailView *detailView;


@end

@implementation PCMainViewController {
    
    int currentDetailAlbum;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
   
    //attach sub views
    [self.view addSubview:self.detailView];
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.detailView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //silly keyboard, hide yo-self.
    [[self view] endEditing:YES];
}

- (void)detailView:(DetailView *)detailView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int ind = indexPath.item;
    
    
    
    //NSLog(@"%d",ind);
    
    
     // Start adding at index position z and secondArray has count items
     /*
      //Add item to array at the proper index and reload the collectionview.
      NSRange range = NSMakeRange(ind+1, 1);
      NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
     [detailView.daysOfTheWeek insertObjects:@[@"test"] atIndexes:indexSet];
     [detailView.collectionView reloadData];
    */
    
    NSRange range = NSMakeRange(ind+1, 1);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    [detailView.daysOfTheWeek insertObjects:@[@"test"] atIndexes:indexSet];
  
    // Batch this so the other sections will be updated on completion
    [detailView.collectionView performBatchUpdates:^{
        
        detailView.frame = CGRectMake(0, 0, self.view.frame.size.width, (40 * [detailView.daysOfTheWeek count]));
        [detailView.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:ind+1 inSection:0]]];
    }
                                  completion:^(BOOL finished) {
                                      //[detailView.collectionView reloadData];
                                  }];
    
}


#pragma mark Subviews

- (DetailView *)detailView {
    if (!_detailView) {
        _detailView = [[DetailView alloc] initWithFrame:self.view.bounds];
        [_detailView setDelegate:self];
    }
    
    return _detailView;
}



@end
