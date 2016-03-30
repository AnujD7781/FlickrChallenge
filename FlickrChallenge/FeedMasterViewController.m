//
//  FeedMasterViewController.m
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "FeedMasterViewController.h"
#import "CustomRefreshView.h"
#import "CollectionViewCell.h"
#import "CollectionViewDataCenter.h"
#import "Photo.h"
#import "LightBoxViewController.h"

@interface FeedMasterViewController ()

    // IBOutlet and Properties
@property (strong, nonatomic) CollectionViewDataCenter *collectionViewDataCenter;
@property (weak, nonatomic) IBOutlet UIView *refreshView;
@property (weak, nonatomic) IBOutlet BaseCollectionView *collectionView;

@end
@implementation FeedMasterViewController

#pragma mark - View lifecycle methods
-(void)viewDidLoad {
    
        // Allocate data for data center
    self.collectionViewDataCenter = [[CollectionViewDataCenter alloc]init];
        // set Delegate to self
    self.collectionViewDataCenter.delegate = self;
    self.collectionView.baseCollectionViewDelegate  =self;

        // Get data for Tags =  Shark
    [self.collectionViewDataCenter getDataForCollectionViewForTags:@"shark"];
    [self setActivityIndicatorForView:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // pass Photo object to Deatil View Controller  - Light Box view controller
    if ([[segue identifier] isEqualToString:@"LightBoxSegue"] ) {
        LightBoxViewController *detailVC = (LightBoxViewController*)[segue destinationViewController];
        detailVC.photo = [self.collectionViewDataCenter getPhotoDataForIndexPath:self.collectionView.indexPathsForSelectedItems[0]];
    }
}

#pragma mark - CollectionViewDataCenter Delegate Methods

-(void)didGetDataForCollectionView {
        // Did get data for collectionView
    [self.collectionView reloadData];
    [self.collectionView.refreshControl endRefreshing];
    [self setActivityIndicatorForView:NO];
}

-(void)didGetError {
        // Did get error while getting/parsing data from collectionView
    [self showMessage:@"Opps. Something went wrong!! Please try again!!" withTitle:@"Error"];
    [self setActivityIndicatorForView:NO];
}




#pragma mark - UICollectionViewDelegate
-(void)didRefreshCollectionView {
        // refresh collection view data
    [self.collectionViewDataCenter refreshDataForCollectionView];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionViewDataCenter CountForCollectionViewCell];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        // CollevtionView Cell
    CollectionViewCell *cellCollectionView = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    __block Photo  *photo = [self.collectionViewDataCenter getPhotoDataForIndexPath:indexPath] ;
    [cellCollectionView.activityIndicator startAnimating];
    
    // load photo images in the background
    __weak FeedMasterViewController *weakSelf = self;
    cellCollectionView.imgViewCell.image = nil;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        @autoreleasepool {
            UIImage *image = photo.imgThumbnailImage;
            photo = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                // then set Photo thumbnail image via the main queue if the cell is still visible.
                
                if ([weakSelf.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                    CollectionViewCell *cell =
                    (CollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:indexPath];
                    cell.imgViewCell.image = image;
                    [cell.activityIndicator stopAnimating];
                }
            });
        }
    }];
    
    [self.thumbnailQueue addOperation:operation];
    return cellCollectionView;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"LightBoxSegue" sender:self];
}

#pragma mark - Scroll View

-(void)scrollViewDidScroll: (UIScrollView*)scrollView {
        // add next page 
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset + scrollViewHeight == scrollContentSizeHeight) {
        [self.collectionViewDataCenter getDataForCollectionViewForTags:@"shark"];
    }
}


@end
