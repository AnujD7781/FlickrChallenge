//
//  NetworkHelper.m
//  CollectionViewTrial
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "NetworkHTTPClient.h"

@implementation NetworkHTTPClient
#pragma mark - Network get data Method
- (void)getDataFromURL:(NSURL *) url
             onSuccess:(void(^)(NSData *data))success
             onFailure:(void (^)(NSError *error))failureBlock {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Create url connection and fire request
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            success(data);
        }
        
    }] resume];
    
    request = nil;
}




@end
