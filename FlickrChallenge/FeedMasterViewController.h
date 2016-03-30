//
//  TrialViewControllerShark.h
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewDataCenter.h"
#import "BaseViewController.h"
#import "BaseCollectionView.h"

@interface FeedMasterViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, CollectionViewDataCenterDelegate, BaseCollectionViewDelegate>

@end
