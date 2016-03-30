
//
//  CollectionViewDataCenter.m
//  CollectionViewTrial
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "CollectionViewDataCenter.h"
#import "NetworkHTTPClient.h"
#import "DataModeler.h"
static NSString *baseURL = @"https://api.flickr.com/services/rest/?";
static NSString *method = @"flickr.photos.search";
static NSString *api_key = @"949e98778755d1982f537d56236bbb42";
static NSString *format = @"json";
static NSString *nojsoncallback = @"1";
static NSString *extras = @"url_t,url_c,url_l,url_o";

@interface CollectionViewDataCenter ()  {
    NSMutableArray *arrCollectionViewDataSrc;
    NSString *tags;
    long downloadedPages;
    long totalPages;
    BOOL isRefreshing;
}

@end

@implementation CollectionViewDataCenter


#pragma mark - Data Center Methods
-(void)getDataForCollectionViewForTags:(NSString*)strTags {
    tags = strTags;
    if (totalPages >= downloadedPages) {
        if (arrCollectionViewDataSrc==nil) {
            arrCollectionViewDataSrc = [NSMutableArray new];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NetworkHTTPClient *nwHelper = [[NetworkHTTPClient alloc]init];
            [nwHelper getDataFromURL:[self urlForNextPage] onSuccess:^(NSData *data) {
                downloadedPages ++;
                [self processDataForCollectionView:data];
            } onFailure:^(NSError *error) {
                [self didGetError:error];
            }];
        });
    }
    
}

-(void)getDataForNextPageCollectionView {
    [self getDataForCollectionViewForTags:tags];
}

-(void)refreshDataForCollectionView {
    downloadedPages = 0;
    isRefreshing = YES;
    [self getDataForCollectionViewForTags:tags];
}

-(NSUInteger)CountForCollectionViewCell {
    if (arrCollectionViewDataSrc==nil) {
        return 0;
    }
    return arrCollectionViewDataSrc.count;
}

-(Photo*)getPhotoDataForIndexPath:(NSIndexPath*)indexPath {
    @autoreleasepool {
        Photo *photos =[arrCollectionViewDataSrc objectAtIndex:indexPath.row];
        return photos;
    }
    
}

#pragma mark - Helper Methods
-(NSURL*)urlForNextPage {
    @autoreleasepool {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@method=%@&api_key=%@&tags=%@&format=%@&nojsoncallback=%@&page=%ld&extras=%@",baseURL,method,api_key,tags,format,nojsoncallback,downloadedPages+1,extras]];
    }
}

-(void)didGetError:(NSError*)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate didGetError];
    });
}

// Method processes data and return nsarray by invoking main thread
-(void)processDataForCollectionView:(NSData*)data {
    [DataModeler parseDataForCollectionView:data onSuccess:^(NSDictionary *data) {
        if (isRefreshing && arrCollectionViewDataSrc.count >0) {
            [arrCollectionViewDataSrc removeAllObjects];
            isRefreshing =NO;
        }
        totalPages= [[data objectForKey:@"pages"] longValue];
        [arrCollectionViewDataSrc addObjectsFromArray:[data objectForKey:@"photo"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didGetDataForCollectionView];
        });
    } onFailure:^(NSError *error) {
        [self didGetError:error];
    }];
}




@end
