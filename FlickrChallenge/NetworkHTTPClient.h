//
//  NetworkHTTPClient
//  CollectionViewTrial
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHTTPClient : NSObject

/*
    Pass URL, success blocks and failure blocks. invoke mainqueue before before updating anything on UI.
 */
- (void)getDataFromURL:(NSURL *) url
             onSuccess:(void(^)(NSData *data))success
             onFailure:(void (^)(NSError *error))failureBlock;

@end
