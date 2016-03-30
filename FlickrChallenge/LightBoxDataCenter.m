//
//  LightBoxDataCenter.m
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "LightBoxDataCenter.h"
#import "NetworkHTTPClient.h"
#import "DataModeler.h"

static NSString *baseURL = @"https://api.flickr.com/services/rest/?";
static NSString *method = @"flickr.photos.getInfo";
static NSString *api_key = @"949e98778755d1982f537d56236bbb42";
static NSString *tags = @"shark";
static NSString *format = @"json";
static NSString *nojsoncallback = @"1";
static NSString *extras = @"url_t,url_c,url_l,url_o";

static LightBoxDataCenter *sharedInstance = nil;

@interface LightBoxDataCenter () {
    PhotoDetails *imgDetailsDataModel;
}

@end
@implementation LightBoxDataCenter
/*
+(LightBoxDataCenter*)getSharedInstance{
    if (!sharedInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[super allocWithZone:NULL]init];
        });
    }
    return sharedInstance;
}*/


#pragma mark - Light Box Data Center Methods

-(void)getImageDetailsDataForPhoto:(Photo*)photo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NetworkHTTPClient *nwHelper = [[NetworkHTTPClient alloc]init];
        
        [nwHelper getDataFromURL:[NSURL URLWithString:[self urlForPhoto:photo]] onSuccess:^(NSData *data) {
            [self processDataForImageDetailsView:data];
        } onFailure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didGetError:error];
            });
        }];
        
        nwHelper = nil;
    });
}


#pragma mark - Helper Methods for Light Box Data Center 

-(NSString*)urlForPhoto:(Photo*)photo {
    return [NSString stringWithFormat:@"%@method=%@&api_key=%@&photo_id=%@&format=%@&nojsoncallback=%@",baseURL,method,api_key,photo.photoId,format,nojsoncallback];
}

-(void)processDataForImageDetailsView:(NSData*)data {
    [DataModeler parseDataForImageDetails:data onSuccess:^(PhotoDetails *dict) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // then set them via the main queue if the cell is still visible.
            [self.delegate didReceiveDataForImageDetailsView:dict];
        });
    } onFailure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // then set them via the main queue if the cell is still visible.
            [self.delegate didGetError:error];
        });
    }];
}

@end
