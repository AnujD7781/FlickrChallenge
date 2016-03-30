//
//  CollectionViewDataCenter.h
//  CollectionViewTrial
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

/*
    Implement CollectionViewDataCenterDelegate to get notification for data and error revceived for any first/refresh/update.
 */
@protocol CollectionViewDataCenterDelegate;

@interface CollectionViewDataCenter : NSObject

@property (nonatomic, weak) id<CollectionViewDataCenterDelegate> delegate;


/*
    Pass tags required to first get data for collectionView.
 */
-(void)getDataForCollectionViewForTags:(NSString*)tags;

/*
    Use this method to get next page information.
 */
-(void)getDataForNextPageCollectionView;

/*
 Use this method to refresh data for collectionView.
 */
-(void)refreshDataForCollectionView;

/*
    Use method to get count for collectionView cells.
 */
-(NSUInteger)CountForCollectionViewCell;

/*
    Pass indexPath to get Photo model at any indexPath.row
 */
-(Photo*)getPhotoDataForIndexPath:(NSIndexPath*)indexPath;

@end
@protocol CollectionViewDataCenterDelegate <NSObject>
@required
-(void)didGetDataForCollectionView;
-(void)didGetError;
@optional


@end