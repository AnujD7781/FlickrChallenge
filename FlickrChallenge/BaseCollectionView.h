//
//  BaseCollectionViewLayout.h
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 implement BaseCollectionViewDelegate to get action for pull down refresh 
 */
@protocol BaseCollectionViewDelegate;

@interface BaseCollectionView : UICollectionView

@property (nonatomic, weak) id<BaseCollectionViewDelegate> baseCollectionViewDelegate;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@protocol BaseCollectionViewDelegate <NSObject>
@required
-(void)didRefreshCollectionView;
@optional



@end
