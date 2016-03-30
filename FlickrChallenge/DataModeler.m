//
//  DataModeler.m
//  CollectionViewTrial
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "DataModeler.h"
#import "Photo.h"

@implementation DataModeler
#pragma mark - parse Data for CollectionView Data Center
+ (void)parseDataForCollectionView:(NSData *) data onSuccess:(void(^)(NSDictionary *dict))success onFailure:(void (^)(NSError *error))failureBlock {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error) {
        failureBlock(error);
    } else {
        NSMutableDictionary* latestLoans = [[json objectForKey:@"photos"] mutableCopy];
        NSArray *arr = [latestLoans valueForKey:@"photo"];
        NSMutableArray *newArr = [NSMutableArray new];
        for (NSDictionary* dict in arr ) {
            Photo *photo = [Photo new];
            [photo initWithDictionary:dict];
            [newArr addObject:photo];
        }
        [latestLoans setObject:newArr forKey:@"photo"];
        success(latestLoans);
    }
}


#pragma mark - parse Data for Detail Data Center
+ (void)parseDataForImageDetails:(NSData *) data onSuccess:(void(^)(PhotoDetails *dict))success onFailure:(void (^)(NSError *error))failureBlock {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error) {
        failureBlock(error);
    } else {
        //NSMutableDictionary* latestLoans = [[json objectForKey:@"photos"] mutableCopy];
        PhotoDetails *imgDetailsDataModel = [[PhotoDetails alloc]init];
        [imgDetailsDataModel initWithDictionary:json];
        success(imgDetailsDataModel);
    }
}
@end
