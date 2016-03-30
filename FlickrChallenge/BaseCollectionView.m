//
//  BaseCollectionViewLayout.m
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "BaseCollectionView.h"
#import "CustomRefreshView.h"

@implementation BaseCollectionView

#pragma mark - Lifecycle

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor blackColor];
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    UIView *view = [CustomRefreshView viewForRefreshView];
    self.refreshControl.frame = view.frame;
    [self.refreshControl insertSubview:view atIndex:0];
    [self.refreshControl addTarget:self action:@selector(setupRefreshControl)
             forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.refreshControl];
}

#pragma mark - Action Methods RefreshView  
-(void)setupRefreshControl {
    [self.baseCollectionViewDelegate didRefreshCollectionView];
}



@end
